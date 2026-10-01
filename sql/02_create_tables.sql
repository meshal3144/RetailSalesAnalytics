-- المرحلة الثانية
-- " إنشاء الجداول "

--=============================--
-- طبعا لانشاء الجداول نسوي هذا السكربت كامل
--=============================--
USE RetailSalesAnalytics;
GO

CREATE TABLE Regions (
    RegionID INT PRIMARY KEY,
    RegionName NVARCHAR(100) NOT NULL
);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName NVARCHAR(150) NOT NULL,
    Gender NVARCHAR(20),
    City NVARCHAR(100),
    RegionID INT,
    CustomerSegment NVARCHAR(50),
    RegistrationDate DATE,
    Email NVARCHAR(150),
    Phone NVARCHAR(30),
    IsActive BIT NOT NULL DEFAULT 1,

    CONSTRAINT FK_Customers_Regions
        FOREIGN KEY (RegionID)
        REFERENCES Regions(RegionID)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(150) NOT NULL,
    Category NVARCHAR(100),
    SubCategory NVARCHAR(100),
    UnitPrice DECIMAL(10,2) NOT NULL,
    UnitCost DECIMAL(10,2) NOT NULL,
    IsActive BIT NOT NULL DEFAULT 1
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    OrderStatus NVARCHAR(50),
    PaymentMethod NVARCHAR(50),
    ShippingMethod NVARCHAR(50),

    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    DiscountPercent DECIMAL(5,2) NOT NULL DEFAULT 0,

    CONSTRAINT FK_OrderItems_Orders
        FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID),

    CONSTRAINT FK_OrderItems_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
GO


--==============================
-- بعدها تأكد أن عندك 5 جداول:
--==============================