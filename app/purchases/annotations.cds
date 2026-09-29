using PurchasingService as service from '../../srv/purchasing-service';
annotate service.PurchaseOrders with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : '{i18n>OrderNumber}',
                Value : orderNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : '{i18n>OrderDate}',
                Value : orderDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
            },
            {
                $Type : 'UI.DataField',
                Value : createdBy,
            },
            {
                $Type : 'UI.DataField',
                Value : modifiedBy,
            },
            {
                $Type : 'UI.DataField',
                Value : supplier_ID,
                Label : '{i18n>SupplierName}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
        {
            $Type: 'UI.ReferenceFacet',
            ID: 'Items',
            Label: 'Items',
            Target: 'items/@UI.LineItem',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Number}',
            Value : orderNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>OrderDate}',
            Value : orderDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'status',
            Value : status,
        },
        {
            $Type : 'UI.DataField',
            Value : supplier.email,
            Label : '{i18n>SupplierEmail}',
        },
        {
            $Type : 'UI.DataField',
            Value : supplier.name,
            Label : '{i18n>SupplierName}',
        },
        {
            $Type : 'UI.DataField',
            Value : supplier.phone,
            Label : '{i18n>PurchaserPhone}',
        },
    ],
);

annotate service.PurchaseOrders with {
    supplier @Common.Text: supplier.name
             @Common.TextArrangement: #TextOnly
             @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Suppliers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : supplier_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'phone',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'address',
            },
        ],
    }
};


annotate service.PurchaseOrderItems with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: product_ID, Label: 'Product' },
        { $Type: 'UI.DataField', Value: quantity, Label: 'Quantity' },
        { $Type: 'UI.DataField', Value: unitPrice, Label: 'Unit Price' }
    ],
    UI.FieldGroup #General: {
        Data: [
            { $Type: 'UI.DataField', Value: product_ID, Label: 'Product' },
            { $Type: 'UI.DataField', Value: quantity, Label: 'Quantity' },
            { $Type: 'UI.DataField', Value: unitPrice, Label: 'Unit Price' }
        ]
    },
    UI.Facets: [{ $Type: 'UI.ReferenceFacet', ID: 'General', Label: 'Item', Target: '@UI.FieldGroup#General' }]
);

annotate service.PurchaseOrderItems with {
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
