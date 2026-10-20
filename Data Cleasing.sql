
USE AdventureBikesDWIUWS26
GO


WITH CustomerCTE AS
(
    SELECT
        ROW_NUMBER() OVER (
            PARTITION BY [CustomerID]
            ORDER BY [ModifiedDate] DESC
        ) AS RowNum,
        [CustomerID],
        [PersonID],
        [StoreID],
        [TerritoryID],
        [AccountNumber],
        [rowguid],
        [ModifiedDate]
    FROM [AdventureBikesDWIUWS26].[STG].[Customer]
)
SELECT *
FROM CustomerCTE
WHERE RowNum >= 1;

WITH CustomerCTE AS
(
    SELECT
        ROW_NUMBER() OVER (
            PARTITION BY [CustomerID]
            ORDER BY [ModifiedDate] DESC
        ) AS RowNum,
        *
    FROM [AdventureBikesDWIUWS26].[STG].[Customer]
)
DELETE FROM CustomerCTE
WHERE RowNum >= 2;

UPDATE [AdventureBikesDWIUWS26].[STG].[Customer]
SET
    [CustomerID] = ISNULL([CustomerID], 0),
    [PersonID] = ISNULL([PersonID], 0),
    [StoreID] = ISNULL([StoreID], 0),
    [TerritoryID] = ISNULL([TerritoryID], 0)
WHERE
    [CustomerID] IS NULL
    OR [PersonID] IS NULL
    OR [StoreID] IS NULL
    OR [TerritoryID] IS NULL;