using StockMovementService as service from '../../srv/stock-movement-service';

annotate service.Stocks with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: product_ID,
                Label: '{i18n>ProductName}',
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Quantity}',
                Value: quantity,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>TeservedQuantity}',
                Value: reservedQuantity,
            },
            {
                $Type: 'UI.DataField',
                Value: location_ID,
                Label: '{i18n>ProductLocation}',
            },
            {
                $Type: 'UI.DataField',
                Value: warehouse_ID,
                Label: '{i18n>WarehouseName}',
            },
            {
                $Type: 'UI.DataField',
                Value: availableQuantity,
                Label: '{i18n>AvailableQuantity}',
            },
        ],
    },
    UI.Facets                    : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'GeneratedFacet1',
        Label : 'General Information',
        Target: '@UI.FieldGroup#GeneratedGroup',
    }, ],
    UI.LineItem                  : [
        {
            $Type: 'UI.DataField',
            Value: product.name,
            Label: '{i18n>ProductName}',
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Quantity}',
            Value: quantity,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>ReservedQuantity}',
            Value: reservedQuantity,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>AvailableQuantity}',
            Value: availableQuantity,
        },
        {
            $Type: 'UI.DataField',
            Value: warehouse.name,
            Label: '{i18n>WerhouseName}',
        },
    ],
    UI.HeaderInfo                : {
        Title         : {
            $Type: 'UI.DataField',
            Value: product.name,
        },
        TypeName      : '',
        TypeNamePlural: '',
    },
    Analytics.AggregatedProperty #quantity_sum : {
        $Type : 'Analytics.AggregatedPropertyType',
        Name : 'quantity_sum',
        AggregatableProperty : quantity,
        AggregationMethod : 'sum',
        @Common.Label : '{i18n>QuantitySum}',
    },
    UI.Chart #alpChart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Dimensions : [
            warehouse_ID,
        ],
        DynamicMeasures : [
            '@Analytics.AggregatedProperty#quantity_sum',
        ],
        Title : '{i18n>StockQuantityByWarehouse}',
    },
);

annotate service.Stocks with {
    location @Common.Text: location.name
             @Common.TextArrangement: #TextOnly
             @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'WarehouseLocations',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: location_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'code',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'zone',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'rack',
            },
        ],
    }
};

annotate service.Stocks with @Aggregation.ApplySupported: {
    Transformations       : [
        'aggregate',
        'topcount',
        'bottomcount',
        'identity',
        'concat',
        'groupby',
        'filter',
        'expand',
        'search'
    ],
    Rollup                : #None,
    PropertyRestrictions  : true,

    GroupableProperties   : [
        product_ID,
        warehouse_ID,
        location_ID,
    ],

    AggregatableProperties: [
        {Property: quantity},
        {Property: reservedQuantity}
    ]
};
annotate service.Stocks with {
    warehouse @Common.Label : 'Warehouse'
};


annotate service.Stocks with {
    availableQuantity @Core.Computed: true;
};

annotate service.Stocks with {
    product @Common.Text: product.name
        @Common.TextArrangement: #TextOnly
        @Common.ValueList: {
            CollectionPath: 'Products',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut', LocalDataProperty: product_ID, ValueListProperty: 'ID' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' }
            ]
        };
};

annotate service.Stocks with {
    warehouse @Common.Text: warehouse.name
        @Common.TextArrangement: #TextOnly
        @Common.ValueList: {
            CollectionPath: 'Warehouses',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut', LocalDataProperty: warehouse_ID, ValueListProperty: 'ID' },
                { $Type: 'Common.ValueListParameterDisplayOnly', ValueListProperty: 'name' }
            ]
        };
};
