sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'ns/orders/test/integration/FirstJourney',
		'ns/orders/test/integration/pages/PurchaseOrdersList',
		'ns/orders/test/integration/pages/PurchaseOrdersObjectPage'
    ],
    function(JourneyRunner, opaJourney, PurchaseOrdersList, PurchaseOrdersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('ns/orders') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onThePurchaseOrdersList: PurchaseOrdersList,
					onThePurchaseOrdersObjectPage: PurchaseOrdersObjectPage
                }
            },
            opaJourney.run
        );
    }
);