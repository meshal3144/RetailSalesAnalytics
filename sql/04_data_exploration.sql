USE RetailSalesAnalytics;
GO

-- ======================
-- 1. عدد السجلات
-- ======================
SELECT COUNT(*) AS RegionsCount FROM Regions;
SELECT COUNT(*) AS ProductsCount FROM Products;
SELECT COUNT(*) AS CustomersCount FROM Customers;
SELECT COUNT(*) AS OrdersCount FROM Orders;
SELECT COUNT(*) AS OrderItemsCount FROM OrderItems;

-- ======================
-- 2. الفترة الزمنية
-- ======================
SELECT
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LastOrderDate
FROM Orders;

-- ======================
-- 3. توزيع حالات الطلب
-- ======================
SELECT
    OrderStatus,
    COUNT(*) AS OrdersCount
FROM Orders
GROUP BY OrderStatus
ORDER BY OrdersCount DESC;

-- ======================
-- 4. شرائح العملاء
-- ======================
SELECT
    CustomerSegment,
    COUNT(*) AS CustomersCount
FROM Customers
GROUP BY CustomerSegment
ORDER BY CustomersCount DESC;

-- ======================
-- 5. المنتجات حسب الفئة
-- ======================
SELECT
    Category,
    COUNT(*) AS ProductsCount
FROM Products
GROUP BY Category
ORDER BY ProductsCount DESC;

-- ======================
-- 6. فحص البيانات الناقصة
-- ======================
SELECT
    SUM(CASE WHEN Email IS NULL OR Email = '' THEN 1 ELSE 0 END) AS MissingEmail,
    SUM(CASE WHEN Phone IS NULL OR Phone = '' THEN 1 ELSE 0 END) AS MissingPhone
FROM Customers;

-- ======================
-- 7. المدن
-- ======================
SELECT
    City,
    COUNT(*) AS CustomersCount
FROM Customers
GROUP BY City
ORDER BY City;