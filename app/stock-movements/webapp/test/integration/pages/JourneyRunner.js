sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"warehouse/inventory/stockmovements/test/integration/pages/StocksList.gen",
	"warehouse/inventory/stockmovements/test/integration/pages/StocksObjectPage.gen"
], function (JourneyRunner, StocksListGenerated, StocksObjectPageGenerated) {
    'use strict';

    const runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('warehouse/inventory/stockmovements') + '/test/flp.html#app-preview',
        pages: {
			onTheStocksListGenerated: StocksListGenerated,
			onTheStocksObjectPageGenerated: StocksObjectPageGenerated
        },
        async: true
    });

    return runner;
});

