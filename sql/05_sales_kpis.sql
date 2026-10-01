USE RetailSalesAnalytics;
GO

-- ======================
-- 1. إجمالي المبيعات قبل الخصم
-- ======================
SELECT
    SUM(Quantity * UnitPrice) AS GrossSales
FROM OrderItems;

-- ======================
-- 2. إجمالي الخصومات
-- ======================
SELECT
    SUM(
        (Quantity * UnitPrice) * (DiscountPercent / 100.0)
    ) AS TotalDiscount
FROM OrderItems;

-- ======================
-- 3. صافي المبيعات
-- ======================
SELECT
    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales
FROM OrderItems oi
JOIN Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed';

-- ======================
-- 4. عدد الطلبات المكتملة
-- ======================
SELECT
    COUNT(*) AS CompletedOrders
FROM Orders
WHERE OrderStatus = 'Completed';

-- ======================
-- 5. إجمالي الوحدات المباعة
-- ======================
SELECT
    SUM(oi.Quantity) AS UnitsSold
FROM OrderItems oi
JOIN Orders o
    ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed';

-- ======================
-- 6. عدد العملاء الذين اشتروا فعليًا
-- ======================
SELECT
    COUNT(DISTINCT o.CustomerID) AS ActiveCustomers
FROM Orders o
WHERE o.OrderStatus = 'Completed';

-- ======================
-- 7. متوسط قيمة الطلب Average Order Value
-- ======================
WITH OrderTotals AS
(
    SELECT
        o.OrderID,
        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS OrderTotal

    FROM Orders o
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    WHERE o.OrderStatus = 'Completed'

    GROUP BY o.OrderID
)

SELECT
    AVG(OrderTotal) AS AverageOrderValue
FROM OrderTotals;

-- ======================
-- 8. الربح Profit
-- ======================
SELECT
    SUM(
        (
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        )
        -
        (oi.Quantity * p.UnitCost)
    ) AS TotalProfit

FROM OrderItems oi

JOIN Orders o
    ON oi.OrderID = o.OrderID

JOIN Products p
    ON oi.ProductID = p.ProductID

WHERE o.OrderStatus = 'Completed';

-- ======================
-- 9. هامش الربح Profit Margin
-- ======================
WITH SalesProfit AS
(
    SELECT
        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS NetSales,

        SUM(
            (
                (oi.Quantity * oi.UnitPrice)
                -
                ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
            )
            -
            (oi.Quantity * p.UnitCost)
        ) AS Profit

    FROM OrderItems oi

    JOIN Orders o
        ON oi.OrderID = o.OrderID

    JOIN Products p
        ON oi.ProductID = p.ProductID

    WHERE o.OrderStatus = 'Completed'
)

SELECT
    NetSales,
    Profit,
    (Profit / NULLIF(NetSales, 0)) * 100 AS ProfitMarginPercent
FROM SalesProfit;

-- ======================
-- 10. استعلام واحد يلخص أهم KPIs
-- ======================
WITH OrderTotals AS
(
    SELECT
        o.OrderID,
        o.CustomerID,

        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS NetSales,

        SUM(oi.Quantity) AS UnitsSold,

        SUM(
            (
                (oi.Quantity * oi.UnitPrice)
                -
                ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
            )
            -
            (oi.Quantity * p.UnitCost)
        ) AS Profit

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    JOIN Products p
        ON oi.ProductID = p.ProductID

    WHERE o.OrderStatus = 'Completed'

    GROUP BY
        o.OrderID,
        o.CustomerID
)

SELECT
    COUNT(*) AS CompletedOrders,
    COUNT(DISTINCT CustomerID) AS ActiveCustomers,
    SUM(UnitsSold) AS UnitsSold,
    SUM(NetSales) AS NetSales,
    AVG(NetSales) AS AverageOrderValue,
    SUM(Profit) AS TotalProfit,
    (SUM(Profit) / NULLIF(SUM(NetSales), 0)) * 100 AS ProfitMarginPercent
FROM OrderTotals;