using orders from '../db/orders';

service ordersservice {
    entity PurchaseOrders as projection on orders.PurchaseOrders;
    entity Products as projection on orders.Products;
    entity BusinessPartners as projection on orders.BusinessPartners;
}

annotate ordersservice.PurchaseOrders with @odata.draft.enabled;