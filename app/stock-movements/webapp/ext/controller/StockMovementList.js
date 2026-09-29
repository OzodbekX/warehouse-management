sap.ui.define([
    "sap/ui/core/Fragment",
    "sap/m/MessageToast",
    "sap/m/MessageBox"
], function (Fragment, MessageToast, MessageBox) {
    "use strict";

    let oTransferDialog;
    let oModel;

    const oController = {

        onTransferStock: async function () {

            console.log("Transfer Stock clicked");

            oModel = this.getModel();

            if (!oTransferDialog) {

                oTransferDialog = await Fragment.load({
                    id: "transferStockFragment",
                    name: "warehouse.inventory.stockmovements.ext.fragment.TransferStockDialog",
                    controller: oController
                });

                // Important:
                // give the dialog access to the Fiori OData model
                oTransferDialog.setModel(oModel);
            }

            oTransferDialog.open();
        },


        onCancelTransfer: function () {

            if (oTransferDialog) {
                oTransferDialog.close();
            }

        },


        onConfirmTransfer: async function () {

            try {

                // =========================
                // 1. GET SELECTED VALUES
                // =========================

                const sProduct = Fragment.byId(
                    "transferStockFragment",
                    "productSelect"
                ).getSelectedKey();


                const sFromWarehouse = Fragment.byId(
                    "transferStockFragment",
                    "fromWarehouseSelect"
                ).getSelectedKey();


                const sToWarehouse = Fragment.byId(
                    "transferStockFragment",
                    "toWarehouseSelect"
                ).getSelectedKey();


                const iQuantity = Number(
                    Fragment.byId(
                        "transferStockFragment",
                        "quantityInput"
                    ).getValue()
                );


                // =========================
                // 2. FRONTEND VALIDATION
                // =========================

                if (!sProduct) {
                    MessageBox.error(
                        "Please select a product"
                    );
                    return;
                }


                if (!sFromWarehouse) {
                    MessageBox.error(
                        "Please select a source warehouse"
                    );
                    return;
                }


                if (!sToWarehouse) {
                    MessageBox.error(
                        "Please select a destination warehouse"
                    );
                    return;
                }


                if (!iQuantity || iQuantity <= 0) {
                    MessageBox.error(
                        "Quantity must be greater than 0"
                    );
                    return;
                }


                if (sFromWarehouse === sToWarehouse) {
                    MessageBox.error(
                        "Source and destination warehouses cannot be the same"
                    );
                    return;
                }


                console.log("Calling transferStock...");

                console.log({
                    product: sProduct,
                    fromWarehouse: sFromWarehouse,
                    toWarehouse: sToWarehouse,
                    quantity: iQuantity
                });


                // =========================
                // 3. CAP ACTION
                // =========================

                const oAction = oModel.bindContext(
                    "/transferStock(...)"
                );


                // =========================
                // 4. SET PARAMETERS
                // =========================

                oAction.setParameter(
                    "product",
                    sProduct
                );

                oAction.setParameter(
                    "fromWarehouse",
                    sFromWarehouse
                );

                oAction.setParameter(
                    "toWarehouse",
                    sToWarehouse
                );

                oAction.setParameter(
                    "quantity",
                    iQuantity
                );


                // =========================
                // 5. EXECUTE
                // =========================

                await oAction.execute();


                // =========================
                // 6. SUCCESS
                // =========================

                MessageToast.show(
                    "Stock transferred successfully"
                );


                // =========================
                // 7. CLOSE
                // =========================

                oTransferDialog.close();


                // =========================
                // 8. REFRESH
                // =========================

                oModel.refresh();


            } catch (oError) {

                console.error(
                    "Transfer Stock failed:",
                    oError
                );

                MessageBox.error(
                    oError.message ||
                    "Stock transfer failed"
                );

            }

        }

    };


    return oController;

});