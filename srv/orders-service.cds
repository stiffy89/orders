using orders from '../db/orders';

service ordersservice {
    entity PurchaseOrders as select from orders.PurchaseOrders {
        PurchaseOrderUUID,
        Units,
        Date,
        Price @Core.Computed,
        Product,
        BusinessPartner
    };

    entity Products as select from orders.Products {
        ProductID @Core.Computed,
        Name @Core.Computed,
        Price @Core.Computed,
        Category @Core.Computed
    };

    entity BusinessPartners as select from orders.BusinessPartners {
        BusinessPartnerID @Core.Computed,
        CompanyName @Core.Computed,
        EmailAddress @Core.Computed,
        WebAddress @Core.Computed,
        FaxNumber @Core.Computed,
        PhoneNumber @Core.Computed
    };
}