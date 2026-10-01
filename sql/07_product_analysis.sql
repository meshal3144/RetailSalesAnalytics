USE RetailSalesAnalytics;
GO

-- ======================
-- 1.أعلى المنتجات مبيعًا بالقيمة
-- يعني الاستعلام هذا يقول أي المنتجات تحقق أعلى قيمة مبيعات؟
-- ======================
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales
FROM OrderItems oi
JOIN Orders o
    ON oi.OrderID = o.OrderID
JOIN Products p
    ON oi.ProductID = p.ProductID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY NetSales DESC;

-- ======================
-- 2.أعلى المنتجات مبيعًا بالكمية
-- طبعا ضروري يكون هنا أعلى منتج بالقيمة مو شرط يكون أعلى منتج بالكمية.
-- ======================
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Category,
    SUM(oi.Quantity) AS UnitsSold
FROM OrderItems oi
JOIN Orders o
    ON oi.OrderID = o.OrderID
JOIN Products p
    ON oi.ProductID = p.ProductID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY UnitsSold DESC;

-- ======================
-- 3.أعلى المنتجات ربحًا
-- ======================
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Category,

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
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY Profit DESC;

-- ======================
-- 4.أقل المنتجات ربحًا
-- وهذا هذا يفيدنا عشان نعرف المنتجات اللي اداءها المالي ضعيف.
-- ======================
SELECT TOP 10
    p.ProductID,
    p.ProductName,
    p.Category,

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
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY Profit ASC;

-- ======================
-- 5.هامش الربح لكل منتج
-- ======================
WITH ProductPerformance AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

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

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category
)

SELECT
    ProductID,
    ProductName,
    Category,
    NetSales,
    Profit,
    (Profit / NULLIF(NetSales, 0)) * 100 AS ProfitMarginPercent
FROM ProductPerformance
ORDER BY ProfitMarginPercent DESC;

-- ======================
-- 6.تحليل الخصومات حسب المنتج
-- من ضمن اسلة التحليل ....
-- هل المنتجات ذات الخصومات الأكبر تحقق فعلًا مبيعات أو أرباحًا أفضل؟
-- ======================
SELECT TOP 15
    p.ProductID,
    p.ProductName,
    p.Category,

    AVG(oi.DiscountPercent) AS AverageDiscount,

    SUM(
        (oi.Quantity * oi.UnitPrice)
        * (oi.DiscountPercent / 100.0)
    ) AS DiscountAmount

FROM OrderItems oi
JOIN Orders o
    ON oi.OrderID = o.OrderID
JOIN Products p
    ON oi.ProductID = p.ProductID
WHERE o.OrderStatus = 'Completed'
GROUP BY
    p.ProductID,
    p.ProductName,
    p.Category
ORDER BY DiscountAmount DESC;

-- ======================
-- 7.الأداء حسب SubCategory
-- ======================
SELECT
    p.Category,
    p.SubCategory,

    SUM(oi.Quantity) AS UnitsSold,

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
GROUP BY
    p.Category,
    p.SubCategory
ORDER BY
    p.Category,
    NetSales DESC;

-- ======================
-- 8. منتجات ذات مبيعات عالية وهامش ربح منخفض
-- بختصار هذا يجاوبنا على 
-- ما المنتجات التي تبيع كثيرًا لكن ربحيتها ضعيفة؟
-- ======================
WITH ProductPerformance AS
(
    SELECT
        p.ProductID,
        p.ProductName,
        p.Category,

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

    GROUP BY
        p.ProductID,
        p.ProductName,
        p.Category
)

SELECT
    ProductID,
    ProductName,
    Category,
    NetSales,
    Profit,
    (Profit / NULLIF(NetSales, 0)) * 100 AS ProfitMarginPercent
FROM ProductPerformance
WHERE
    NetSales > (
        SELECT AVG(NetSales)
        FROM ProductPerformance
    )
    AND
    (Profit / NULLIF(NetSales, 0)) * 100 < 20
ORDER BY NetSales DESC;

-- ======================
-- 9. المنتجات غير النشطة وهل ما زالت تظهر تاريخيًا في المبيعات
-- هذا ممتاز لأنه يوضح الفرق بين:
-- الوضع الحالي للمنتج وتاريخه البيعي
-- ======================
SELECT
    p.ProductID,
    p.ProductName,
    p.IsActive,
    COUNT(DISTINCT o.OrderID) AS OrdersCount,
    SUM(oi.Quantity) AS UnitsSold

FROM Products p

LEFT JOIN OrderItems oi
    ON p.ProductID = oi.ProductID

LEFT JOIN Orders o
    ON oi.OrderID = o.OrderID
    AND o.OrderStatus = 'Completed'

WHERE p.IsActive = 0

GROUP BY
    p.ProductID,
    p.ProductName,
    p.IsActive

ORDER BY UnitsSold DESC;