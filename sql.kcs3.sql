create database erp_db;
use erp_db;

CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY auto_increment,
    CategoryName VARCHAR(100) NOT NULL,
    Description TEXT
);

-- TABALA Categories
-- ---------------------------------------------------------
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/categories.csv'
INTO TABLE Categories 
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                -- Ignora a linha de cabeçalho

select * from categories;

-- TABELA CUSTOMES
-- -----------------------------------------------------------------------------------------------

CREATE TABLE Customers(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    Address VARCHAR(255),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(100)
    );
    
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customers.csv'
INTO TABLE customers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                -- Ignora a linha de cabeçalho


select * from customers;
-- -----------------------------------------------
-- Tabela EMPLOYEES
-- -----------------------------------------
CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY,
    LastName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    BirthDate varchar (100),
    Photo VARCHAR(255),
    Notes TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                -- Ignora a linha de cabeçalho

select * from Employees;
-- ----------------------------------------------------------
-- TABELA OrderDetails
-- ----------------------------------------------------------

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/OrderDetails.csv'
INTO TABLE OrderDetails
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                -- Ignora a linha de cabeçalho

-- -----------------------------------------------------------------
-- Tabela order
-- -----------------------------------------------------------------

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    EmployeeID INT,
    Orders varchar(100),
    ShipperID INT
    );
    
    LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;                -- Ignora a linha de cabeçalho
    -- ------------------------------------------------------------------
    -- Tabela Products
 -- ----------------------------------------------------------------
 
 CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INTEGER,
    CategoryID INTEGER,
    Unit VARCHAR(255),
    Price DECIMAL(10, 2)
);

   LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS -- Ignora a linha de cabeçalho
(ProductID,productName,SupplierID,CategoryID,Unit,@Price)
set Price = replace(@Price,",",".");
-- ------------------------------------------------------------
-- Tabela Shippers
-- ------------------------------------------------------------

CREATE TABLE Shippers (
    ShipperID INTEGER PRIMARY KEY auto_increment,
    ShipperName VARCHAR(255) NOT NULL,
    Phone VARCHAR(50)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/shippers.csv'
INTO TABLE shippers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Ignora a linha de cabeçalho

-- --------------------------------------
-- Tabela Suppliers
-- -----------------------------------------
CREATE TABLE Suppliers (
    SupplierID INTEGER PRIMARY KEY,
    SupplierName VARCHAR(255) NOT NULL,
    ContactName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(100),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    Phone VARCHAR(50)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Suppliers.csv'
INTO TABLE Suppliers
FIELDS TERMINATED BY ';'      -- Campos separados por vírgula
ENCLOSED BY ''                -- Não há delimitador de texto (aspas)
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- Ignora a linha de cabeçalho

select * from Suppliers;

-- 1. Relacionamentos para a tabela Products (ligando a Suppliers e Categories)
ALTER TABLE Products
ADD CONSTRAINT FK_Products_Suppliers
FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID),
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

-- 2. Relacionamentos para a tabela Orders (ligando a Customers, Employees e Shippers)
ALTER TABLE Orders
ADD CONSTRAINT FK_Orders_Customers
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
ADD CONSTRAINT FK_Orders_Employees
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
ADD CONSTRAINT FK_Orders_Shippers
FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID);

-- 3. Relacionamentos para a tabela OrderDetails (ligando a Orders e Products)
-- Esta tabela é o elo entre pedidos e produtos.
ALTER TABLE OrderDetails
ADD CONSTRAINT FK_OrderDetails_Orders
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
ADD CONSTRAINT FK_OrderDetails_Products
FOREIGN KEY (ProductID) REFERENCES Products(ProductID);
    