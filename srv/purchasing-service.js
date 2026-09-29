import cds from "@sap/cds"

class PurchasingService  extends cds.ApplicationService{
    init(){
        const {
            PurchaseOrders,
            PurchaseOrderItems
        } = this.entities;
         this.before(
            ['CREATE', 'UPDATE'],
            PurchaseOrders,
            this.validateOrder
        );
         this.before(
            ['CREATE', 'UPDATE'],
            PurchaseOrderItems,
            this.validateOrderItem
        );

        return super.init();
    }
    validateOrder(req){
        const {orderNumber, status}=req.data;
        if(orderNumber!=null&!orderNumber.trim()){
            req.reject(
                400,
                'Order number can not be empty'
            )
        }
         const allowedStatuses = [
            'NEW',
            'APPROVED',
            'RECEIVED',
            'CANCELLED'
        ];
        if (
            status != null &&
            !allowedStatuses.includes(status)
        ) {
            req.reject(
                400,
                `Invalid order status: ${status}`
            );
        }
    }
    validateOrderItem(req){
        const { quantity, unitPrice } = req.data;
         if (quantity != null && quantity <= 0) {
            req.reject(
                400,
                'Order quantity must be greater than 0'
            );
        }
        if (unitPrice != null && unitPrice < 0) {
            req.reject(
                400,
                'Unit price cannot be negative'
            );
        }

    }

}
export default PurchasingService