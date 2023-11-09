using {sap} from '@sap/cds/common';

namespace orders;

entity PurchaseOrders {
    key PurchaseOrderUUID: UUID;
        Units: Integer;
        Date: Date;
        Price: Decimal(13,3);
        // Product: Association to one Products;
        // BusinessPartner: Association to one BusinessPartners;
        // Currency: Association to one Currencies;
}