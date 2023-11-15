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
                Value : Product.ProductID,
                Label : 'ProductID',
            },
            {
                $Type : 'UI.DataField',
                Value : BusinessPartner.BusinessPartnerID,
                Label : 'BusinessPartnerID',
            }
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
                Value : BusinessPartner.WebAddress,
                Label : 'Website',
            },],
    }
);

annotate service.PurchaseOrders with @odata.draft.enabled;

//annotation to hide the update and delete buttons
annotate service.PurchaseOrders with @(
    UI.UpdateHidden : true,
    UI.DeleteHidden : true
);

annotate service.Products with {
    ProductID @Common.Text : {
            $value : Name,
            ![@UI.TextArrangement] : #TextLast,
        }
};
annotate service.Products with {
    ProductID @UI.MultiLineText : false
};
annotate service.Products with {
    ProductID @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ProductID,
                    ValueListProperty : 'ProductID',
                },
            ],
            Label : 'Product Search',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.BusinessPartners with {
    BusinessPartnerID @Common.Text : {
            $value : CompanyName,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.BusinessPartners with {
    BusinessPartnerID @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BusinessPartners',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : BusinessPartnerID,
                    ValueListProperty : 'BusinessPartnerID',
                },
            ],
            Label : 'Business partner search',
        },
        Common.ValueListWithFixedValues : true
)};
