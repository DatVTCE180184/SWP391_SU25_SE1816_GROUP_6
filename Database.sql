﻿

/* 
QUY UOC DAT TEN: + IN HOA CHU CAI DAU TIEN
					+ "ID" VIET HOA
					+ DAU CACH " " THAY CHO GACH DUOI "_"
					+ etc	
*/

create database SMARTPHONE_RETAIL_MANAGEMENT_SYSTEM 

CREATE TABLE Gender (
  Gender_ID INT PRIMARY KEY,
  Gender_Name VARCHAR(50) NOT NULL
);


CREATE TABLE Role (
  Role_ID INT PRIMARY KEY,
  Role_Name VARCHAR(50) NOT NULL
);

create Table Users (
 User_ID INT PRIMARY KEY IDENTITY(1,1),

 Username VARCHAR(255) NOT NULL,
 Password VARCHAR(255) NOT NULL,

 Email VARCHAR(255) NOT NULL,
 Phone nvarchar(255),
 Address nvarchar(255),
 Gender_ID INT NOT NULL DEFAULT 0,
 FOREIGN KEY (Gender_ID) REFERENCES Gender(Gender_ID),
 Avatar nvarchar(255),

 /* Cot role ID se lay du lieu tu bang Role. The hien so 
	giup de quan ly CRUD du lieu hon */
 Role_ID INT NOT NULL DEFAULT 3,
 FOREIGN KEY (Role_ID) REFERENCES Role(Role_ID),
 Created_At DATETIME DEFAULT GETDATE(),      -- Ngay tao
 Updated_At DATETIME DEFAULT GETDATE(), -- Ngay update

);

CREATE TABLE Category (
	Category_ID INT primary key,
	Category_Name VARCHAR(50),
	Category_Description varchar(50),
	Category_Parent_ID int default null,
	Category_Image nvarchar(255),
	Category_Status BIT DEFAULT 1,  
	Created_At DATETIME DEFAULT GETDATE(),      -- Ngay tao
	Updated_At DATETIME DEFAULT GETDATE(), -- Ngay update

	FOREIGN KEY (Category_Parent_ID) REFERENCES Category(Category_ID)
);


Create table Product (
	Product_ID int primary key IDENTITY(1,1),
	Category_ID INT,
	
	Product_Name varchar(255) not null, 
	Product_Description nvarchar(255),
	Product_Image nvarchar(255),

	
	Product_Price DECIMAL(10, 2) NOT NULL,                         
	Product_Quantity INT NOT NULL DEFAULT 0, 

	Product_Status BIT DEFAULT 1,


	FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);


CREATE TABLE Orders (
    Order_ID INT IDENTITY(1,1) PRIMARY KEY,

    User_ID INT,
	Order_Date DATETIME DEFAULT CURRENT_TIMESTAMP, 
	Shipping_Address NVARCHAR(255) NOT NULL, 
	Order_Phone NVARCHAR(20),
	Note TEXT,

	Total_Amount DECIMAL(10, 2) NOT NULL DEFAULT 0.00,       -- Tổng tiền đơn hàng
	Payment_Method NVARCHAR(20) CHECK (Payment_Method IN ('COD', 'CreditCard', 'BankTransfer')) DEFAULT 'COD',
	Status  NVARCHAR(20) CHECK (Status IN ('Pending', 'Processing', 'Shipped', 'Completed', 'Cancelled')) 
    NOT NULL DEFAULT 'Pending',

	
	Created_At DATETIME DEFAULT GETDATE(),           
    Updated_At DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE CASCADE
);

Create table Order_Detail (
	Order_Detail_ID INT IDENTITY(1,1) PRIMARY KEY,
	Order_ID int not null, -- order_id   order table
	
	Product_ID int not null, -- pro_id pro-table
	Price DECIMAL(10, 2) NOT NULL, -- pro_price pro-table     
	
	Quantity INT NOT NULL DEFAULT 1,     

	FOREIGN KEY (Order_ID) REFERENCES Orders (Order_ID) ON DELETE CASCADE,
	FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

Create table Transactions (
	Trans_ID int IDENTITY(1,1) primary key,

	Order_ID int not null, -- order_ID order-table
	User_ID int not null, -- User_ID order-table

	Transaction_Status  NVARCHAR(20) CHECK (Transaction_Status IN ('Pending', 'Success', 'Failed', 'Refunded'))
	NOT NULL DEFAULT 'Pending',  -- Trạng thái giao dịch

	Transaction_Date  DATETIME DEFAULT GETDATE(),    -- Ngày thực hiện giao dịch
	Note TEXT,                                              -- Ghi chú (nếu có)

	FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE CASCADE,
	FOREIGN KEY (User_ID) REFERENCES Users(User_ID)

);

INSERT INTO Gender (Gender_ID, Gender_Name)
VALUES 
(1, 'Male'),
(2, 'Female'),
(3, 'Other');

INSERT INTO Role (Role_ID, Role_Name)
VALUES 
(1, 'Admin'),
(2, 'Staff'),
(3, 'Customer');

INSERT INTO Users (Username, Password, Email, Phone, Address, Gender_ID, Avatar, Role_ID)
VALUES 
('admin01', 'admin123', 'admin@example.com', '0123456789', '123 Admin Street', 1, NULL, 1),
('staff01', 'staff123', 'staff@example.com', '0987654321', '456 Staff Avenue', 2, NULL, 2),
('user01', 'user123', 'user@example.com', '0111222333', '789 User Road', 1, NULL, 3);

INSERT INTO Category (Category_ID, Category_Name, Category_Description)
VALUES 
(1, 'Smartphones', 'All kinds of smartphones'),
(2, 'Accessories', 'Phone accessories like cases, chargers'),
(3, 'Tablets', 'Tablets and large screen devices');

INSERT INTO Product (Category_ID, Product_Name, Product_Description, Product_Image, Product_Price, Product_Quantity)
VALUES 
(1, 'iPhone 14', 'Latest Apple iPhone', NULL, 999.99, 10),
(1, 'Samsung Galaxy S23', 'Flagship Samsung model', NULL, 899.99, 8),
(2, 'Wireless Charger', 'Fast charging pad', NULL, 29.99, 50);

INSERT INTO Orders (User_ID, Shipping_Address, Order_Phone, Note, Total_Amount, Payment_Method, Status)
VALUES 
(3, '789 User Road', '0111222333', 'Please deliver quickly', 1029.98, 'COD', 'Processing');

INSERT INTO Order_Detail (Order_ID, Product_ID, Price, Quantity)
VALUES 
(1, 1, 999.99, 1),
(1, 3, 29.99, 1);

INSERT INTO Transactions (Order_ID, User_ID, Transaction_Status, Note)
VALUES 
(1, 3, 'Pending', 'Awaiting confirmation');


select * from 