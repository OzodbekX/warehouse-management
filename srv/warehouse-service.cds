using {warehouse.inventory as db} from '../db/schema';

@path: 'warehouses'
service WarehouseService {
    entity Warehouses         as projection on db.Warehouses;
    entity WarehouseLocations as projection on db.WarehouseLocations;
}
