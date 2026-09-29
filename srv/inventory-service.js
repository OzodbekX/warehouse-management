import cds from '@sap/cds';

class InventoryService extends cds.ApplicationService {
    init() {
        const { Stocks } = this.entities;
        this.before(['CREATE', 'UPDATE'], Stocks, this.validateStock);

        this.after('READ', Stocks, this.calculateAvailableStock);
        this.on("transferStock", (req) => this.handleTransferStock(req));
        return super.init();
    }
    validateStock(req) {
        const { quantity, reservedQuantity } = req.data;
        if (quantity != null && quantity < 0) {
            req.reject(400, 'Quantity cannot be negative');

        }
        if (reservedQuantity != null && reservedQuantity < 0) {
            req.reject(400, 'Reserved quantity cannot be negative');
        }
        if (
            quantity != null &&
            reservedQuantity != null &&
            reservedQuantity > quantity
        ) {
            req.reject(400, 'Reserved quantity cannot exceed quantity');
        }

    }
    calculateAvailableStock(results) {
        const stocks = Array.isArray(results) ? results : [results];

        for (const stock of stocks) {
            stock.availableQuantity =
                stock.quantity - stock.reservedQuantity;
        }
    }
    async handleTransferStock(req) {
        console.log("TRANSFER REQUEST:", req.data);

        const {
            product,
            fromWarehouse,
            toWarehouse,
            quantity
        } = req.data;
        if (!product) {
            return req.reject(400, 'Product is required');
        }

        if (!fromWarehouse) {
            return req.reject(400, 'Source warehouse is required');
        }

        if (!toWarehouse) {
            return req.reject(400, 'Destination warehouse is required');
        }

        if (!quantity || quantity <= 0) {
            return req.reject(
                400,
                'Transfer quantity must be greater than 0'
            );
        }

        if (fromWarehouse === toWarehouse) {
            return req.reject(
                400,
                'Source and destination warehouses cannot be the same'
            );
        }
        const sourceStock = await SELECT.one
            .from('warehouse.inventory.Stocks')
            .where({
                product_ID: product,
                warehouse_ID: fromWarehouse
            });

        if (!sourceStock) {
            return req.reject(
                404,
                'Product does not exist in source warehouse'
            );
        }

        const availableQuantity =
            sourceStock.quantity -
            sourceStock.reservedQuantity;

        if (availableQuantity < quantity) {

            return req.reject(
                400,
                `Not enough stock. Available: ${availableQuantity}`
            );
        }

        const destinationStock = await SELECT.one
            .from('warehouse.inventory.Stocks')
            .where({
                product_ID: product,
                warehouse_ID: toWarehouse
            });

        await UPDATE('warehouse.inventory.Stocks')
            .set({
                quantity:
                    sourceStock.quantity - quantity
            })
            .where({
                ID: sourceStock.ID
            });

        if (destinationStock) {

            await UPDATE('warehouse.inventory.Stocks')
                .set({
                    quantity:
                        destinationStock.quantity + quantity
                })
                .where({
                    ID: destinationStock.ID
                });

        } else {

            await INSERT
                .into('warehouse.inventory.Stocks')
                .entries({
                    product_ID: product,
                    warehouse_ID: toWarehouse,
                    quantity: quantity,
                    reservedQuantity: 0
                });
        }

        await INSERT
            .into('warehouse.inventory.StockMovements')
            .entries({
                product_ID: product,

                fromWarehouse_ID: fromWarehouse,
                toWarehouse_ID: toWarehouse,

                quantity: quantity,

                type: 'TRANSFER',

                movementDate: new Date().toISOString()
            });


        return `Successfully transferred ${quantity} items`;
    }

}
export default InventoryService;