USE RetailSalesAnalytics;
GO

-- ======================
-- 1. المبيعات حسب السنة
-- نبدأ بصورة عامة: كم بعنا في 2024 وكم بعنا في 2025؟
-- ======================
SELECT
    YEAR(o.OrderDate) AS SalesYear,

    COUNT(DISTINCT o.OrderID) AS OrdersCount,

    SUM(oi.Quantity) AS UnitsSold,

    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

WHERE o.OrderStatus = 'Completed'

GROUP BY YEAR(o.OrderDate)

ORDER BY SalesYear;

-- ======================
-- 2. النمو السنوي Year-over-Year
-- هل 2025 ارتفعت عن 2024؟ وكم النسبة؟
-- ======================
WITH YearlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS SalesYear,

        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS NetSales

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    WHERE o.OrderStatus = 'Completed'

    GROUP BY YEAR(o.OrderDate)
)

SELECT
    SalesYear,
    NetSales,

    LAG(NetSales) OVER (
        ORDER BY SalesYear
    ) AS PreviousYearSales,

    (
        (
            NetSales
            -
            LAG(NetSales) OVER (ORDER BY SalesYear)
        )
        /
        NULLIF(
            LAG(NetSales) OVER (ORDER BY SalesYear),
            0
        )
    ) * 100 AS YoYGrowthPercent

FROM YearlySales

ORDER BY SalesYear;

-- ======================
-- 3. المبيعات الشهرية
-- ======================
SELECT
    YEAR(o.OrderDate) AS SalesYear,
    MONTH(o.OrderDate) AS SalesMonth,

    COUNT(DISTINCT o.OrderID) AS OrdersCount,

    SUM(oi.Quantity) AS UnitsSold,

    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales

FROM Orders o

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

WHERE o.OrderStatus = 'Completed'

GROUP BY
    YEAR(o.OrderDate),
    MONTH(o.OrderDate)

ORDER BY
    SalesYear,
    SalesMonth;

-- ======================
-- 4. مقارنة كل شهر بالشهر السابق
-- ======================
WITH MonthlySales AS
(
    SELECT
        YEAR(o.OrderDate) AS SalesYear,
        MONTH(o.OrderDate) AS SalesMonth,

        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS NetSales

    FROM Orders o

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    WHERE o.OrderStatus = 'Completed'

    GROUP BY
        YEAR(o.OrderDate),
        MONTH(o.OrderDate)
)

SELECT
    SalesYear,
    SalesMonth,
    NetSales,

    LAG(NetSales) OVER (
        ORDER BY SalesYear, SalesMonth
    ) AS PreviousMonthSales,

    (
        (
            NetSales
            -
            LAG(NetSales) OVER (
                ORDER BY SalesYear, SalesMonth
            )
        )
        /
        NULLIF(
            LAG(NetSales) OVER (
                ORDER BY SalesYear, SalesMonth
            ),
            0
        )
    ) * 100 AS MonthlyGrowthPercent

FROM MonthlySales

ORDER BY
    SalesYear,
    SalesMonth;

-- ======================
-- 5. المبيعات حسب الفئة Category
-- أي نوع من المنتجات يحقق أعلى مبيعات؟
-- ======================
SELECT
    p.Category,

    COUNT(DISTINCT o.OrderID) AS OrdersCount,

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

GROUP BY p.Category

ORDER BY NetSales DESC;

-- ======================
-- 6.نسبة مساهمة كل فئة في إجمالي المبيعات
-- ======================
WITH CategorySales AS
(
    SELECT
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

    GROUP BY p.Category
)

SELECT
    Category,
    NetSales,

    (
        NetSales
        /
        SUM(NetSales) OVER ()
    ) * 100 AS SalesContributionPercent

FROM CategorySales

ORDER BY NetSales DESC;

-- ======================
-- 7.المبيعات حسب المنطقة
-- وين تتركز مبيعاتنا جغرافيًا؟
-- ======================
SELECT
    r.RegionName,

    COUNT(DISTINCT o.OrderID) AS OrdersCount,

    COUNT(DISTINCT o.CustomerID) AS CustomersCount,

    SUM(oi.Quantity) AS UnitsSold,

    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales

FROM Orders o

JOIN Customers c
    ON o.CustomerID = c.CustomerID

JOIN Regions r
    ON c.RegionID = r.RegionID

JOIN OrderItems oi
    ON o.OrderID = oi.OrderID

WHERE o.OrderStatus = 'Completed'

GROUP BY r.RegionName

ORDER BY NetSales DESC;

-- ======================
-- 8.متوسط قيمة الطلب لكل منطقة
-- لأن المنطقة الأعلى مبيعات قد تكون فقط عندها عملاء أكثر.
-- لذا لازم نسأل شوي ونقول العميل أو الطلب الواحد في أي منطقة قيمته أكبر؟ 
-- طبعا الفائدة من هذا عشان نعرف الفرق بين حجم السوق و قيمة الطلب لان هذي من الاشياء المهمة في التحليل
-- ======================
WITH RegionalOrders AS
(
    SELECT
        r.RegionName,
        o.OrderID,

        SUM(
            (oi.Quantity * oi.UnitPrice)
            -
            ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
        ) AS OrderValue

    FROM Orders o

    JOIN Customers c
        ON o.CustomerID = c.CustomerID

    JOIN Regions r
        ON c.RegionID = r.RegionID

    JOIN OrderItems oi
        ON o.OrderID = oi.OrderID

    WHERE o.OrderStatus = 'Completed'

    GROUP BY
        r.RegionName,
        o.OrderID
)

SELECT
    RegionName,
    COUNT(*) AS OrdersCount,
    SUM(OrderValue) AS NetSales,
    AVG(OrderValue) AS AverageOrderValue

FROM RegionalOrders

GROUP BY RegionName

ORDER BY NetSales DESC;

-- ======================
-- 9.المنطقة × الفئة
-- والصدق هنا تبدا المتعة الهدف من هذا عشان نقول أي فئة منتجات قوية في كل منطقة؟
--  ليييه ...؟ لا ن بعدين في الباور بي اي نقدر نسويها على شكل Matrix أو Heatmap.
-- ======================
SELECT
    r.RegionName,
    p.Category,

    SUM(
        (oi.Quantity * oi.UnitPrice)
        -
        ((oi.Quantity * oi.UnitPrice) * (oi.DiscountPercent / 100.0))
    ) AS NetSales

FROM OrderItems oi

JOIN Orders o
    ON oi.OrderID = o.OrderID

JOIN Customers c
    ON o.CustomerID = c.CustomerID

JOIN Regions r
    ON c.RegionID = r.RegionID

JOIN Products p
    ON oi.ProductID = p.ProductID

WHERE o.OrderStatus = 'Completed'

GROUP BY
    r.RegionName,
    p.Category

ORDER BY
    r.RegionName,
    NetSales DESC;

