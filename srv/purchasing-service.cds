using {warehouse.inventory as db} from '../db/schema';
@requires: 'WarehouseAdmin'
@path: 'purchasing'
service PurchasingService{
    entity Products as projection on db.Products;
    entity Suppliers as projection on db.Suppliers;
    @odata.draft.enabled
    entity PurchaseOrders as projection on db.PurchaseOrders;
    entity PurchaseOrderItems as projection on db.PurchaseOrderItems;
}