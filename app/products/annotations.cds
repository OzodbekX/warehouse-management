using ProductService as service from '../../srv/product-service';

annotate service.Products with @(
    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: '{i18n>StockKeepingUnitSku}',
                Value: stockKeepingUnit,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Name}',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'description',
                Value: description,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>UnitPrice}',
                Value: unitPrice,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Unit1}',
                Value: unit,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>MinimumStock}',
                Value: minimumStock,
            },
            {
                $Type: 'UI.DataField',
                Label: '{i18n>Active}',
                Value: active,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Category',
                Value: category_ID
            }
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
            Label: '{i18n>StockKeepingUnitSku}',
            Value: stockKeepingUnit,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Name}',
            Value: name,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Description1}',
            Value: description,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>UnitPrice}',
            Value: unitPrice,
        },
        {
            $Type: 'UI.DataField',
            Label: '{i18n>Unit}',
            Value: unit,
        },

        {
            $Type : 'UI.DataFieldForAction',
            Action: 'ProductService.getExchangeRate',
            Label : '{i18n>GetExchangeRate1}',
        },
        {
            $Type: 'UI.DataField',
            Value: category.name,
            Label: '{i18n>CategoryName}',
        },
    ],
);

annotate service.Products with {
    category @Common.Text: category.name
             @Common.TextArrangement: #TextOnly
             @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Categories',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: category_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'description',
            },
        ],
    }
};

