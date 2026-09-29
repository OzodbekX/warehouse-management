using {warehouse.inventory as db} from '../db/schema';

@path: 'stock-movements'
@impl: './inventory-service.js'
service StockMovementService {

    @odata.draft.enabled
    entity Stocks         as
        projection on db.Stocks {
            *,
            virtual null as availableQuantity : Integer

        };

    entity StockMovements as projection on db.StockMovements;

    entity WarehouseLocations as projection on db.WarehouseLocations;

    entity Products       as projection on db.Products;

    entity Warehouses     as projection on db.Warehouses;

    action transferStock(product: UUID,
                         fromWarehouse: UUID,
                         toWarehouse: UUID,
                         quantity: Integer) returns String;
}
