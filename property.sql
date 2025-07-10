SELECT *
FROM
    PricePaidSW12
GROUP BY PostCode, PropertyType


SELECT
    
    COUNT(*) AS numbeOfSales
    ,YEAR(P.TransactionDate) AS TheYear
FROM
    PricePaidSW12 P
GROUP BY YEAR(P.TransactionDate)
ORDER BY TheYear


SELECT
    
    COUNT(*) AS numbeOfSales
    ,YEAR(P.TransactionDate) AS TheYear
    ,SUM(P.Price) /1000000.0 AS MarketValue
FROM
    PricePaidSW12 P
GROUP BY YEAR(P.TransactionDate)
ORDER BY TheYear


-- what are the earliest and latest dates of a sale?
SELECT
    MIN(TransactionDate) AS EarliestSaleDate,
    MAX(TransactionDate) AS LatestSaleDate
FROM
    PricePaidSW12;

