USE RetailSalesAnalytics;
GO

-- وفكرة الـ View هنا ببساطة: بدل ما كل مرة نربط Orders + Customers + Regions + OrderItems + Products، نسوي طبقة تحليلية واحدة جاهزة.
--مهم: كل صف في الـ View سيمثل عنصرًا واحدًا داخل طلب Order Item، وليس طلبًا كاملًا.



CREATE OR ALTER VIEW dbo.SalesAnalysisView
AS

SELECT
    -- =====================================================
    -- Order
    -- =====================================================

    o.OrderID,
    o.OrderDate,

    YEAR(o.OrderDate) AS OrderYear,
    MONTH(o.OrderDate) AS OrderMonth,

    o.OrderStatus,
    o.PaymentMethod,
    o.ShippingMethod,

    -- =====================================================
    -- Customer
    -- =====================================================

    c.CustomerID,
    c.CustomerName,
    c.Gender,
    c.City,
    c.RegionID,
    r.RegionName,
    c.CustomerSegment,
    c.RegistrationDate,
    c.IsActive AS CustomerIsActive,

    -- =====================================================
    -- Product
    -- =====================================================

    p.ProductID,
    p.ProductName,
    p.Category,
    p.SubCategory,
    p.IsActive AS ProductIsActive,

    -- =====================================================
    -- Order Item
    -- =====================================================

    oi.OrderItemID,
    oi.Quantity,
    oi.UnitPrice,
    p.UnitCost,
    oi.DiscountPercent,

    -- =====================================================
    -- Sales Calculations
    -- =====================================================

    CAST(
        oi.Quantity * oi.UnitPrice
        AS DECIMAL(18,2)
    ) AS GrossSales,

    CAST(
        (oi.Quantity * oi.UnitPrice)
        * (oi.DiscountPercent / 100.0)
        AS DECIMAL(18,2)
    ) AS DiscountAmount,

    CAST(
        (oi.Quantity * oi.UnitPrice)
        -
        (
            (oi.Quantity * oi.UnitPrice)
            * (oi.DiscountPercent / 100.0)
        )
        AS DECIMAL(18,2)
    ) AS NetSales,

    CAST(
        oi.Quantity * p.UnitCost
        AS DECIMAL(18,2)
    ) AS CostAmount,

    CAST(
        (
            (oi.Quantity * oi.UnitPrice)
            -
            (
                (oi.Quantity * oi.UnitPrice)
                * (oi.DiscountPercent / 100.0)
            )
        )
        -
        (oi.Quantity * p.UnitCost)
        AS DECIMAL(18,2)
    ) AS Profit

FROM OrderItems oi

JOIN Orders o
    ON oi.OrderID = o.OrderID

JOIN Customers c
    ON o.CustomerID = c.CustomerID

JOIN Regions r
    ON c.RegionID = r.RegionID

JOIN Products p
    ON oi.ProductID = p.ProductID;
GO

-- =====================================================
-- هنا نختبر الجدول عشان يطلع لنا الجدول كامل 
-- وهذه بالضبط هي الطبقة اللي سنقرأها لاحقًا في Python وPower BI.
-- =====================================================
SELECT TOP 20 *
FROM dbo.SalesAnalysisView
ORDER BY OrderDate, OrderID;


-- =====================================================
-- الحين نتاكد من عدد الصفوف
-- =====================================================
SELECT
    COUNT(*) AS ViewRows
FROM dbo.SalesAnalysisView;

-- =====================================================
-- بعدين نشوف الطلبات ضروري التحقق هذا و السابق يكون الرقم مطابق بالضبط لان كل طلب يقابله صف واحد في الـ View
-- =====================================================
SELECT
    COUNT(*) AS OrderItemsRows
FROM OrderItems;

-- =====================================================
-- الحين نختبر الحسابات
-- =====================================================
SELECT TOP 20
    OrderID,
    ProductName,
    Quantity,
    UnitPrice,
    DiscountPercent,
    GrossSales,
    DiscountAmount,
    NetSales,
    CostAmount,
    Profit
FROM dbo.SalesAnalysisView
ORDER BY OrderID;

-- =====================================================
-- والحين اختبار المبيعات المكتملة من الـ View
-- =====================================================
SELECT
    SUM(NetSales) AS NetSales,
    SUM(Profit) AS TotalProfit,
    SUM(Quantity) AS UnitsSold
FROM dbo.SalesAnalysisView
WHERE OrderStatus = 'Completed';

-- =====================================================
-- اختبار أخير جميل
-- =====================================================
SELECT
    Category,
    SUM(NetSales) AS NetSales,
    SUM(Profit) AS Profit
FROM dbo.SalesAnalysisView
WHERE OrderStatus = 'Completed'
GROUP BY Category
ORDER BY NetSales DESC;