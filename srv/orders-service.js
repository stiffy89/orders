const cds = require('@sap/cds');
const res = require('express/lib/response');


module.exports = cds.service.impl(async function () { 
    //const gwservice = await cds.connect.to('gwsample');
    let srv = this;
    let { PurchaseOrders, Products, BusinessPartners } = this.entities;

    const gwservice = await cds.connect.to('gwsample');

    this.on('READ', 'PurchaseOrders', async(req, next) => {
        //handling expands in our entity

        //if no expands
        if (!req.query.SELECT.columns) {
            return next ();
        }

        let indexObj = {};

        req.query.SELECT.columns.forEach(({expand, ref}, index) => {
            if (expand && (ref[0] === 'Product' || ref[0] === 'BusinessPartner')){

                indexObj[ref[0]] = index;

                //if we find either, just remove it
                req.query.SELECT.columns.splice(index, 1);
            }
        });

        const Product = indexObj.Product;
        const BusinessPartner = indexObj.BusinessPartner;

        //neither is found
        if (!Product && !BusinessPartner){
            return next();
        }

        //make sure Product_ProductID or BusinessPartner_BusinessPartnerID is returned
        if (Product) {
            if (!req.query.SELECT.columns.indexOf("*") >= 0 && !req.query.SELECT.columns.find(column => column.ref && column.ref.find((ref) => ref === 'Product_ProductID'))){
                req.query.SELECT.columns.push({ref:['Product_ProductID']})
            }
        }

        if (BusinessPartner){
            if (!req.query.SELECT.columns.indexOf('*') >= 0 && !req.query.SELECT.columns.find(column => column.ref.find((ref) => ref === 'BusinessPartner_BusinessPartnerID'))){
                req.query.SELECT.columns.push({ref:['BusinessPartner_BusinessPartnerID']})
            }
        }

        //get the results from db
        const orders = await next();

        //convert all results to an array, sometimes single records will come back as an object
        const asArr = x => Array.isArray(x) ? x : [x];

        //get all our product & partner ids
        if(Product){
            const productIDs = asArr(orders).map((order) => {
                return order.Product_ProductID;
            });

            //we need to build the url with the filters to call our external service
            let sProductUrl = "/ProductSet?$filter=";
            productIDs.forEach((x, index, array) => {
                sProductUrl += "ProductID eq '" + x + "'";

                //if its not the last add the OR condition, otherwise leave it out
                if (index < (array.length -1)){
                    sProductUrl += " or ";
                }
            });

            const extProducts = await gwservice.send({
                method: 'GET',
                path: sProductUrl
            });

            //map the ext products back to our database data so we can use it
            const productMap = {};
            for (const product of extProducts){
                productMap[product.ProductID] = product;
            }

            for (const order of asArr(orders)){
                order.Product = productMap[order.Product_ProductID]
            }
        }

        if(BusinessPartner){
            const businessIDs = asArr(orders).map((order) => {
                return order.BusinessPartner_BusinessPartnerID;
            });

            //we need to build the url with the filters to call our external service
            let sPartnerUrl = "/BusinessPartnerSet?$filter=";
            businessIDs.forEach((x, index, array) => {
                sPartnerUrl += "BusinessPartnerID eq '" + x + "'";

                //if its not the last add the OR condition, otherwise leave it out
                if (index < (array.length -1)){
                    sPartnerUrl += " or ";
                }
            });

            const extBusinessPartners = await gwservice.send({
                method: 'GET',
                path: sPartnerUrl
            });

            //map the ext bus partners back to our database data so we can use it
            const partnersMap = {};
            for (const partner of extBusinessPartners){
                partnersMap[partner.BusinessPartnerID] = partner;
            }

            for (const order of asArr(orders)){
                order.BusinessPartner = partnersMap[order.BusinessPartner_BusinessPartnerID]
            }
        }
        
        return orders;
    });

    this.on('READ', Products, async(req, next) => {
        //look at the request coming through
        const queryOptions = req._queryOptions;
        
        if (!queryOptions) return [];

        //we are only interested if there is a $search query
        if (queryOptions['$search']){
            let sQueryStr = queryOptions['$search'].replace(/['"]+/g, '');
            let sUrl = "/ProductSet?$filter=substringof('"+sQueryStr+"', Name) eq true&$inlinecount=allpages";
            let results = await gwservice.send({
                method: 'GET',
                path: sUrl
            });

            return results;
        }
        else {
            let sUrl = "/ProductSet?$inlinecount=allpages";
            let results = await gwservice.send({
                method: 'GET',
                path: sUrl
            });

            return results;
        }
    });

    this.on('READ', BusinessPartners, async(req, next) => {
        //look at the query options coming through and build our url string
        const queryOptions = req._queryOptions;
        
        if (!queryOptions) return [];

        //we are only interested if there is a $search query
        if (queryOptions['$search']){
            let sQueryStr = queryOptions['$search'].replace(/['"]+/g, '');
            let sUrl = "/BusinessPartnerSet?$filter=substringof('"+sQueryStr+"', CompanyName) eq true&$inlinecount=allpages";
            let results = await gwservice.send({
                method: 'GET',
                path: sUrl
            });

            return results;
        }
        else {
            let sUrl = "/BusinessPartnerSet?$inlinecount=allpages";
            let results = await gwservice.send({
                method: 'GET',
                path: sUrl
            });

            return results;
        }

    });

    this.after('NEW', PurchaseOrders.drafts, async(res, req) => {
        //default the date value to today and update the new record
        let sDate = (new Date()).toISOString().split('T')[0];
        try {
            await UPDATE(PurchaseOrders.drafts).with({
                Date: sDate
            }).where({PurchaseOrderUUID : res.PurchaseOrderUUID});
        } catch (error) {
            req.error({
                message: "Error defaulting the values on a new"
            })
        }
    });


})