
--DDL
USE AdventureBikesDWIUWS26
GO

CREATE SCHEMA [CORE]
GO

CREATE TABLE [CORE].[Customer]
(
    [CustomerID] INT IDENTITY(1,1) NOT NULL,
    [PersonID] INT NULL,
    [StoreID] INT NULL,
    [TerritoryID] INT NULL,

    [AccountNumber] AS
    (
        ISNULL('AW' + [dbo].[ufnLeadingZeros]([CustomerID]), '')
    ),

    [rowguid] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL
        CONSTRAINT [DF_Customer_rowguid]
        DEFAULT (NEWID()),

    [ModifiedDate] DATETIME NOT NULL
        CONSTRAINT [DF_Customer_ModifiedDate]
        DEFAULT (GETDATE()),

    CONSTRAINT [PK_Customer_CustomerID]
        PRIMARY KEY CLUSTERED ([CustomerID] ASC)
);
GO

CREATE TABLE [CORE].[Product]
(
    [ProductID] INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    [ProductNumber] NVARCHAR(25) NOT NULL,

    [MakeFlag] BIT NOT NULL
        CONSTRAINT [DF_Product_MakeFlag] DEFAULT (1),

    [FinishedGoodsFlag] BIT NOT NULL
        CONSTRAINT [DF_Product_FinishedGoodsFlag] DEFAULT (1),

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

    [rowguid] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL
        CONSTRAINT [DF_Product_rowguid] DEFAULT (NEWID()),

    [ModifiedDate] DATETIME NOT NULL
        CONSTRAINT [DF_Product_ModifiedDate] DEFAULT (GETDATE()),

    CONSTRAINT [PK_Product_ProductID]
        PRIMARY KEY CLUSTERED ([ProductID] ASC),

    CONSTRAINT [CK_Product_Class]
        CHECK (UPPER([Class]) IN ('H', 'M', 'L') OR [Class] IS NULL),

    CONSTRAINT [CK_Product_DaysToManufacture]
        CHECK ([DaysToManufacture] >= 0),

    CONSTRAINT [CK_Product_ListPrice]
        CHECK ([ListPrice] >= 0.00),

    CONSTRAINT [CK_Product_ProductLine]
        CHECK (
            UPPER([ProductLine]) IN ('R', 'M', 'T', 'S')
            OR [ProductLine] IS NULL
        ),

    CONSTRAINT [CK_Product_ReorderPoint]
        CHECK ([ReorderPoint] > 0),

    CONSTRAINT [CK_Product_SafetyStockLevel]
        CHECK ([SafetyStockLevel] > 0),

    CONSTRAINT [CK_Product_SellEndDate]
        CHECK ([SellEndDate] >= [SellStartDate] OR [SellEndDate] IS NULL),

    CONSTRAINT [CK_Product_StandardCost]
        CHECK ([StandardCost] >= 0.00),

    CONSTRAINT [CK_Product_Style]
        CHECK (UPPER([Style]) IN ('U', 'M', 'W') OR [Style] IS NULL),

    CONSTRAINT [CK_Product_Weight]
        CHECK ([Weight] > 0.00 OR [Weight] IS NULL)
);
GO

CREATE TABLE [CORE].[ProductCategory]
(
    [ProductCategoryID] INT IDENTITY(1,1) NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,

    [rowguid] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL
        CONSTRAINT [DF_ProductCategory_rowguid]
        DEFAULT (NEWID()),

    [ModifiedDate] DATETIME NOT NULL
        CONSTRAINT [DF_ProductCategory_ModifiedDate]
        DEFAULT (GETDATE()),

    CONSTRAINT [PK_ProductCategory_ProductCategoryID]
        PRIMARY KEY CLUSTERED ([ProductCategoryID] ASC)
);
GO

CREATE TABLE [CORE].[ProductSubcategory]
(
    [ProductSubcategoryID] INT IDENTITY(1,1) NOT NULL,
    [ProductCategoryID] INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,

    [rowguid] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL
        CONSTRAINT [DF_ProductSubcategory_rowguid]
        DEFAULT (NEWID()),

    [ModifiedDate] DATETIME NOT NULL
        CONSTRAINT [DF_ProductSubcategory_ModifiedDate]
        DEFAULT (GETDATE()),

    CONSTRAINT [PK_ProductSubcategory_ProductSubcategoryID]
        PRIMARY KEY CLUSTERED ([ProductSubcategoryID] ASC)
);
GO

CREATE TABLE [CORE].[SalesPerson](
	[BusinessEntityID] [int] NOT NULL,
	[TerritoryID] [int] NULL,
	[SalesQuota] [money] NULL,
	[Bonus] [money] NOT NULL,
	[CommissionPct] [smallmoney] NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesPerson_BusinessEntityID] PRIMARY KEY CLUSTERED 
(
	[BusinessEntityID] ASC
)) ON [PRIMARY]

GO

CREATE TABLE [CORE].[SalesTerritory](
	[TerritoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] NVARCHAR(100) NOT NULL,
	[CountryRegionCode] [nvarchar](3) NOT NULL,
	[Group] [nvarchar](50) NOT NULL,
	[SalesYTD] [money] NOT NULL,
	[SalesLastYear] [money] NOT NULL,
	[CostYTD] [money] NOT NULL,
	[CostLastYear] [money] NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_SalesTerritory_TerritoryID] PRIMARY KEY CLUSTERED 
(
	[TerritoryID] ASC
)
) ON [PRIMARY]
GO

CREATE TABLE [CORE].[SalesOrderHeader]
(
    [SalesOrderID] INT IDENTITY(1,1) NOT NULL,
    [RevisionNumber] TINYINT NOT NULL,
    [OrderDate] DATETIME NOT NULL,
    [DueDate] DATETIME NOT NULL,
    [ShipDate] DATETIME NULL,
    [Status] TINYINT NOT NULL,
    [OnlineOrderFlag] BIT NOT NULL,

    [SalesOrderNumber] AS
    (
        ISNULL(
            N'SO' + CONVERT(NVARCHAR(23), [SalesOrderID]),
            N'*** ERROR ***'
        )
    ),

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

    [TotalDue] AS
    (
        ISNULL(([SubTotal] + [TaxAmt]) + [Freight], 0)
    ),

    [Comment] NVARCHAR(128) NULL,
    [rowguid] UNIQUEIDENTIFIER NOT NULL
        ROWGUIDCOL,
    [ModifiedDate] DATETIME NOT NULL,

    CONSTRAINT [PK_SalesOrderHeader_SalesOrderID]
        PRIMARY KEY CLUSTERED ([SalesOrderID] ASC)
);
GO

CREATE TABLE [CORE].[SalesOrderDetail]
(
    [SalesOrderID] INT NOT NULL,
    [SalesOrderDetailID] INT IDENTITY(1,1) NOT NULL,
    [CarrierTrackingNumber] NVARCHAR(25) NULL,
    [OrderQty] SMALLINT NOT NULL,
    [ProductID] INT NOT NULL,
    [SpecialOfferID] INT NOT NULL,
    [UnitPrice] MONEY NOT NULL,

    [UnitPriceDiscount] MONEY NOT NULL
        CONSTRAINT [DF_SalesOrderDetail_UnitPriceDiscount]
        DEFAULT (0.0),

    [LineTotal] AS
    (
        ISNULL(
            ([UnitPrice] * (1.0 - [UnitPriceDiscount])) * [OrderQty],
            0.0
        )
    ),

    [rowguid] UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL
        CONSTRAINT [DF_SalesOrderDetail_rowguid]
        DEFAULT (NEWID()),

    [ModifiedDate] DATETIME NOT NULL
        CONSTRAINT [DF_SalesOrderDetail_ModifiedDate]
        DEFAULT (GETDATE()),

    CONSTRAINT [PK_SalesOrderDetail_SalesOrderID_SalesOrderDetailID]
        PRIMARY KEY CLUSTERED
        (
            [SalesOrderID] ASC,
            [SalesOrderDetailID] ASC
        ),

    CONSTRAINT [CK_SalesOrderDetail_OrderQty]
        CHECK ([OrderQty] > 0),

    CONSTRAINT [CK_SalesOrderDetail_UnitPrice]
        CHECK ([UnitPrice] >= 0.00),

    CONSTRAINT [CK_SalesOrderDetail_UnitPriceDiscount]
        CHECK ([UnitPriceDiscount] >= 0.00),

    CONSTRAINT [FK_SalesOrderDetail_SalesOrderHeader_SalesOrderID]
        FOREIGN KEY ([SalesOrderID])
        REFERENCES [Sales].[SalesOrderHeader] ([SalesOrderID])
        ON DELETE CASCADE
);
GO

