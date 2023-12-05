using {sap} from '@sap/cds/common';
using {gwsample as external} from '../srv/external/gwsample';

namespace orders;

entity PurchaseOrders {
    key PurchaseOrderUUID: UUID;
        Units: Integer;
        Date: Date;
        Price: Decimal(13,3);
        Product: Association to Products;
        BusinessPartner: Association to BusinessPartners;
}

entity Products as projection on external.ProductSet;
entity BusinessPartners as projection on external.BusinessPartnerSet; 