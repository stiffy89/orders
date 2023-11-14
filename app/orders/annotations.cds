using ordersservice as service from '../../srv/orders-service';

annotate service.PurchaseOrders with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Units',
            Value : Units,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Date',
            Value : Date,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Total Price',
            Value : Price,
        },
        {
            $Type : 'UI.DataField',
            Value : Product.Name,
            Label : 'Product Name',
        },
        {
            $Type : 'UI.DataField',
            Value : BusinessPartner.CompanyName,
            Label : 'Partner Name',
        },
    ]
);
annotate service.PurchaseOrders with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'Units',
                Value : Units,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Date',
                Value : Date,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Total Price',
                Value : Price,
            },
            {
                $Type : 'UI.DataField',
                Value : Product.Name,
                Label : 'Product',
            },
            {
                $Type : 'UI.DataField',
                Value : BusinessPartner.CompanyName,
                Label : 'Partner',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'Purchase Order',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Product',
            ID : 'Product',
            Target : '@UI.FieldGroup#Product',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Partner',
            ID : 'Partner',
            Target : '@UI.FieldGroup#Partner',
        },
    ]
);
annotate service.PurchaseOrders with @(
    UI.FieldGroup #Product : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Product.Name,
                Label : 'Product Name',
            },{
                $Type : 'UI.DataField',
                Value : Product.Price,
                Label : 'Unit Price',
            },{
                $Type : 'UI.DataField',
                Value : Product.Category,
                Label : 'Product Category',
            },],
    }
);
annotate service.PurchaseOrders with @(
    UI.FieldGroup #Partner : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : BusinessPartner.CompanyName,
                Label : 'Partner Name',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.EmailAddress,
                Label : 'Email',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.FaxNumber,
                Label : 'FaxNumber',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.PhoneNumber,
                Label : 'Phone',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.Address_Building,
                Label : 'Address_Building',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.Address_City,
                Label : 'City',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.Address_Country,
                Label : 'Country',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.Address_PostalCode,
                Label : 'Address_PostalCode',
            },{
                $Type : 'UI.DataField',
                Value : BusinessPartner.Address_Street,
                Label : 'Street',
            },],
    }
);
