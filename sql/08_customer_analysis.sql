USE RetailSalesAnalytics;
GO

-- ======================
-- 1. أعلى العملاء إنفاقًا
-- من أهم العملاء من ناحية الإيراد؟
-- ======================
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    c.CustomerSegment,
    r.RegionName,
    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
JOIN Regions r
    ON c.RegionID = r.RegionID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName,
    c.CustomerSegment,
    r.RegionName
ORDER BY NetSales DESC;

-- ======================
-- 2. العملاء الأكثر تنفيذًا للطلبات
-- ممكن نشوف هنا شي ممتاز
-- العميل الأعلى إنفاقًا ليس بالضرورة الأكثر طلبات.
-- ======================
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    COUNT(DISTINCT o.OrderID) AS OrdersCount
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY OrdersCount DESC;

-- ======================
-- 3. متوسط إنفاق العميل
-- ======================
WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS CustomerNetSales
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus = 'Completed'
    GROUP BY c.CustomerID
)

SELECT
    AVG(CustomerNetSales) AS AverageCustomerValue
FROM CustomerSales;

-- ======================
-- 4. العملاء حسب الشريحة Customer Segment
-- طبعا هذا التحليل يجاوب على ...؟ 
-- هل Premium فعلًا أفضل من Regular؟ وهل Corporate يحقق قيمة أعلى؟
-- ======================
SELECT
    c.CustomerSegment,
    COUNT(DISTINCT c.CustomerID) AS CustomersCount,
    COUNT(DISTINCT o.OrderID) AS OrdersCount,

    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales

FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY c.CustomerSegment
ORDER BY NetSales DESC;

-- ======================
-- 5. متوسط قيمة الطلب لكل شريحة
-- ======================
WITH SegmentOrders AS
(
    SELECT
        c.CustomerSegment,
        o.OrderID,

        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS OrderValue

    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID
    WHERE o.OrderStatus = 'Completed'

    GROUP BY
        c.CustomerSegment,
        o.OrderID
)

SELECT
    CustomerSegment,
    COUNT(*) AS OrdersCount,
    AVG(OrderValue) AS AverageOrderValue
FROM SegmentOrders
GROUP BY CustomerSegment
ORDER BY AverageOrderValue DESC;

-- ======================
-- 6. العملاء المتكررون Repeat Customers
-- هنا بيطلع لنا مفهوم جديد
-- WHERE يفلتر الصفوف قبل التجميع، بينما HAVING يفلتر النتائج بعد GROUP BY.
-- ======================
SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(DISTINCT o.OrderID) AS OrdersCount
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName
HAVING COUNT(DISTINCT o.OrderID) > 1
ORDER BY OrdersCount DESC;

-- ======================
-- 7. العملاء الذين لم ينفذوا أي طلب مكتمل
-- القيمة هنا ممكن نسميها في التحليل (Customers Without Completed Purchases)
-- ======================
SELECT
    c.CustomerID,
    c.CustomerName,
    c.CustomerSegment
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
    AND o.OrderStatus = 'Completed'
WHERE o.OrderID IS NULL
ORDER BY c.CustomerID;

-- ======================
-- 8. آخر عملية شراء لكل عميل
-- ======================
SELECT
    c.CustomerID,
    c.CustomerName,
    MAX(o.OrderDate) AS LastPurchaseDate
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY LastPurchaseDate;

-- ======================
-- 9. العملاء الأعلى ربحية وليس فقط الأعلى مبيعات
-- ======================
SELECT TOP 10
    c.CustomerID,
    c.CustomerName,

    SUM(
        (
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        )
        -
        (oi.Quantity * p.UnitCost)
    ) AS Profit

FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
JOIN Products p
    ON oi.ProductID = p.ProductID

WHERE o.OrderStatus = 'Completed'

GROUP BY
    c.CustomerID,
    c.CustomerName

ORDER BY Profit DESC;

-- ======================
-- 10. مساهمة أعلى 10 عملاء من إجمالي المبيعات
-- ======================
WITH CustomerSales AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,

        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS NetSales

    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    WHERE o.OrderStatus = 'Completed'

    GROUP BY
        c.CustomerID,
        c.CustomerName
),
RankedCustomers AS
(
    SELECT
        *,
        ROW_NUMBER() OVER (
            ORDER BY NetSales DESC
        ) AS CustomerRank
    FROM CustomerSales
)

SELECT
    SUM(
        CASE
            WHEN CustomerRank <= 10
            THEN NetSales
            ELSE 0
        END
    ) AS Top10CustomerSales,

    SUM(NetSales) AS TotalSales,

    (
        SUM(
            CASE
                WHEN CustomerRank <= 10
                THEN NetSales
                ELSE 0
            END
        )
        /
        NULLIF(SUM(NetSales), 0)
    ) * 100 AS Top10ContributionPercent

FROM RankedCustomers;