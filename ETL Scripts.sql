USE [AdventureBikesDWIUWS26]
GO

--ETL Scripts
--[CORE].[usp_LoadCustomer]


CREATE OR ALTER PROCEDURE [CORE].[usp_LoadCustomer]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update existing rows only when values change
        --------------------------------------------------
        UPDATE T
        SET
            T.[PersonID]     = S.[PersonID],
            T.[StoreID]      = S.[StoreID],
            T.[TerritoryID]  = S.[TerritoryID],
            T.[rowguid]      = S.[rowguid],
            T.[ModifiedDate] = S.[ModifiedDate]
        FROM [CORE].[Customer] AS T
        INNER JOIN [STG].[Customer] AS S
            ON T.[CustomerID] = S.[CustomerID]
        WHERE EXISTS
        (
            SELECT
                T.[PersonID],
                T.[StoreID],
                T.[TerritoryID],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[PersonID],
                S.[StoreID],
                S.[TerritoryID],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new rows
        --------------------------------------------------
        SET IDENTITY_INSERT [CORE].[Customer] ON;

        INSERT INTO [CORE].[Customer]
        (
            [CustomerID],
            [PersonID],
            [StoreID],
            [TerritoryID],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[CustomerID],
            S.[PersonID],
            S.[StoreID],
            S.[TerritoryID],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[Customer] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[Customer] AS T
            WHERE T.[CustomerID] = S.[CustomerID]
        );

        SET IDENTITY_INSERT [CORE].[Customer] OFF;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        BEGIN TRY
            SET IDENTITY_INSERT [CORE].[Customer] OFF;
        END TRY
        BEGIN CATCH
            -- Preserve the original error.
        END CATCH;

        THROW;
    END CATCH;
END;
GO


--[CORE].[usp_LoadProduct]


CREATE OR ALTER PROCEDURE [CORE].[usp_LoadProduct]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update only products whose values changed
        --------------------------------------------------
        UPDATE T
        SET
            T.[Name]                 = S.[Name],
            T.[ProductNumber]        = S.[ProductNumber],
            T.[MakeFlag]             = S.[MakeFlag],
            T.[FinishedGoodsFlag]    = S.[FinishedGoodsFlag],
            T.[Color]                = S.[Color],
            T.[SafetyStockLevel]     = S.[SafetyStockLevel],
            T.[ReorderPoint]         = S.[ReorderPoint],
            T.[StandardCost]         = S.[StandardCost],
            T.[ListPrice]            = S.[ListPrice],
            T.[Size]                 = S.[Size],
            T.[SizeUnitMeasureCode]  = S.[SizeUnitMeasureCode],
            T.[WeightUnitMeasureCode]= S.[WeightUnitMeasureCode],
            T.[Weight]               = S.[Weight],
            T.[DaysToManufacture]    = S.[DaysToManufacture],
            T.[ProductLine]          = S.[ProductLine],
            T.[Class]                = S.[Class],
            T.[Style]                = S.[Style],
            T.[ProductSubcategoryID] = S.[ProductSubcategoryID],
            T.[ProductModelID]       = S.[ProductModelID],
            T.[SellStartDate]        = S.[SellStartDate],
            T.[SellEndDate]          = S.[SellEndDate],
            T.[DiscontinuedDate]     = S.[DiscontinuedDate],
            T.[rowguid]              = S.[rowguid],
            T.[ModifiedDate]         = S.[ModifiedDate]
        FROM [CORE].[Product] AS T
        INNER JOIN [STG].[Product] AS S
            ON T.[ProductID] = S.[ProductID]
        WHERE EXISTS
        (
            SELECT
                T.[Name],
                T.[ProductNumber],
                T.[MakeFlag],
                T.[FinishedGoodsFlag],
                T.[Color],
                T.[SafetyStockLevel],
                T.[ReorderPoint],
                T.[StandardCost],
                T.[ListPrice],
                T.[Size],
                T.[SizeUnitMeasureCode],
                T.[WeightUnitMeasureCode],
                T.[Weight],
                T.[DaysToManufacture],
                T.[ProductLine],
                T.[Class],
                T.[Style],
                T.[ProductSubcategoryID],
                T.[ProductModelID],
                T.[SellStartDate],
                T.[SellEndDate],
                T.[DiscontinuedDate],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[Name],
                S.[ProductNumber],
                S.[MakeFlag],
                S.[FinishedGoodsFlag],
                S.[Color],
                S.[SafetyStockLevel],
                S.[ReorderPoint],
                S.[StandardCost],
                S.[ListPrice],
                S.[Size],
                S.[SizeUnitMeasureCode],
                S.[WeightUnitMeasureCode],
                S.[Weight],
                S.[DaysToManufacture],
                S.[ProductLine],
                S.[Class],
                S.[Style],
                S.[ProductSubcategoryID],
                S.[ProductModelID],
                S.[SellStartDate],
                S.[SellEndDate],
                S.[DiscontinuedDate],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new products
        --------------------------------------------------
        SET IDENTITY_INSERT [CORE].[Product] ON;

        INSERT INTO [CORE].[Product]
        (
            [ProductID],
            [Name],
            [ProductNumber],
            [MakeFlag],
            [FinishedGoodsFlag],
            [Color],
            [SafetyStockLevel],
            [ReorderPoint],
            [StandardCost],
            [ListPrice],
            [Size],
            [SizeUnitMeasureCode],
            [WeightUnitMeasureCode],
            [Weight],
            [DaysToManufacture],
            [ProductLine],
            [Class],
            [Style],
            [ProductSubcategoryID],
            [ProductModelID],
            [SellStartDate],
            [SellEndDate],
            [DiscontinuedDate],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[ProductID],
            S.[Name],
            S.[ProductNumber],
            S.[MakeFlag],
            S.[FinishedGoodsFlag],
            S.[Color],
            S.[SafetyStockLevel],
            S.[ReorderPoint],
            S.[StandardCost],
            S.[ListPrice],
            S.[Size],
            S.[SizeUnitMeasureCode],
            S.[WeightUnitMeasureCode],
            S.[Weight],
            S.[DaysToManufacture],
            S.[ProductLine],
            S.[Class],
            S.[Style],
            S.[ProductSubcategoryID],
            S.[ProductModelID],
            S.[SellStartDate],
            S.[SellEndDate],
            S.[DiscontinuedDate],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[Product] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[Product] AS T
            WHERE T.[ProductID] = S.[ProductID]
        );

        SET IDENTITY_INSERT [CORE].[Product] OFF;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        BEGIN TRY
            SET IDENTITY_INSERT [CORE].[Product] OFF;
        END TRY
        BEGIN CATCH
            -- Preserve the original error.
        END CATCH;

        THROW;
    END CATCH;
END;
GO

--[CORE].[usp_LoadProductCategory]


CREATE OR ALTER PROCEDURE [CORE].[usp_LoadProductCategory]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update existing rows only when values change
        --------------------------------------------------
        UPDATE T
        SET
            T.[Name]         = S.[Name],
            T.[rowguid]      = S.[rowguid],
            T.[ModifiedDate] = S.[ModifiedDate]
        FROM [CORE].[ProductCategory] AS T
        INNER JOIN [STG].[ProductCategory] AS S
            ON T.[ProductCategoryID] = S.[ProductCategoryID]
        WHERE EXISTS
        (
            SELECT
                T.[Name],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[Name],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new rows
        --------------------------------------------------
        SET IDENTITY_INSERT [CORE].[ProductCategory] ON;

        INSERT INTO [CORE].[ProductCategory]
        (
            [ProductCategoryID],
            [Name],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[ProductCategoryID],
            S.[Name],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[ProductCategory] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[ProductCategory] AS T
            WHERE T.[ProductCategoryID] = S.[ProductCategoryID]
        );

        SET IDENTITY_INSERT [CORE].[ProductCategory] OFF;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        BEGIN TRY
            SET IDENTITY_INSERT [CORE].[ProductCategory] OFF;
        END TRY
        BEGIN CATCH
            -- Preserve the original error.
        END CATCH;

        THROW;
    END CATCH;
END;
GO


---[CORE].[usp_LoadProductSubcategory]

CREATE OR ALTER PROCEDURE [CORE].[usp_LoadProductSubcategory]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update existing rows only when values change
        --------------------------------------------------
        UPDATE T
        SET
            T.[ProductCategoryID] = S.[ProductCategoryID],
            T.[Name]              = S.[Name],
            T.[rowguid]           = S.[rowguid],
            T.[ModifiedDate]      = S.[ModifiedDate]
        FROM [CORE].[ProductSubcategory] AS T
        INNER JOIN [STG].[ProductSubcategory] AS S
            ON T.[ProductSubcategoryID] =
               S.[ProductSubcategoryID]
        WHERE EXISTS
        (
            SELECT
                T.[ProductCategoryID],
                T.[Name],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[ProductCategoryID],
                S.[Name],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new rows
        --------------------------------------------------
        SET IDENTITY_INSERT [CORE].[ProductSubcategory] ON;

        INSERT INTO [CORE].[ProductSubcategory]
        (
            [ProductSubcategoryID],
            [ProductCategoryID],
            [Name],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[ProductSubcategoryID],
            S.[ProductCategoryID],
            S.[Name],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[ProductSubcategory] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[ProductSubcategory] AS T
            WHERE T.[ProductSubcategoryID] =
                  S.[ProductSubcategoryID]
        );

        SET IDENTITY_INSERT [CORE].[ProductSubcategory] OFF;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        BEGIN TRY
            SET IDENTITY_INSERT [CORE].[ProductSubcategory] OFF;
        END TRY
        BEGIN CATCH
            -- Preserve the original error.
        END CATCH;

        THROW;
    END CATCH;
END;
GO

-- [CORE].[usp_LoadSalesPerson]

CREATE OR ALTER PROCEDURE [CORE].[usp_LoadSalesPerson]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update existing rows only when values change
        --------------------------------------------------
        UPDATE T
        SET
            T.[TerritoryID]   = S.[TerritoryID],
            T.[SalesQuota]    = S.[SalesQuota],
            T.[Bonus]         = S.[Bonus],
            T.[CommissionPct] = S.[CommissionPct],
            T.[SalesYTD]      = S.[SalesYTD],
            T.[SalesLastYear] = S.[SalesLastYear],
            T.[rowguid]       = S.[rowguid],
            T.[ModifiedDate]  = S.[ModifiedDate]
        FROM [CORE].[SalesPerson] AS T
        INNER JOIN [STG].[SalesPerson] AS S
            ON T.[BusinessEntityID] = S.[BusinessEntityID]
        WHERE EXISTS
        (
            SELECT
                T.[TerritoryID],
                T.[SalesQuota],
                T.[Bonus],
                T.[CommissionPct],
                T.[SalesYTD],
                T.[SalesLastYear],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[TerritoryID],
                S.[SalesQuota],
                S.[Bonus],
                S.[CommissionPct],
                S.[SalesYTD],
                S.[SalesLastYear],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new rows
        --------------------------------------------------
        INSERT INTO [CORE].[SalesPerson]
        (
            [BusinessEntityID],
            [TerritoryID],
            [SalesQuota],
            [Bonus],
            [CommissionPct],
            [SalesYTD],
            [SalesLastYear],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[BusinessEntityID],
            S.[TerritoryID],
            S.[SalesQuota],
            S.[Bonus],
            S.[CommissionPct],
            S.[SalesYTD],
            S.[SalesLastYear],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[SalesPerson] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[SalesPerson] AS T
            WHERE T.[BusinessEntityID] = S.[BusinessEntityID]
        );

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH;
END;
GO

-- [CORE].[usp_LoadSalesTerritory]

CREATE OR ALTER PROCEDURE [CORE].[usp_LoadSalesTerritory]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update existing rows only when values change
        --------------------------------------------------
        UPDATE T
        SET
            T.[Name]             = S.[Name],
            T.[CountryRegionCode] = S.[CountryRegionCode],
            T.[Group]            = S.[Group],
            T.[SalesYTD]         = S.[SalesYTD],
            T.[SalesLastYear]    = S.[SalesLastYear],
            T.[CostYTD]          = S.[CostYTD],
            T.[CostLastYear]     = S.[CostLastYear],
            T.[rowguid]          = S.[rowguid],
            T.[ModifiedDate]     = S.[ModifiedDate]
        FROM [CORE].[SalesTerritory] AS T
        INNER JOIN [STG].[SalesTerritory] AS S
            ON T.[TerritoryID] = S.[TerritoryID]
        WHERE EXISTS
        (
            SELECT
                T.[Name],
                T.[CountryRegionCode],
                T.[Group],
                T.[SalesYTD],
                T.[SalesLastYear],
                T.[CostYTD],
                T.[CostLastYear],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[Name],
                S.[CountryRegionCode],
                S.[Group],
                S.[SalesYTD],
                S.[SalesLastYear],
                S.[CostYTD],
                S.[CostLastYear],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new rows
        --------------------------------------------------
        SET IDENTITY_INSERT [CORE].[SalesTerritory] ON;

        INSERT INTO [CORE].[SalesTerritory]
        (
            [TerritoryID],
            [Name],
            [CountryRegionCode],
            [Group],
            [SalesYTD],
            [SalesLastYear],
            [CostYTD],
            [CostLastYear],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[TerritoryID],
            S.[Name],
            S.[CountryRegionCode],
            S.[Group],
            S.[SalesYTD],
            S.[SalesLastYear],
            S.[CostYTD],
            S.[CostLastYear],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[SalesTerritory] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[SalesTerritory] AS T
            WHERE T.[TerritoryID] = S.[TerritoryID]
        );

        SET IDENTITY_INSERT [CORE].[SalesTerritory] OFF;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        BEGIN TRY
            SET IDENTITY_INSERT [CORE].[SalesTerritory] OFF;
        END TRY
        BEGIN CATCH
            -- Preserve the original error.
        END CATCH;

        THROW;
    END CATCH;
END;
GO



--[CORE].[usp_LoadSalesOrderHeader]


CREATE OR ALTER PROCEDURE [CORE].[usp_LoadSalesOrderHeader]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update existing rows only when values change
        --------------------------------------------------
        UPDATE T
        SET
            T.[RevisionNumber]         = S.[RevisionNumber],
            T.[OrderDate]              = S.[OrderDate],
            T.[DueDate]                = S.[DueDate],
            T.[ShipDate]               = S.[ShipDate],
            T.[Status]                 = S.[Status],
            T.[OnlineOrderFlag]        = S.[OnlineOrderFlag],
            T.[PurchaseOrderNumber]    = S.[PurchaseOrderNumber],
            T.[AccountNumber]          = S.[AccountNumber],
            T.[CustomerID]             = S.[CustomerID],
            T.[SalesPersonID]          = S.[SalesPersonID],
            T.[TerritoryID]            = S.[TerritoryID],
            T.[BillToAddressID]        = S.[BillToAddressID],
            T.[ShipToAddressID]        = S.[ShipToAddressID],
            T.[ShipMethodID]            = S.[ShipMethodID],
            T.[CreditCardID]           = S.[CreditCardID],
            T.[CreditCardApprovalCode] = S.[CreditCardApprovalCode],
            T.[CurrencyRateID]         = S.[CurrencyRateID],
            T.[SubTotal]               = S.[SubTotal],
            T.[TaxAmt]                 = S.[TaxAmt],
            T.[Freight]                = S.[Freight],
            T.[Comment]                = S.[Comment],
            T.[rowguid]                = S.[rowguid],
            T.[ModifiedDate]           = S.[ModifiedDate]
        FROM [CORE].[SalesOrderHeader] AS T
        INNER JOIN [STG].[SalesOrderHeader] AS S
            ON T.[SalesOrderID] = S.[SalesOrderID]
        WHERE EXISTS
        (
            SELECT
                T.[RevisionNumber],
                T.[OrderDate],
                T.[DueDate],
                T.[ShipDate],
                T.[Status],
                T.[OnlineOrderFlag],
                T.[PurchaseOrderNumber],
                T.[AccountNumber],
                T.[CustomerID],
                T.[SalesPersonID],
                T.[TerritoryID],
                T.[BillToAddressID],
                T.[ShipToAddressID],
                T.[ShipMethodID],
                T.[CreditCardID],
                T.[CreditCardApprovalCode],
                T.[CurrencyRateID],
                T.[SubTotal],
                T.[TaxAmt],
                T.[Freight],
                T.[Comment],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[RevisionNumber],
                S.[OrderDate],
                S.[DueDate],
                S.[ShipDate],
                S.[Status],
                S.[OnlineOrderFlag],
                S.[PurchaseOrderNumber],
                S.[AccountNumber],
                S.[CustomerID],
                S.[SalesPersonID],
                S.[TerritoryID],
                S.[BillToAddressID],
                S.[ShipToAddressID],
                S.[ShipMethodID],
                S.[CreditCardID],
                S.[CreditCardApprovalCode],
                S.[CurrencyRateID],
                S.[SubTotal],
                S.[TaxAmt],
                S.[Freight],
                S.[Comment],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new rows
        --------------------------------------------------
        SET IDENTITY_INSERT [CORE].[SalesOrderHeader] ON;

        INSERT INTO [CORE].[SalesOrderHeader]
        (
            [SalesOrderID],
            [RevisionNumber],
            [OrderDate],
            [DueDate],
            [ShipDate],
            [Status],
            [OnlineOrderFlag],
            [PurchaseOrderNumber],
            [AccountNumber],
            [CustomerID],
            [SalesPersonID],
            [TerritoryID],
            [BillToAddressID],
            [ShipToAddressID],
            [ShipMethodID],
            [CreditCardID],
            [CreditCardApprovalCode],
            [CurrencyRateID],
            [SubTotal],
            [TaxAmt],
            [Freight],
            [Comment],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[SalesOrderID],
            S.[RevisionNumber],
            S.[OrderDate],
            S.[DueDate],
            S.[ShipDate],
            S.[Status],
            S.[OnlineOrderFlag],
            S.[PurchaseOrderNumber],
            S.[AccountNumber],
            S.[CustomerID],
            S.[SalesPersonID],
            S.[TerritoryID],
            S.[BillToAddressID],
            S.[ShipToAddressID],
            S.[ShipMethodID],
            S.[CreditCardID],
            S.[CreditCardApprovalCode],
            S.[CurrencyRateID],
            S.[SubTotal],
            S.[TaxAmt],
            S.[Freight],
            S.[Comment],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[SalesOrderHeader] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[SalesOrderHeader] AS T
            WHERE T.[SalesOrderID] = S.[SalesOrderID]
        );

        SET IDENTITY_INSERT [CORE].[SalesOrderHeader] OFF;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        BEGIN TRY
            SET IDENTITY_INSERT [CORE].[SalesOrderHeader] OFF;
        END TRY
        BEGIN CATCH
            -- Preserve the original error.
        END CATCH;

        THROW;
    END CATCH;
END;
GO


-- [CORE].[usp_LoadSalesOrderDetail]


CREATE OR ALTER PROCEDURE [CORE].[usp_LoadSalesOrderDetail]
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        --------------------------------------------------
        -- 1. Update existing rows only when values change
        --------------------------------------------------
        UPDATE T
        SET
            T.[SalesOrderID]          = S.[SalesOrderID],
            T.[CarrierTrackingNumber] = S.[CarrierTrackingNumber],
            T.[OrderQty]              = S.[OrderQty],
            T.[ProductID]             = S.[ProductID],
            T.[SpecialOfferID]        = S.[SpecialOfferID],
            T.[UnitPrice]             = S.[UnitPrice],
            T.[UnitPriceDiscount]     = S.[UnitPriceDiscount],
            T.[rowguid]               = S.[rowguid],
            T.[ModifiedDate]          = S.[ModifiedDate]
        FROM [CORE].[SalesOrderDetail] AS T
        INNER JOIN [STG].[SalesOrderDetail] AS S
            ON T.[SalesOrderDetailID] = S.[SalesOrderDetailID]
        WHERE EXISTS
        (
            SELECT
                T.[SalesOrderID],
                T.[CarrierTrackingNumber],
                T.[OrderQty],
                T.[ProductID],
                T.[SpecialOfferID],
                T.[UnitPrice],
                T.[UnitPriceDiscount],
                T.[rowguid],
                T.[ModifiedDate]
            EXCEPT
            SELECT
                S.[SalesOrderID],
                S.[CarrierTrackingNumber],
                S.[OrderQty],
                S.[ProductID],
                S.[SpecialOfferID],
                S.[UnitPrice],
                S.[UnitPriceDiscount],
                S.[rowguid],
                S.[ModifiedDate]
        );

        --------------------------------------------------
        -- 2. Insert new rows
        --------------------------------------------------
        SET IDENTITY_INSERT [CORE].[SalesOrderDetail] ON;

        INSERT INTO [CORE].[SalesOrderDetail]
        (
            [SalesOrderID],
            [SalesOrderDetailID],
            [CarrierTrackingNumber],
            [OrderQty],
            [ProductID],
            [SpecialOfferID],
            [UnitPrice],
            [UnitPriceDiscount],
            [rowguid],
            [ModifiedDate]
        )
        SELECT
            S.[SalesOrderID],
            S.[SalesOrderDetailID],
            S.[CarrierTrackingNumber],
            S.[OrderQty],
            S.[ProductID],
            S.[SpecialOfferID],
            S.[UnitPrice],
            S.[UnitPriceDiscount],
            S.[rowguid],
            S.[ModifiedDate]
        FROM [STG].[SalesOrderDetail] AS S
        WHERE NOT EXISTS
        (
            SELECT 1
            FROM [CORE].[SalesOrderDetail] AS T
            WHERE T.[SalesOrderDetailID] = S.[SalesOrderDetailID]
        );

        SET IDENTITY_INSERT [CORE].[SalesOrderDetail] OFF;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        BEGIN TRY
            SET IDENTITY_INSERT [CORE].[SalesOrderDetail] OFF;
        END TRY
        BEGIN CATCH
            -- Preserve the original error.
        END CATCH;

        THROW;
    END CATCH;
END;
GO





EXEC [CORE].[usp_LoadCustomer];
EXEC [CORE].[usp_LoadProduct];
EXEC [CORE].[usp_LoadProductCategory];
EXEC [CORE].[usp_LoadProductSubcategory];
EXEC [CORE].[usp_LoadSalesPerson];
EXEC [CORE].[usp_LoadSalesTerritory];
EXEC [CORE].[usp_LoadSalesOrderHeader];
EXEC [CORE].[usp_LoadSalesOrderDetail];