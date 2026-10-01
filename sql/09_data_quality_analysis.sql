USE RetailSalesAnalytics;
GO

-- ======================
-- 1. القيم الناقصة في بيانات العملاء
-- هنا طبعا راح نسوي أول فحص لـ Completeness.
-- ======================
SELECT
    COUNT(*) AS TotalCustomers,

    SUM(
        CASE
            WHEN Email IS NULL OR LTRIM(RTRIM(Email)) = ''
            THEN 1 ELSE 0
        END
    ) AS MissingEmail,

    SUM(
        CASE
            WHEN Phone IS NULL OR LTRIM(RTRIM(Phone)) = ''
            THEN 1 ELSE 0
        END
    ) AS MissingPhone,

    SUM(
        CASE
            WHEN City IS NULL OR LTRIM(RTRIM(City)) = ''
            THEN 1 ELSE 0
        END
    ) AS MissingCity

FROM Customers;

-- ======================
-- 2. نسبة الاكتمال
-- ======================
SELECT
    COUNT(*) AS TotalCustomers,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN Email IS NOT NULL
                     AND LTRIM(RTRIM(Email)) <> ''
                THEN 1 ELSE 0
            END
        )
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS EmailCompletenessPercent,

    CAST(
        100.0 *
        SUM(
            CASE
                WHEN Phone IS NOT NULL
                     AND LTRIM(RTRIM(Phone)) <> ''
                THEN 1 ELSE 0
            END
        )
        / COUNT(*)
        AS DECIMAL(5,2)
    ) AS PhoneCompletenessPercent

FROM Customers;

-- ======================
-- 3. البحث عن اختلافات كتابة المدن
-- ======================
SELECT
    City,
    COUNT(*) AS CustomersCount
FROM Customers
GROUP BY City
ORDER BY City;

-- ======================
-- 4. العملاء المحتمل تكرارهم
-- ======================
SELECT
    CustomerName,
    City,
    Email,
    Phone,
    COUNT(*) AS DuplicateCount
FROM Customers
GROUP BY
    CustomerName,
    City,
    Email,
    Phone
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;

-- ======================
-- 5. التحقق من القيم غير المنطقية في المنتجات
-- ======================
SELECT
    ProductID,
    ProductName,
    UnitPrice,
    UnitCost
FROM Products
WHERE
    UnitPrice <= 0
    OR UnitCost < 0
    OR UnitCost > UnitPrice;

-- ======================
-- 6. التحقق من كميات الطلبات الشاذة
-- من التحقق هذا بنلاحظ بعض القيم الكبيرة جدًا اللي سويناها بالعمد.
-- ======================
SELECT TOP 20
    OrderItemID,
    OrderID,
    ProductID,
    Quantity
FROM OrderItems
ORDER BY Quantity DESC;

-- ======================
-- 7. تحديد القيم الشاذة مبدئيًا
-- ======================
SELECT
    oi.OrderItemID,
    oi.OrderID,
    oi.ProductID,
    p.ProductName,
    oi.Quantity
FROM OrderItems oi
JOIN Products p
    ON oi.ProductID = p.ProductID
WHERE oi.Quantity > 10
ORDER BY oi.Quantity DESC;

-- ======================
-- 8. التحقق من الخصومات
-- ======================
SELECT
    DiscountPercent,
    COUNT(*) AS RecordsCount
FROM OrderItems
GROUP BY DiscountPercent
ORDER BY DiscountPercent;

SELECT
    OrderItemID,
    OrderID,
    DiscountPercent
FROM OrderItems
WHERE
    DiscountPercent < 0
    OR DiscountPercent > 100;

-- ======================
-- 9. التحقق من الطلبات بدون تفاصيل
-- وهنا طبيعي لو طلع شيء، معناه Order Header بدون Items.
-- ======================
SELECT
    o.OrderID,
    o.CustomerID,
    o.OrderDate
FROM Orders o
LEFT JOIN OrderItems oi
    ON o.OrderID = oi.OrderID
WHERE oi.OrderItemID IS NULL;

-- ======================
-- 10. التحقق من المنتجات التي لم تُبع
-- هذا مو شرط يكون مشكلة جودة؛ ممكن المنتج جديد أو غير نشط.
-- اي اننا تعلمنا شي الحين انه : " Not every unusual value is a data quality issue. "
-- ======================
SELECT
    p.ProductID,
    p.ProductName,
    p.Category
FROM Products p
LEFT JOIN OrderItems oi
    ON p.ProductID = oi.ProductID
WHERE oi.ProductID IS NULL;

-- ======================
-- 11. التحقق من العملاء بدون أي طلب
-- ======================
SELECT
    c.CustomerID,
    c.CustomerName,
    c.CustomerSegment
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- ======================
-- 12. فحص الاتساق بين المدينة والمنطقة
-- ولان بعض المدن عندنا مرتبطة باكثر بمناطق محددة نقدر نسوي
-- نبحدث الحين ونتحقق من " هل نفس المدينة مرتبطة بأكثر من Region؟ "
-- ======================
SELECT
    c.City,
    r.RegionName,
    COUNT(*) AS CustomersCount
FROM Customers c
JOIN Regions r
    ON c.RegionID = r.RegionID
GROUP BY
    c.City,
    r.RegionName
ORDER BY
    c.City,
    r.RegionName;

-- ======================
-- 13. ملخص جودة بيانات العملاء
-- ======================
SELECT
    COUNT(*) AS TotalCustomers,

    SUM(
        CASE
            WHEN Email IS NULL OR LTRIM(RTRIM(Email)) = ''
            THEN 1 ELSE 0
        END
    ) AS MissingEmail,

    SUM(
        CASE
            WHEN Phone IS NULL OR LTRIM(RTRIM(Phone)) = ''
            THEN 1 ELSE 0
        END
    ) AS MissingPhone,

    SUM(
        CASE
            WHEN City IS NULL OR LTRIM(RTRIM(City)) = ''
            THEN 1 ELSE 0
        END
    ) AS MissingCity,

    SUM(
        CASE
            WHEN IsActive = 0
            THEN 1 ELSE 0
        END
    ) AS InactiveCustomers

FROM Customers;

-- ملاحظة على ملخص الجودة
--بعد ما تشغل هذا الجزء، حاول بنلاحظ شي جميل:

--كم Missing Email؟
--كم Missing Phone؟
--هل عندك Riyadh وRIYADH؟
--كم Duplicate محتمل؟
--كم Quantity شاذة؟
--هل فيه خصومات غير صالحة؟
--هل فيه Orders بدون OrderItems؟
--هل فيه Products بدون مبيعات؟
-- وهنا نكون طبقنا عمليًا اللي تم شرحه نظريًا في:
--Completeness + Consistency + Validity + Uniqueness + Outliers
