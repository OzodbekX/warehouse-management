using { warehouse.inventory as db } from '../db/schema';

@path: 'products'
service ProductService {

    type ExchangeRateResult {
        sourceCurrency : String;
        targetCurrency : String;
        rate           : Decimal(15,4);
    }
    @odata.draft.enabled
    entity Products as projection on db.Products actions {

        action getExchangeRate(
            targetCurrency : String @Common.ValueList : {
                CollectionPath : 'Currencies',
                Parameters : [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        LocalDataProperty : targetCurrency,
                        ValueListProperty : 'code'
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'name'
                    }
                ]
            }
        ) returns ExchangeRateResult;
    };

    entity Categories as projection on db.Categories;

    @readonly
    entity Currencies as projection on db.Currencies;
}