
SELECT
    
    COUNT(*) AS numbeOfSales
    ,YEAR(P.TransactionDate) AS TheYear
FROM
    PricePaidSW12 P
GROUP BY YEAR(P.TransactionDate)
ORDER BY TheYear




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

-- List all the sales in 2018 between £400,000 and £500,000 in Cambray Road (a street in SW12)
SELECT
    p.TransactionDate
    ,p.Price
    ,p.Street
    ,p.County
FROM
    PricePaidSW12 p
WHERE
    p.Street = 'Cambray Road'
    AND p.Price BETWEEN 400000 AND 500000
    AND p.TransactionDate BETWEEN '2018-01-01' AND '2018-12-31'
ORDER BY p.TransactionDate;
 


-- what are the earliest and latest dates of a sale?
SELECT
    MIN(TransactionDate) AS EarliestSaleDate,
    MAX(TransactionDate) AS LatestSaleDate
FROM
    PricePaidSW12;

--HW 1
-- Write a SQL query that lists the 25 latest sales in Ormeley Road with the following fields: TransactionDate, Price, PostCode, PAON

SELECT TOP 25
    P.TransactionDate,
    p.Price,
    p.PostCode,
    p.paon,
    pt.PropertyTypeName
FROM PricePaidSW12 p left join PropertyTypeLookup pt on p.PropertyType = pt.PropertyTypeCode
WHERE P.Street = 'Ormeley Road'
ORDER BY P.TransactionDate DESC



-- Property Type Lookup table does not exist cont. from above

SELECT TOP 25
    P.TransactionDate,
    p.Price,
    p.PostCode,
    p.paon,
    CASE 
        WHEN p.PropertyType = 'T' THEN 'Terraced'
        WHEN p.PropertyType = 'F' THEN 'Flat'
        ELSE 'UNKNOWN'
    END AS PropertyTypeDis
FROM PricePaidSW12 p