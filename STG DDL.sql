

--DDL STG
USE AdventureBikesDWIUWS26
GO

CREATE SCHEMA [STG]
GO

CREATE TABLE [STG].[Customer]
(
    [CustomerID] INT NOT NULL,
    [PersonID] INT NULL,
    [StoreID] INT NULL,
    [TerritoryID] INT NULL,
    [rowguid] UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate] DATETIME NOT NULL
);
GO

CREATE TABLE [STG].[Product]
(
    [ProductID] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [ProductNumber] NVARCHAR(25) NOT NULL,
    [MakeFlag] BIT NOT NULL,
    [FinishedGoodsFlag] BIT NOT NULL,
    [Color] NVARCHAR(15) NULL,
    [SafetyStockLevel] SMALLINT NOT NULL,
    [ReorderPoint] SMALLINT NOT NULL,
    [StandardCost] MONEY NOT NULL,
    [ListPrice] MONEY NOT NULL,
    [Size] NVARCHAR(5) NULL,
    [SizeUnitMeasureCode] NCHAR(3) NULL,
    [WeightUnitMeasureCode] NCHAR(3) NULL,
    [Weight] DECIMAL(8,2) NULL,
    [DaysToManufacture] INT NOT NULL,
    [ProductLine] NCHAR(2) NULL,
    [Class] NCHAR(2) NULL,
    [Style] NCHAR(2) NULL,
    [ProductSubcategoryID] INT NULL,
    [ProductModelID] INT NULL,
    [SellStartDate] DATETIME NOT NULL,
    [SellEndDate] DATETIME NULL,
    [DiscontinuedDate] DATETIME NULL,
    [rowguid] UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate] DATETIME NOT NULL
);
GO

CREATE TABLE [STG].[ProductCategory]
(
    [ProductCategoryID] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate] DATETIME NOT NULL
);
GO

CREATE TABLE [STG].[ProductSubcategory]
(
    [ProductSubcategoryID] INT NOT NULL,
    [ProductCategoryID] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [rowguid] UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate] DATETIME NOT NULL
);
GO

CREATE TABLE [STG].[SalesPerson](
	[BusinessEntityID] [int] NOT NULL,
	[TerritoryID] [int] NULL,
	[SalesQuota] [money] NULL,
	[Bonus] [money] NOT NULL,
	[CommissionPct] [smallmoney] NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL
	)
	GO

CREATE TABLE [STG].[SalesTerritory]
(
    [TerritoryID] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [CountryRegionCode] NVARCHAR(3) NOT NULL,
    [Group] NVARCHAR(50) NOT NULL,
    [SalesYTD] MONEY NOT NULL,
    [SalesLastYear] MONEY NOT NULL,
    [CostYTD] MONEY NOT NULL,
    [CostLastYear] MONEY NOT NULL,
    [rowguid] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL,
    [ModifiedDate] DATETIME NOT NULL
);
GO

CREATE TABLE [STG].[SalesOrderHeader]
(
    [SalesOrderID] INT NOT NULL,
    [RevisionNumber] TINYINT NOT NULL,
    [OrderDate] DATETIME NOT NULL,
    [DueDate] DATETIME NOT NULL,
    [ShipDate] DATETIME NULL,
    [Status] TINYINT NOT NULL,
    [OnlineOrderFlag] BIT NOT NULL,
    [SalesOrderNumber] NVARCHAR(25) NOT NULL,
    [PurchaseOrderNumber] NVARCHAR(25) NULL,
    [AccountNumber] NVARCHAR(15) NULL,
    [CustomerID] INT NOT NULL,
    [SalesPersonID] INT NULL,
    [TerritoryID] INT NULL,
    [BillToAddressID] INT NOT NULL,
    [ShipToAddressID] INT NOT NULL,
    [ShipMethodID] INT NOT NULL,
    [CreditCardID] INT NULL,
    [CreditCardApprovalCode] VARCHAR(15) NULL,
    [CurrencyRateID] INT NULL,
    [SubTotal] MONEY NOT NULL,
    [TaxAmt] MONEY NOT NULL,
    [Freight] MONEY NOT NULL,
    [TotalDue] MONEY NOT NULL,
    [Comment] NVARCHAR(128) NULL,
    [rowguid] UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate] DATETIME NOT NULL
);
GO

CREATE TABLE [STG].[SalesOrderDetail]
(
    [SalesOrderID] INT NOT NULL,
    [SalesOrderDetailID] INT NOT NULL,
    [CarrierTrackingNumber] NVARCHAR(25) NULL,
    [OrderQty] SMALLINT NOT NULL,
    [ProductID] INT NOT NULL,
    [SpecialOfferID] INT NOT NULL,
    [UnitPrice] MONEY NOT NULL,
    [UnitPriceDiscount] MONEY NOT NULL,
    [LineTotal] MONEY NOT NULL,
    [rowguid] UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate] DATETIME NOT NULL
);
GO


