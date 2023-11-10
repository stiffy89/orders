using orders from '../db/orders';

service ordersservice {
    entity PurchaseOrders as projection on orders.PurchaseOrders;
}

//annotate ordersservice.PurchaseOrders with @odata.draft.enabled;