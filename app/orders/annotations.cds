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
                Value : Product_ProductID,
                Label : 'ProductID',
            },
            {
                $Type : 'UI.DataField',
                Value : BusinessPartner_BusinessPartnerID,
                Label : 'PartnerID',
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
    UI.UpdateHidden : true
);

annotate service.PurchaseOrders with {
    Product @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Product_ProductID,
                    ValueListProperty : 'ProductID',
                },
            ],
            Label : 'Products Search',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Products with {
    Name @Common.Text : {
        $value : ProductID,
        ![@UI.TextArrangement] : #TextLast,
    }
};
annotate service.PurchaseOrders with {
    BusinessPartner @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'BusinessPartners',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : BusinessPartner_BusinessPartnerID,
                    ValueListProperty : 'BusinessPartnerID',
                },
            ],
            Label : 'Business Partner Search',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.BusinessPartners with {
    CompanyName @Common.Text : {
        $value : BusinessPartnerID,
        ![@UI.TextArrangement] : #TextLast,
    }
};
annotate service.PurchaseOrders with @(
    UI.HeaderInfo : {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
    }
);

//properties need to be '' where as entities are not as demonstrated below
//source properties are what is inputed
//target is what needs to be effected after the source has been changed
annotate service.PurchaseOrders @(Common : {
    SideEffects #ProductChanged : {
        SourceProperties : ['Product_ProductID'],
        TargetEntities   : [Product],
        TargetProperties : ['Price']
    }
});

annotate service.PurchaseOrders @(Common : {
    SideEffects #BusinessChanged : {
        SourceProperties : ['BusinessPartner_BusinessPartnerID'],
        TargetEntities   : [BusinessPartner]
    }
});

annotate service.PurchaseOrders @(Common : {
    SideEffects #UnitsChanged : {
        SourceProperties : ['Units'],
        TargetProperties   : ['Price']
    }
});



annotate service.Products with {
    ProductID @Common.Text : {
        $value : Name,
        ![@UI.TextArrangement] : #TextFirst,
    }
};
annotate service.BusinessPartners with {
    BusinessPartnerID @Common.Text : {
        $value : CompanyName,
        ![@UI.TextArrangement] : #TextFirst,
    }
};
