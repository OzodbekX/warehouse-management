using ProductService as service from './product-service';
using WarehouseService as warehouse from './warehouse-service';
using StockMovementService as stock from './stock-movement-service';

annotate service.Products with @restrict: [
    {
        grant: 'READ',
        to   : [
            'WarehouseEmployee',
            'WarehouseAdmin'
        ]
    },
    {
        grant: [
            'CREATE',
            'UPDATE',
            'DELETE'
        ],
        to   : 'WarehouseAdmin'
    },
    {
        grant: 'getExchangeRate',
        to   : [
            'WarehouseEmployee',
            'WarehouseAdmin'
        ]
    }
];

annotate service.Categories with @restrict: [
    {
        grant: 'READ',
        to   : [
            'WarehouseEmployee',
            'WarehouseAdmin'
        ]
    },
    {
        grant: [
            'CREATE',
            'UPDATE',
            'DELETE'
        ],
        to   : 'WarehouseAdmin'
    }
];


annotate warehouse.Warehouses with @restrict: [
    {
        grant: 'READ',
        to   : [
            'WarehouseEmployee',
            'WarehouseAdmin'
        ]
    },
    {
        grant: [
            'CREATE',
            'UPDATE',
            'DELETE'
        ],
        to   : 'WarehouseAdmin'

    }
];

annotate warehouse.WarehouseLocations with @restrict: [
    {
        grant: 'READ',
        to   : [
            'WarehouseEmployee',
            'WarehouseAdmin'
        ]
    },
    {
        grant: [
            'CREATE',
            'UPDATE',
            'DELETE'
        ],
        to   : 'WarehouseAdmin'
    }
];

annotate stock.StockMovements with @restrict: [
    {
        grant: 'READ',
        to   : [
            'WarehouseEmployee',
            'WarehouseAdmin'
        ]
    },
    {
        grant: [
            'CREATE',
            'UPDATE',
            'DELETE'
        ],
        to   : 'WarehouseAdmin'
    }
];


annotate stock.Stocks with @restrict: [
    {
        grant: 'READ',
        to   : [
            'WarehouseEmployee',
            'WarehouseAdmin'
        ]
    },
    {
        grant: [
            'CREATE',
            'UPDATE',
            'DELETE'
        ],
        to   : 'WarehouseAdmin'
    }
];

annotate stock.transferStock with @restrict: [{
    grant: 'EXECUTE',
    to   : [
        'WarehouseEmployee',
        'WarehouseAdmin'
    ]
}];
