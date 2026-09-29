sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchases/test/integration/pages/PurchaseOrdersList.gen",
	"purchases/test/integration/pages/PurchaseOrdersObjectPage.gen",
	"purchases/test/integration/pages/PurchaseOrderItemsObjectPage.gen"
], function (JourneyRunner, PurchaseOrdersListGenerated, PurchaseOrdersObjectPageGenerated, PurchaseOrderItemsObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchases') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrdersListGenerated: PurchaseOrdersListGenerated,
			onThePurchaseOrdersObjectPageGenerated: PurchaseOrdersObjectPageGenerated,
			onThePurchaseOrderItemsObjectPageGenerated: PurchaseOrderItemsObjectPageGenerated
        },
        async: true
    });

    return runner;
});

