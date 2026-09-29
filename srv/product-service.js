import cds from '@sap/cds';

export default class ProductService extends cds.ApplicationService {

    async init() {
        const { Products } = this.entities;

        this.before(
            ['CREATE', 'UPDATE'],
            Products,
            this.validateBeforeSave
        );

        // IMPORTANT: Products makes this a bound action handler
        this.on(
            'getExchangeRate',
            Products,
            this.handleGetExchangeRate
        );

        return super.init();
    }

    validateBeforeSave(req) {
        const { unitPrice, minimumStock } = req.data;

        if (unitPrice != null && unitPrice < 0) {
            return req.reject(400, 'Unit price cannot be negative');
        }

        if (minimumStock != null && minimumStock < 0) {
            return req.reject(400, 'Minimum stock cannot be negative');
        }
    }
    async handleGetExchangeRate(req) {
        console.log('ACTION CALLED', req.data);
        console.log('PARAMS', req.params);

        const { targetCurrency } = req.data;
        const sourceCurrency = 'USD';

        if (!targetCurrency) {
            return req.reject(400, 'Target currency is required');
        }

        try {
            // Selected Product ID
            const productId = req.params[0].ID;

            // Get selected product
            const product = await SELECT.one
                .from(this.entities.Products)
                .where({ ID: productId });

            if (!product) {
                return req.reject(404, 'Product not found');
            }

            const url =
                `https://api.frankfurter.app/latest?from=${sourceCurrency}&to=${targetCurrency}`;

            const response = await fetch(url);

            if (!response.ok) {
                return req.reject(
                    502,
                    'Exchange rate API request failed'
                );
            }

            const data = await response.json();
            const rate = data.rates[targetCurrency];

            if (!rate) {
                return req.reject(
                    404,
                    `Exchange rate ${sourceCurrency} → ${targetCurrency} not found`
                );
            }

            // Calculate converted product price
            const convertedPrice =
                Number(product.unitPrice) * Number(rate);

            // Fiori message
            req.notify(
                200,
                `${product.name}: ${product.unitPrice} USD = ${convertedPrice.toFixed(2)} ${targetCurrency}`
            );

            return {
                sourceCurrency,
                targetCurrency,
                rate
            };

        } catch (error) {
            console.error('Exchange Rate API Error:', error);

            return req.reject(
                500,
                'Could not retrieve exchange rate'
            );
        }
    }
}