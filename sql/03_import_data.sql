-- BULK INSERT يحتاج أن تكون المسارات المحلية صحيحة وأن يكون لدى SQL Server صلاحية قراءة الملفات.




USE RetailSalesAnalytics;
GO

-- =====================================================
-- Import Regions
-- =====================================================

BULK INSERT Regions
FROM 'C:\Users\meshal\Desktop\RetailSalesAnalytics\data\raw\Regions.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- =====================================================
-- Import Products
-- =====================================================

BULK INSERT Products
FROM 'C:\Users\meshal\Desktop\RetailSalesAnalytics\data\raw\Products.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- =====================================================
-- Import Customers
-- =====================================================

BULK INSERT Customers
FROM 'C:\Users\meshal\Desktop\RetailSalesAnalytics\data\raw\Customers.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- =====================================================
-- Import Orders
-- =====================================================

BULK INSERT Orders
FROM 'C:\Users\meshal\Desktop\RetailSalesAnalytics\data\raw\Orders.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- =====================================================
-- Import OrderItems
-- =====================================================

BULK INSERT OrderItems
FROM 'C:\Users\meshal\Desktop\RetailSalesAnalytics\data\raw\OrderItems.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    CODEPAGE = '65001',
    TABLOCK
);
GO


-- =====================================================
-- Verification
-- =====================================================

SELECT COUNT(*) AS RegionsCount
FROM Regions;

SELECT COUNT(*) AS ProductsCount
FROM Products;

SELECT COUNT(*) AS CustomersCount
FROM Customers;

SELECT COUNT(*) AS OrdersCount
FROM Orders;

SELECT COUNT(*) AS OrderItemsCount
FROM OrderItems;
GO