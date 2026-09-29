# Warehouse Management Postman collection

Import `warehouse-management.postman_collection.json` into Postman using **Import > Files**.

1. Start the application with `npm start`.
2. Set collection variable `baseUrl` to your server origin (default `http://localhost:4004`), without a trailing slash. Requests add `/odata/v4`.
3. The collection inherits Basic authentication using `username` and `password`, both defaulting to the configured development user `admin`. Update authentication for other deployments. The full run requires the WarehouseAdmin role.
4. Run all folders in their listed order, one iteration. The first request initializes fresh UUIDs and a run tag. No environment import is needed; avoid environment variables that override collection variables.
5. Inspect Test Results. Negative tests expect HTTP 400 or 404.

The 125 requests cover all four active services: products, warehouses, purchasing, and stock-movements. Coverage includes service documents and metadata, explicitly exposed entity sets, CRUD, purchase order composition navigation and direct item access, currencies, stock-service product and warehouse lookups, queries, stock availability, both transfer destination branches, audit records, and validation errors.

The bound action `POST /odata/v4/products/Products({{productId}})/ProductService.getExchangeRate` uses `targetCurrency` (default EUR). Its success request is skipped by default because the handler calls the external Frankfurter API. Set `runExchangeRate` to `true` to include it with internet access; use a Postman version supporting `pm.execution.skipRequest()`. Missing-target validation runs by default. Currencies are read-only.

Run against a development database: the collection writes data. It creates isolated records and deletes them in folder 06. Existing seed records are not targeted. If a run stops early, preserve the collection variables and run cleanup before initializing a new run. Direct stock movement CRUD only records a movement; transferStock changes balances.

## Verification

Verified against the current application on an isolated in-memory CAP database: **124 requests and 197 assertions passed**, including stock transfers and cleanup. Verification used a Node HTTP runner executing collection scripts with a compatible subset of the Postman assertion API, not Postman/Newman. The optional external exchange-rate success request was not executed. The earlier transfer-handler crash no longer reproduces.
