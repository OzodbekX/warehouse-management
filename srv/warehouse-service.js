import cds from '@sap/cds'
class WarehouseService extends cds.ApplicationService{
    init(){
        const {Warehouses,WarehouseLocations} = this.entities;
        this.before(
            ['CREATE', 'UPDATE'],
            Warehouses,
            this.validateWarehouse
        );

        this.before(
            ['CREATE', 'UPDATE'],
            WarehouseLocations,
            this.validateLocation
        );

        return super.init();
    }
    validateWarehouse(req){
        const {code, name} =req.data;
        if (code != null && !code.trim()) {
            req.reject(
                400,
                'Warehouse code cannot be empty'
            );
        }

        if (name != null && !name.trim()) {
            req.reject(
                400,
                'Warehouse name cannot be empty'
            );
        }
    }
    validateLocation(req) {

        const { code } = req.data;

        if (code != null && !code.trim()) {
            req.reject(
                400,
                'Location code cannot be empty'
            );
        }
    }

}
export default WarehouseService