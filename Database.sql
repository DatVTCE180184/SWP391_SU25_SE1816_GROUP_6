

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

CREATE TABLE Product_Review (
    Review_ID INT IDENTITY(1,1) PRIMARY KEY,
    User_ID INT NOT NULL,
    Product_ID INT NOT NULL,
    Order_ID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5) NOT NULL,
    Comment NVARCHAR(MAX),
    Review_Date DATETIME DEFAULT GETDATE(),

    FOREIGN KEY (User_ID) REFERENCES Users(User_ID) ON DELETE NO ACTION,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID) ON DELETE NO ACTION,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID) ON DELETE NO ACTION
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


select * from Orders
SELECT 
    U.User_ID, U.Username, U.Password, U.Email,
    U.Phone, U.Address, G.Gender_Name, U.Avatar,
    U.Role_ID, U.Created_At, U.Updated_At
FROM 
    Users U
JOIN 
    Gender G ON U.Gender_ID = G.Gender_ID;
 

SELECT 
	p.Product_ID, p.Category_ID,
	p.Product_Name, p.Product_Description,
	p.Product_Image, p.Product_Price,
	p.Product_Quantity, p.Product_Status

FROM 
	Product p


SELECT  
	c.Category_ID, c.Category_Name,
	c.Category_Description, c.Category_Image,
	c.Category_Parent_ID, c.Category_Status
FROM 
	Category c

	select * from Users


 /* 20-06-2025 . Commit: Update them ví dụ san pham */


	INSERT INTO Product (Category_ID, Product_Name, Product_Description, Product_Image, Product_Price, Product_Quantity, Product_Status)
VALUES 
(1, 'iPhone 14 Pro Max', 'Apple flagship smartphone', 'iphone14promax.jpg', 1199.99, 20, 1),
(1, 'Samsung Galaxy S24 Ultra', 'Latest Samsung phone with great camera', 'galaxys24ultra.jpg', 1099.99, 25, 1),
(1, 'Xiaomi 13 Pro', 'Affordable and powerful', 'xiaomi13pro.jpg', 799.99, 40, 1),
(1, 'Oppo Reno10', 'Stylish and slim smartphone', 'reno10.jpg', 499.99, 35, 1),
(1, 'Vivo V27', 'Selfie camera king', 'vivov27.jpg', 429.99, 50, 1),
(5, 'Asus ROG Phone 7', 'Gaming monster phone', 'rog7.jpg', 999.99, 15, 1),
(5, 'Black Shark 5 Pro', 'High performance gaming', 'blackshark5.jpg', 849.99, 10, 1),
(3, 'iPad Air 5', 'Powerful Apple tablet', 'ipadair5.jpg', 649.99, 30, 1),
(4, 'Apple Watch Series 8', 'Smart wearable from Apple', 'watchs8.jpg', 399.99, 18, 1),
(2, 'AirPods Pro 2', 'Wireless earbuds by Apple', 'airpodspro2.jpg', 249.99, 60, 1),
(2, 'Samsung Galaxy Buds 2 Pro', 'Noise-cancelling earbuds', 'galaxybuds2pro.jpg', 199.99, 55, 1);

-- Thêm vài danh mục mẫu
INSERT INTO Category (Category_ID, Category_Name, Category_Description)
VALUES 
(4, 'Smart Watches', 'Wearable smart watches'),
(5, 'Gaming Phones', 'Phones for gaming');

INSERT INTO Product_Review (User_ID, Product_ID, Order_ID, Rating, Comment)
VALUES (3, 1, 1, 5, N'The phone runs smoothly and has great battery life.');


update Product
set Product_Image = 'https://cdn.tgdd.vn/Products/Images/42/289663/iPhone-14-plus-thumb-den-600x600.jpg'
where Product_ID = 1;

update Product
set Product_Image = 'https://cdn.xtmobile.vn/vnt_upload/product/10_2023/thumbs/(600x600)_crop_samsung-galaxy-s23-fe-xtmobile.png'
where Product_ID = 2;


update Product
set Product_Image = 'https://galaxydidong.vn/wp-content/uploads/2022/09/14-pro-max-galaxydidong-vang.jpg'
where Product_ID = 4;


update Product
set Product_Image = 'https://baotinmobile.vn/uploads/2024/02/s24-ultra-tim.jpg'
where Product_ID = 5;


update Product
set Product_Image = 'https://cdn.tgdd.vn/Products/Images/42/282903/xiaomi-13-pro-thumb-1-2-600x600.jpg'
where Product_ID = 6;


update Product
set Product_Image = 'https://cdn.tgdd.vn/Products/Images/42/305695/oppo-reno10-blue-thumbnew-600x600.jpg'
where Product_ID = 7;


update Product
set Product_Image = 'https://cdn.tgdd.vn/Products/Images/42/297024/vivo-v27-thumb-600x600.jpg'
where Product_ID = 8;


update Product
set Product_Image = 'https://dlcdnwebimgs.asus.com/gain/4A2BCCC6-B9D8-47A5-AD7F-501E30A462A9'
where Product_ID = 9;


update Product
set Product_Image = 'https://cdn.tgdd.vn/Products/Images/42/269371/xiaomi-black-shark-5-pro-1-600x600.jpg'
where Product_ID = 10;

update Product
set Product_Image = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9rg0I2DWJcqSSZOQz4eouP6c7GWxXBgecEw&s'
where Product_ID = 11;


update Product
set Product_Image = 'https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111848_apple-watch-series8.png'
where Product_ID = 12;


update Product
set Product_Image = 'https://store.storeimages.cdn-apple.com/1/as-images.apple.com/is/airpods-pro-2-hero-select-202409_FMT_WHH?wid=1200&hei=630&fmt=jpeg&qlt=95&.v=1724041668836'
where Product_ID = 13;


update Product
set Product_Image = 'https://samcenter.vn/images/thumbs/0001518_galaxy-buds-2-pro.jpeg'
where Product_ID = 14;
--thêm hình cho Black Shark 5 Pro
UPDATE Product
SET Product_Image = 'https://cdn2.cellphones.com.vn/insecure/rs:fill:358:358/q:90/plain/https://cellphones.com.vn/media/catalog/product/x/i/xiaomi-black-shark-5s-pro.png'
WHERE Product_ID = 22;



--- làm cho phần thông số kĩ thuật 
-- Thêm 2 cột mới vào bảng Product màu và thông số kĩ thuật
ALTER TABLE Product ADD Product_Colors nvarchar(255);
ALTER TABLE Product ADD Product_Specs nvarchar(max);
-- them cột cho chi tiết sản phẩm 
ALTER TABLE Product ADD Product_Detail_Image NVARCHAR(500);
 -- Cập nhật dữ liệu cho sản phẩm cụ thể
   UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/240259/Kit/iphone-14-note-new.jpg'
   WHERE Product_ID = 1;
-- Cập nhật thông số kỹ thuật chi tiết cho iPhone 14
UPDATE Product 
SET Product_Colors = N'Đen,Trắng,Xanh,Tím,Đỏ',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.1 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>OLED</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>2532 x 1170 pixels</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>Tần số quét 60Hz, 1200 nits, Kính cường lực Ceramic Shield, Super Retina XDR</td></tr>
<tr><td><strong>Camera sau</strong></td><td>Camera góc rộng: 12MP, ƒ/1.5<br>Camera góc siêu rộng: 12MP, ƒ/2.4</td></tr>
<tr><td><strong>Camera trước</strong></td><td>12MP, ƒ/1.9</td></tr>
<tr><td><strong>Chipset</strong></td><td>Apple A15 Bionic 6 nhân</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>3.22 GHz</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>6 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>256 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>3279 mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>2 SIM (nano‑SIM và eSIM)</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>iOS 16</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
</table>'
WHERE Product_ID = 1;
-- mô tả sản phẩm 
 UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/240259/Kit/iphone-14-note-new.jpg'
   WHERE Product_ID = 1;
-- Samsung Galaxy S23
UPDATE Product
SET Product_Colors = N'Đỏ,Xanh,Trắng,Đen',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.1 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>Dynamic AMOLED 2X</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>Tần số quét 120Hz</td></tr>
<tr><td><strong>Camera sau</strong></td><td>50MP + 10MP + 12MP</td></tr>
<tr><td><strong>Camera trước</strong></td><td>12MP</td></tr>
<tr><td><strong>Chipset</strong></td><td>Snapdragon 8 Gen 2</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>8 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>128 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>3900 mAh</td></tr>
</table>'
WHERE Product_ID = 2;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/301795/Kit/samsung-galaxy-s23-note.jpg'
   WHERE Product_ID = 2;

-- iPhone 14 Pro Max
UPDATE Product
SET Product_Colors = N'Đen,Vàng,Bạc,Tím',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.7 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>Super Retina XDR OLED</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>2796 x 1290-pixel</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>120Hz, Always-On display, HDR, True Tone, Haptic Touch, 2,000,000:1, 2000 nits<br>Kính cường lực Ceramic Shield</td></tr>
<tr><td><strong>Camera sau</strong></td><td>
Camera chính: 48 MP, f/1.8, 24mm, OIS<br>
Camera góc siêu rộng: 12 MP, f/2.2, 13mm, 120˚<br>
Camera tele: 12 MP, f/2.8, 77mm, OIS, 3x optical zoom
</td></tr>
<tr><td><strong>Camera trước</strong></td><td>Camera selfie: 12 MP, f/1.9, 23mm, PDAF</td></tr>
<tr><td><strong>Chipset</strong></td><td>Apple A16 Bionic 6 nhân</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>3.46 GHz</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>6 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>256 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>4323 mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>2 SIM (nano‑SIM và eSIM)</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>iOS 16</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
</table>'
WHERE Product_ID = 4;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/251192/Kit/iphone-14-pro-max-note.jpg'
   WHERE Product_ID = 4;

   select * from Product
--Samsung Galaxy S24 Ultra
UPDATE Product
SET Product_Colors = N'Đen,Titan,Tím,Vàng',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.8 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>Dynamic AMOLED 2X</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>1440 x 3120 pixels</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>Độ sáng cao nhất 2,600 nits, 120Hz, Corning® Gorilla® Armor®, 16 triệu màu</td></tr>
<tr><td><strong>Camera sau</strong></td><td>
Camera chính: 200MP, Laser AF, OIS<br>
Camera: 50MP, PDAF, OIS, zoom quang học 5x<br>
Camera tele: 10MP<br>
Camera góc siêu rộng: 12 MP, f/2.2, 13mm, 120˚
</td></tr>
<tr><td><strong>Camera trước</strong></td><td>12 MP, f/2.2</td></tr>
<tr><td><strong>Chipset</strong></td><td>Snapdragon 8 Gen 3 For Galaxy</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>3.39GHz, 3.1GHz, 2.9GHz, 2.2GHz</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>12 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>256 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>5,000mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>SIM 1 + SIM 2 / SIM 1 + eSIM / 2 eSIM</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>Android 14, One UI 6.1</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
<tr><td><strong>Tương thích</strong></td><td>Bút SPEN - tích hợp sẵn lên máy</td></tr>
</table>'
WHERE Product_ID = 5;


UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/307174/Kit/samsung-galaxy-s24-ultra-note.jpg'
   WHERE Product_ID = 5;


--Xiaomi 13 Pro
UPDATE Product
SET Product_Colors = N'Đen,Xanh,Trắng',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.67 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>AMOLED</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>1220 x 2712 pixels</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>Tần số quét 120Hz, 1800 nits<br>Kính cường lực Corning Gorilla Glass Victus</td></tr>
<tr><td><strong>Camera sau</strong></td><td>Chính 200 MP & Phụ 8 MP, 2 MP</td></tr>
<tr><td><strong>Camera trước</strong></td><td>16 MP</td></tr>
<tr><td><strong>Chipset</strong></td><td>Snapdragon 7s Gen 2 8 nhân</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>4 nhân 2.4 GHz & 4 nhân 1.95 GHz</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>8 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>256 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>5100 mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>Dual nano-SIM hoặc 1 nano-SIM + 1 eSIM</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>Android 13</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
</table>'
WHERE Product_ID = 6;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/282903/Kit/xiaomi-13-pro-hinh-note.jpg'
   WHERE Product_ID = 6;
--Oppo Reno10
UPDATE Product
SET Product_Colors = N'Trắng,Xanh',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.7 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>AMOLED</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>1080 x 2412 pixels</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>1.07 tỷ màu, tần số quét 120Hz, HDR10+, tỷ lệ hiển thị 93%, 950 nits, viền cong 3D</td></tr>
<tr><td><strong>Camera sau</strong></td><td>
Camera góc rộng: 64MP; f/1.7, PDAF<br>
Chụp Telephoto chân dung: 32 MP, f/2.0<br>
Camera góc siêu rộng: 8 MP, f/2.2, Zoom quang lai 2X× và Zoom kỹ thuật số 20X
</td></tr>
<tr><td><strong>Camera trước</strong></td><td>Camera góc rộng: 32 MP, f/2.4</td></tr>
<tr><td><strong>Chipset</strong></td><td>MediaTek Dimensity 7050 5G 8 nhân</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>8 cores</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>8 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>256 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>5000 mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>2 SIM (Nano-SIM)</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>Android 13</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
</table>'
WHERE Product_ID = 7;
UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/305695/Kit/oppo-reno10-note-new.jpg'
   WHERE Product_ID = 7;
--Vivo V27
UPDATE Product
SET Product_Colors = N'Đen,Xanh,Vàng',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.78 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>AMOLED</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>1080 x 2400 pixels (FullHD+)</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>Tần số quét 120Hz, HDR10+</td></tr>
<tr><td><strong>Camera sau</strong></td><td>
Camera góc rộng: 64MP, f/1.8, 0.7µm, PDAF, OIS<br>
Camera góc siêu rộng: 8MP, f/2.2, 16mm, 120˚, 1/4\", 1.12µm<br>
Camera macro: 2MP, f/2.4
</td></tr>
<tr><td><strong>Camera trước</strong></td><td>Camera góc rộng: 50MP, f/2.5, AF</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>8 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>128 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>4600 mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>2 SIM (Nano-SIM)</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>Android 13</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
</table>'
WHERE Product_ID = 8;-- hk có phần mô tả chi tiết


--Wireless Charger
UPDATE Product
SET Product_Colors = N'Đen,Trắng',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Phân loại ốp</strong></td><td>Chống sốc</td></tr>
<tr><td><strong>Công suất</strong></td><td>9W</td></tr>
<tr><td><strong>Tính năng khác</strong></td><td>Cung cấp dòng điện sạc thiết bị</td></tr>
<tr><td><strong>Hãng sản xuất</strong></td><td>Spigen</td></tr>
</table>'
WHERE Product_ID = 3;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/9499/327247/de-sac-khong-day-magnetic-15w-belkin-boostcharge-wia008-2-750x500.jpg'
   WHERE Product_ID = 3;
--AirPods Pro 2
UPDATE Product
SET Product_Colors = N'Trắng',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Công nghệ âm thanh</strong></td><td>Active Noise Cancellation<br>Chip Apple H2<br>Adaptive EQ</td></tr>
<tr><td><strong>Micro</strong></td><td>Có</td></tr>
<tr><td><strong>Phương thức điều khiển</strong></td><td>Cảm ứng chạm</td></tr>
<tr><td><strong>Hãng sản xuất</strong></td><td>Apple Chính hãng</td></tr>
</table>'
WHERE Product_ID = 13;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/54/315014/tai-nghe-bluetooth-airpods-pro-2nd-gen-usb-c-charge-apple-1-750x500.jpg'
   WHERE Product_ID = 13;
--Samsung Galaxy Buds 2 Pro
UPDATE Product
SET Product_Colors = N'Đen',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước</strong></td><td>Tai nghe: 21.6 x 19.9 x 18.7 mm<br>Hộp sạc: 50.2 x 50.1 x 27.7 mm</td></tr>
<tr><td><strong>Trọng lượng</strong></td><td>Tai nghe: 5.5 g<br>Hộp sạc: 43.4 g</td></tr>
<tr><td><strong>Công nghệ âm thanh</strong></td><td>Active Noise Cancelling<br>360 Reality Audio<br>Ambient Sound<br>Âm thanh Hi-Fi</td></tr>
<tr><td><strong>Micro</strong></td><td>Có<br>6 micro</td></tr>
<tr><td><strong>Thời lượng sử dụng Pin</strong></td><td>Tai nghe: Dùng 5 giờ<br>Hộp sạc: Dùng 18 giờ (Tắt ANC)</td></tr>
<tr><td><strong>Phương thức điều khiển</strong></td><td>Chạm cảm ứng</td></tr>
<tr><td><strong>Tính năng khác</strong></td><td>Trợ Lý ảo Bixby<br>Tự động kết nối khi mở hộp sạc<br>Chống nước IPX7</td></tr>
<tr><td><strong>Hãng sản xuất</strong></td><td>Samsung Chính hãng</td></tr>
</table>'
WHERE Product_ID = 14;
select * from Product

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/54/286045/tai-nghe-bluetooth-true-wireless-galaxy-buds2-pro-den-7-750x500.jpg'
   WHERE Product_ID = 14;
--iPad Air 5 ( hk có phần mô tả )
UPDATE Product
SET Product_Colors = N'Xám,Xanh,Hồng,Tím,Trắng,Bạc',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>12.9 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>Liquid Retina</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>2732 x 2048 pixels</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>
Màn hình Multi-Touch với công nghệ LED nền và IPS, mật độ 264 ppi<br>
Dải màu rộng (P3)<br>
True Tone<br>
Công nghệ ép kín, 600 nit
</td></tr>
<tr><td><strong>Camera sau</strong></td><td>Camera góc rộng 12MP, khẩu độ ƒ/1.8</td></tr>
<tr><td><strong>Camera trước</strong></td><td>Ultra Wide 12MP trên cạnh ngang, khẩu độ ƒ/2.4</td></tr>
<tr><td><strong>Chipset</strong></td><td>Apple M2</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>CPU 8 lõi với 4 lõi hiệu năng và 4 lõi tiết kiệm điện</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>8 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>128 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>Tích hợp pin sạc Li-Po 36,59 watt‑giờ</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>1 eSIM</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>iPadOS 17</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Không</td></tr>
<tr><td><strong>Tương thích</strong></td><td>
Apple Pencil Pro<br>
Apple Pencil USB-C 2023<br>
Bàn phím iPad Air 13 M2/ Pro 12.9 M2 Apple Magic Keyboard + Trackpad<br>
Bàn phím iPad Air 13 M2/ Pro 12.9 M2 Apple Smart Keyboard
</td></tr>
</table>'
WHERE Product_ID = 11;

--Apple Watch Series 8
UPDATE Product
SET Product_Colors = N'Xám,Vàng,Đen',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Công nghệ màn hình</strong></td><td>Màn hình luôn bật (độ sáng 1000 nits)</td></tr>
<tr><td><strong>Đường kính mặt</strong></td><td>45mm</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>32 GB</td></tr>
<tr><td><strong>Kích thước cổ tay phù hợp</strong></td><td>140-190mm</td></tr>
<tr><td><strong>Tiện ích sức khoẻ</strong></td><td>Chế độ luyện tập, Theo dõi giấc ngủ, Đo lượng oxy trong máu, Đếm bước chân</td></tr>
<tr><td><strong>Tương thích</strong></td><td>iOS</td></tr>
<tr><td><strong>Thời lượng pin</strong></td><td>18 giờ sử dụng<br>36 giờ ở chế độ tiết kiệm pin<br>Hỗ trợ sạc nhanh</td></tr>
<tr><td><strong>Hãng sản xuất</strong></td><td>Apple Chính hãng</td></tr>
</table>'
WHERE Product_ID = 12;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/7077/289844/Slider/vi-vn-apple-watch-s8-lte-45mm-day-thep-(1).jpg'
   WHERE Product_ID = 12;


--Asus ROG Phone 7 ( hk có phần mô tả )
UPDATE Product
SET Product_Colors = N'Đen,Trắng',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.78 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>AMOLED</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>1080 x 2448 pixels (FullHD+)</td></tr>
<tr><td><strong>Tính năng màn hình</strong></td><td>Tần số quét 165 Hz<br>Corning® Gorilla® Glass Victus<br>Delta-E &lt; 1</td></tr>
<tr><td><strong>Camera sau</strong></td><td>
Camera góc rộng: 50 MP, f/1.9<br>
Camera góc siêu rộng: 13 MP<br>
Camera Macro: 5 MP
</td></tr>
<tr><td><strong>Camera trước</strong></td><td>32 MP</td></tr>
<tr><td><strong>Chipset</strong></td><td>Qualcomm Snapdragon 8 Gen2</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>3.2 GHz</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>16 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>512 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>6.000 mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>2 SIM (Nano-SIM)</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>Android 13</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
</table>'
WHERE Product_ID = 9;
--Black Shark 5 Pro ( hk có phần mô tả)
UPDATE Product
SET Product_Colors = N'Đen,Trắng',
    Product_Specs = N'<table class="table table-striped">
<tr><td><strong>Kích thước màn hình</strong></td><td>6.66 inches</td></tr>
<tr><td><strong>Công nghệ màn hình</strong></td><td>AMOLED</td></tr>
<tr><td><strong>Độ phân giải màn hình</strong></td><td>1080 x 2400 pixels (FullHD+)</td></tr>
<tr><td><strong>Camera sau</strong></td><td>13 MP, 2 MP, 64 MP</td></tr>
<tr><td><strong>Camera trước</strong></td><td>16 MP</td></tr>
<tr><td><strong>Chipset</strong></td><td>Qualcomm Snapdragon 870 5G</td></tr>
<tr><td><strong>Loại CPU</strong></td><td>1×3.2 GHz Kryo 585 & 3×2.42 GHz Kryo 585 & 4×1.80 GHz Kryo 585</td></tr>
<tr><td><strong>Dung lượng RAM</strong></td><td>8 GB</td></tr>
<tr><td><strong>Bộ nhớ trong</strong></td><td>128 GB</td></tr>
<tr><td><strong>Pin</strong></td><td>4650mAh</td></tr>
<tr><td><strong>Thẻ SIM</strong></td><td>Nano-SIM</td></tr>
<tr><td><strong>Hệ điều hành</strong></td><td>Android 12</td></tr>
<tr><td><strong>Công nghệ NFC</strong></td><td>Có</td></tr>
</table>'
WHERE Product_ID = 10;
SELECT * FROM Product;
select * from Users

select * from Role

select * from Product where Category_ID = 1

update Category
set Category_Image = 'fa-gamepad'
where Category_ID = 4;

select * from Category

update Product
set Product_Image = 'https://cdn-mms.hktvmall.com/HKTV/mms/uploadProductImage/ef95/7974/98bf/uFrkWaECgO20240705143836_515.jpg'
where Product_ID = 3



select *
from Orders

select * from Product


ALTER TABLE Orders
ADD Order_FullName VARCHAR(100);

update Orders
set Order_FullName = 'User 01'
where Order_ID = 1

