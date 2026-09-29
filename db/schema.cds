namespace warehouse.inventory;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';


entity Categories : cuid, managed {
    name        : localized String(100) @mandatory;
    description : localized String(500);

    products    : Association to many Products
                      on products.category = $self;
}


entity Products : cuid, managed {
    stockKeepingUnit : String(50) @mandatory;

    name        : localized String(150) @mandatory;
    description : localized String(500);

    category         : Association to Categories;
    unitPrice        : Decimal(13, 2);
    unit             : String(20);
    minimumStock     : Integer default 0;
    active           : Boolean default true;

    stocks           : Association to many Stocks
                           on stocks.product = $self;
}


entity Warehouses : cuid, managed {
    code      : String(20) @mandatory;
    name      : localized String(100) @mandatory;

    address   : String(255);
    city      : String(100);
    active    : Boolean default true;

    stocks    : Association to many Stocks
                    on stocks.warehouse = $self;

    locations : Composition of many WarehouseLocations
                    on locations.warehouse = $self;
}


entity WarehouseLocations : cuid, managed {
    warehouse : Association to Warehouses @mandatory;

    code      : String(30) @mandatory;
    name      : localized String(100);

    zone      : String(30);
    rack      : String(30);
    shelf     : String(30);
}


entity Stocks : cuid, managed {
    product          : Association to Products @mandatory;
    warehouse        : Association to Warehouses @mandatory;
    location         : Association to WarehouseLocations;

    quantity         : Integer default 0;
    reservedQuantity : Integer default 0;
}


entity Suppliers : cuid, managed {
    name    : String(150) @mandatory;
    email   : String(150);
    phone   : String(30);
    address : String(255);
    active  : Boolean default true;

    orders  : Association to many PurchaseOrders
                  on orders.supplier = $self;
}


entity PurchaseOrders : cuid, managed {
    orderNumber : String(30) @mandatory;
    supplier    : Association to Suppliers @mandatory;
    orderDate   : Date;
    status      : String(30) default 'NEW';

    items       : Composition of many PurchaseOrderItems
                      on items.order = $self;
}


entity PurchaseOrderItems : cuid {
    order     : Association to PurchaseOrders;
    product   : Association to Products @mandatory;

    quantity  : Integer @mandatory;
    unitPrice : Decimal(13, 2);
}


entity StockMovements : cuid, managed {
    product       : Association to Products @mandatory;

    fromWarehouse : Association to Warehouses;
    toWarehouse   : Association to Warehouses;

    fromLocation  : Association to WarehouseLocations;
    toLocation    : Association to WarehouseLocations;

    quantity      : Integer @mandatory;
    type          : String(30) @mandatory;

    reference     : String(100);
    movementDate  : Timestamp;
    note          : String(500);
}


entity Currencies : CodeList {
    key code : String(3);
}