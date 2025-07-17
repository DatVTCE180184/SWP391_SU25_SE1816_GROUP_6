

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
-- xóa dữ liệu cũ đã chèn
DELETE FROM Product_Spec;
DELETE FROM Spec_Type;
DELETE FROM Spec_Group;
-- xóa và sét lại từ 1
 SELECT * FROM Spec_Group;
 DELETE FROM Spec_Group;
 DBCC CHECKIDENT ('Spec_Type', RESEED, 0);

-- 11/7 table nhóm thống số kỹ thuật 
CREATE TABLE Spec_Group (
    Group_ID INT IDENTITY(1,1) PRIMARY KEY,
    Group_Name NVARCHAR(255)
	Category_ID INT;
);
CREATE TABLE Spec_Type (
    Spec_ID INT IDENTITY(1,1) PRIMARY KEY,
    Spec_Name NVARCHAR(255),
    Group_ID INT,
    FOREIGN KEY (Group_ID) REFERENCES Spec_Group(Group_ID)
); 

select * from Product_Spec
CREATE TABLE Product_Spec (
    Product_Spec_ID INT IDENTITY(1,1) PRIMARY KEY, -- Tự tăng
    Product_ID INT,
    Spec_ID INT,
    Spec_Value Spec_Value NVARCHAR(MAX),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Spec_ID) REFERENCES Spec_Type(Spec_ID)
); 
select * from Category
SELECT * FROM Product WHERE Product_Name LIKE N'%Wireless Charger%';
SELECT * FROM Spec_Group WHERE Group_Name = N'Thông số kỹ thuật' AND Category_ID = 2;
--------insert cho table  Spec_Group
--- smartphone
INSERT INTO Spec_Group (Group_Name, Category_ID) VALUES
(N'Cấu hình & Bộ nhớ', 1),
(N'Camera & Màn hình', 1),
(N'Pin & Sạc', 1),
(N'Tiện ích', 1),
(N'Kết nối', 1),
(N'Thiết kế & Chất liệu', 1);
--Accessories
INSERT INTO Spec_Group (Group_Name, Category_ID) VALUES (N'Thông số kỹ thuật', 2);
-- Table
INSERT INTO Spec_Group (Group_Name, Category_ID) VALUES
(N'Màn hình', 3),
(N'Hệ điều hành & CPT', 3),
(N'Bộ nhớ & Lưu trữ', 3),
(N'Camera sau', 3),
(N'Camera trước', 3),
(N'Kết nối', 3),
(N'Tiện ích', 3), 
(N'Pin & Sac', 3),
(N'Thông tin chung', 3);
-- Smart Watches
INSERT INTO Spec_Group (Group_Name, Category_ID) VALUES
(N'Màn hình', 4),
(N'Thiết kế', 4),
(N'Tiện ích', 4),
(N'Pin', 4),
(N'Cấu hình & Kết nối', 4),
(N'Thông tin khác', 4);

select * from Category
select * from Spec_Type

--------------------- insert cho table Spec_Type 
-- Smartphones
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES -- cấu hình & bộ nhớ (Group_ID = 1)
(N'Hệ điều hành', 1),
(N'Chip xử lý (CPU)', 1),
(N'Tốc độ CPU', 1),
(N'Chip đồ họa (GPU)', 1),
(N'RAM', 1),
(N'Dung lượng lưu trữ', 1),
(N'Dung lượng còn lại (khả dụng) khoảng', 1),
(N'Danh bạ', 1);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES -- Camera & Màn hình (Group_ID = 2)
(N'Độ phân giải camera sau', 2),
(N'Quay phim camera sau', 2),
(N'Đèn Flash camera sau', 2),
(N'Tính năng camera sau', 2),
(N'Độ phân giải camera trước', 2),
(N'Tính năng camera trước', 2),
(N'Công nghệ màn hình', 2),
(N'Độ phân giải màn hình', 2),
(N'Màn hình rộng', 2),
(N'Độ sáng tối đa', 2),
(N'Mặt kính cảm ứng', 2);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES-- Pin & Sạc (Group_ID = 3)
(N'Dung lượng pin', 3),
(N'Loại pin', 3),
(N'Hỗ trợ sạc tối đa', 3),
(N'Công nghệ pin', 3);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES-- Tiện ích (Group_ID = 4)
(N'Bảo mật nâng cao', 4),
(N'Tính năng đặc biệt', 4),
(N'Kháng nước, bụi', 4),
(N'Ghi âm', 4),
(N'Xem phim', 4),
(N'Nghe nhạc', 4);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES-- Kết nối (Group_ID = 5)
(N'Mạng di động', 5),
(N'SIM', 5),
(N'Wifi', 5),
(N'GPS', 5),
(N'Bluetooth', 5),
(N'Cổng kết nối/sạc', 5),
(N'Jack tai nghe', 5),
(N'Kết nối khác', 5);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES-- Thiết kế & Chất liệu (Group_ID = 6)
(N'Thiết kế', 6),
(N'Chất liệu', 6),
(N'Kích thước, khối lượng', 6),
(N'Thời điểm ra mắt', 6),
(N'Hãng', 6);
----* Accessories
---1. Wireless Charger
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Model', 7),
(N'Đầu vào', 7),
(N'Đầu ra', 7),
(N'Dòng sạc tối đa', 7),
(N'Công nghệ/Tiện ích', 7),
(N'Sản xuất tại', 7),
(N'Thương hiệu của', 7),
(N'Hãng', 7);
-- 2 AirPods Pro 2
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Thời lượng pin tai nghe', 8),
(N'Thời lượng pin hộp sạc', 8),
(N'Cổng sạc', 8),
(N'Công nghệ âm thanh', 8),
(N'Tương thích', 8),
(N'Tiện ích', 8),
(N'Kết nối cùng lúc', 8),
(N'Điều khiển', 8),
(N'Phím điều khiển', 8),
(N'Kích thước', 8),
(N'Khối lượng', 8),
(N'Thương hiệu của', 8),
(N'Sản xuất tại', 8),
(N'Hãng', 8);
-- 3. Samsung Galaxy Buds 2 Pro
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Thời lượng pin tai nghe', 8),
(N'Thời lượng pin hộp sạc', 8),
(N'Cổng sạc', 8),
(N'Công nghệ âm thanh', 8),
(N'Tương thích', 8),
(N'Ứng dụng kết nối', 8),
(N'Tiện ích', 8),
(N'Kết nối cùng lúc', 8),
(N'Công nghệ kết nối', 8),
(N'Điều khiển', 8),
(N'Phím điều khiển', 8),
(N'Kích thước', 8),
(N'Khối lượng', 8),
(N'Thương hiệu của', 8),
(N'Sản xuất tại', 8),
(N'Hãng', 8);

----* table 
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Công nghệ màn hình', 9),
(N'Độ phân giải', 9),
(N'Màn hình rộng', 9);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Hệ điều hành', 10),
(N'Chip xử lý (CPU)', 10),
(N'Tốc độ CPU', 10),
(N'Chip đồ hoạ (GPU)', 10);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'RAM', 11),
(N'Dung lượng lưu trữ', 11),
(N'Dung lượng còn lại (khả dụng) khoảng', 11);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Độ phân giải', 12),
(N'Quay phim', 12),
(N'Tính năng', 12);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Độ phân giải', 13),
(N'Tính năng', 13);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Mạng di động', 14),
(N'SIM', 14),
(N'Thực hiện cuộc gọi', 14),
(N'Wifi', 14),
(N'GPS', 14),
(N'Bluetooth', 14),
(N'Cổng kết nối/sạc', 14),
(N'Jack tai nghe', 14);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Tính năng đặc biệt', 15),
(N'Ghi âm', 15);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Dung lượng pin', 16),
(N'Loại pin', 16),
(N'Công nghệ pin', 16),
(N'Hỗ trợ sạc tối đa', 16),
(N'Sạc kèm theo máy', 16);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Chất liệu', 17),
(N'Kích thước, khối lượng', 17),
(N'Thời điểm ra mắt', 17),
(N'Hãng', 17);
-- Smart Watches
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Công nghệ màn hình', 18),
(N'Kích thước màn hình', 18),
(N'Độ phân giải', 18),
(N'Kích thước mặt', 18);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Chất liệu mặt', 19),
(N'Chất liệu khung viền', 19),
(N'Chất liệu dây', 19),
(N'Độ rộng dây', 19),
(N'Chu vi cổ tay phù hợp', 19),
(N'Khả năng thay dây', 19),
(N'Kích thước, khối lượng', 19);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Môn thể thao', 20),
(N'Sim', 20),
(N'Hỗ trợ nghe gọi', 20),
(N'Tiện ích đặc biệt', 20),
(N'Chống nước / Kháng nước', 20),
(N'Theo dõi sức khoẻ', 20),
(N'Tiện ích khác', 20),
(N'Hiển thị thông báo', 20);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Thời gian sử dụng pin', 21),
(N'Thời gian sạc', 21),
(N'Dung lượng pin', 21),
(N'Cổng sạc', 21);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'CPU', 22),
(N'Bộ nhớ trong', 22),
(N'Hệ điều hành', 22),
(N'Kết nối được với hệ điều hành', 22),
(N'Ứng dụng quản lý', 22),
(N'Kết nối', 22),
(N'Cảm biến', 22),
(N'Định vị', 22);
INSERT INTO Spec_Type (Spec_Name, Group_ID) VALUES
(N'Sản xuất tại', 23),
(N'Thời gian ra mắt', 23),
(N'Ngôn ngữ', 23),
(N'Hãng', 23);
SELECT * FROM Spec_Group WHERE Category_ID = 4;
select * from Spec_Type
SELECT Spec_ID, Spec_Name, Group_ID FROM Spec_Type WHERE Group_ID IN (9,10,11,12,13,14,15,16,17);

-----------------------insert table product_spec
--iphone14
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES-- Cấu hình & Bộ nhớ
(1, 1, N'iOS 17'),
(1, 2, N'Apple A15 Bionic'),
(1, 3, N'3.22 GHz'),
(1, 4, N'Apple GPU 5 nhân'),
(1, 5, N'6 GB'),
(1, 6, N'128 GB'),
(1, 7, N'113 GB'),
(1, 8, N'Không giới hạn');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES-- Camera & Màn hình
(1, 8, N'2 camera 12 MP'),
(1, 10, N'HD 720p@30fps, FullHD 1080p@60fps, 4K 2160p@60fps...'),
(1, 11, N'Có'),
(1, 12, N'Zoom quang học, Zoom kỹ thuật số, Xóa phông, Toàn cảnh (Panorama), Smart HDR 4, ...'),
(1, 13, N'12 MP'),
(1, 14, N'Xóa phông, Smart HDR 4, Retina Flash, Quay video Full HD, ...'),
(1, 15, N'OLED'),
(1, 16, N'Super Retina XDR (1170 x 2532 Pixels)'),
(1, 17, N'6.1" - Tần số quét 60 Hz'),
(1, 18, N'1200 nits'),
(1, 19, N'Kính cường lực Ceramic Shield');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES-- Pin & Sạc
(1, 20, N'3279 mAh'),
(1, 21, N'Li-Ion'),
(1, 22, N'20 W'),
(1, 23, N'Tiết kiệm pin, Sạc pin nhanh, Sạc không dây MagSafe, Sạc không dây');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES-- Tiện ích
(1, 24, N'Mở khoá khuôn mặt Face ID'),
(1, 25, N'Âm thanh Dolby Atmos, Phát hiện va chạm, Loa kép, HDR10, DCI-P3, Công nghệ True Tone, ...'),
(1, 26, N'IP68'),
(1, 27, N'Ghi âm mặc định'),
(1, 28, N'H.264(MPEG4-AVC), ProRes, HEVC'),
(1, 29, N'MP3, AAC');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES-- Kết nối
(1,	30, N'Hỗ trợ 5G'),
(1, 31, N'1 Nano SIM & 1 eSIM'),
(1, 32, N'Wi-Fi MIMO, Wi-Fi 802.11 a/b/g/n/ac/ax, Dual-band (2.4 GHz/5 GHz)'),
(1, 33, N'QZSS, GPS, GLONASS, GALILEO, BEIDOU'),
(1, 34, N'v5.3'),
(1, 35, N'Lightning'),
(1, 36, N'Lightning'),
(1, 37, N'NFC');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES-- Thiết kế & Chất liệu
(1, 38, N'Nguyên khối'),
(1, 39, N'Khung nhôm & Mặt lưng kính cường lực'),
(1, 40, N'Dài 146.7 mm - Ngang 71.5 mm - Dày 7.8 mm - Nặng 172 g'),
(1, 41, N'09/2022'),
(1, 42, N'iPhone (Apple)');
---Samsung Galaxy S23
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(2, 1, N'Android 13'),
(2, 2, N'Snapdragon 8 Gen 2 for Galaxy'),
(2, 3, N'1 nhân 3.36 GHz, 4 nhân 2.8 GHz & 3 nhân 2 GHz'),
(2, 4, N'Adreno 740'),
(2, 5, N'8 GB'),
(2, 6, N'256 GB'),
(2, 7, N'216.7 GB'),
(2, 8, N'Không giới hạn');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(2, 9, N'Chính 50 MP & Phụ 12 MP, 10 MP'),
(2, 10, N'HD 720p@30fps, FullHD 1080p@60fps, FullHD 1080p@30fps, 8K 4320p@30fps, 4K 2160p@60fps, 4K 2160p@30fps'),
(2, 11, N'Có'),
(2, 12, N'Ảnh Raw, Zoom quang học, Zoom kỹ thuật số, Xóa phông, Tự động lấy nét (AF), Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Quay Siêu chậm (Super Slow Motion), Quay chậm (Slow Motion), Nhãn dán (AR Stickers), Làm đẹp, Live Photos, Góc siêu rộng (Ultrawide), Chống rung quang học (OIS), Chuyên nghiệp (Pro), Bộ lọc màu, Ban đêm (Night Mode), AI Camera'),
(2, 13, N'12 MP'),
(2, 14, N'Xóa phông, Trôi nhanh thời gian (Time Lapse), Quay video HD, Quay video Full HD, Quay video 4K, Quay chậm (Slow Motion), Nhận diện khuôn mặt, Nhãn dán (AR Stickers), Làm đẹp, Góc siêu rộng (Ultrawide), Chụp đêm, Chuyên nghiệp (Pro), Bộ lọc màu'),
(2, 15, N'Dynamic AMOLED 2X'),
(2, 16, N'Full HD+ (1080 x 2340 Pixels)'),
(2, 17, N'6.6" - Tần số quét 120 Hz'),
(2, 18, N'1750 nits'),
(2, 19, N'Kính cường lực Corning Gorilla Glass Victus 2');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(2, 20, N'4700 mAh'),
(2, 21, N'Li-Ion'),
(2, 22, N'45 W'),
(2, 23, N'Sạc pin nhanh, Sạc ngược không dây, Sạc không dây');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(2, 24, N'Mở khoá vân tay dưới màn hình, Mở khoá khuôn mặt'),
(2, 25, N'Đa cửa sổ (chia đôi màn hình), Âm thanh Dolby Atmos, Âm thanh AKG, Tối ưu game (Game Booster), Trợ lý ảo Samsung Bixby, Thu nhỏ màn hình sử dụng một tay, Samsung Pay, Samsung DeX (Kết nối màn hình sử dụng giao diện tương tự PC), Màn hình luôn hiển thị AOD, Không gian thứ hai (Thư mục bảo mật), Chế độ đơn giản (Giao diện đơn giản), Chế độ trẻ em (Samsung Kids), Chặn tin nhắn, Chặn cuộc gọi, Chạm 2 lần tắt/sáng màn hình'),
(2, 26, N'IP68'),
(2, 27, N'Ghi âm cuộc gọi'),
(2, 28, N'MP4, MKV, FLV, AV1, 3GP'),
(2, 29, N'WAV, OGG, MP3, Midi, M4A, AMR, AAC');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(2, 30, N'Hỗ trợ 5G'),
(2, 31, N'2 Nano SIM hoặc 1 Nano SIM + 1 eSIM'),
(2, 32, N'Wi-Fi Direct, Wi-Fi 802.11 a/b/g/n/ac/ax, Dual-band (2.4 GHz/5 GHz/6 GHz)'),
(2, 33, N'QZSS, GPS, GLONASS, GALILEO, BEIDOU'),
(2, 34, N'v5.3'),
(2, 35, N'Type-C'),
(2, 36, N'Type-C'),
(2, 37, N'NFC');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(2, 38, N'Nguyên khối'),
(2, 39, N'Khung nhôm & Mặt lưng kính cường lực'),
(2, 40, N'Dài 157.8 mm - Ngang 76.2 mm - Dày 7.6 mm - Nặng 195 g'),
(2, 41, N'02/2023'),
(2, 42, N'Samsung');

select * from Product
---iPhone 14 Pro Max id4
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(4, 1, N'iOS 17'),
(4, 2, N'Apple A16 Bionic'),
(4, 3, N'3.46 GHz'),
(4, 4, N'Apple GPU 5 nhân'),
(4, 5, N'6 GB'),
(4, 6, N'256 GB'),
(4, 7, N'241 GB'),
(4, 8, N'Không giới hạn');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(4, 9, N'Chính 48 MP & Phụ 12 MP, 12 MP'),
(4, 10, N'HD 720p@30fps, FullHD 1080p@60fps, FullHD 1080p@30fps, FullHD 1080p@25fps, FullHD 1080p@240fps, FullHD 1080p@120fps, 4K 2160p@60fps, 4K 2160p@30fps, 4K 2160p@25fps, 4K 2160p@24fps'),
(4, 11, N'Có'),
(4, 12, N'Ảnh Raw, Zoom quang học, Zoom kỹ thuật số, Xóa phông, Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Smart HDR 4, Siêu độ phân giải, Siêu cận (Macro), Quay video ProRes, Quay chậm (Slow Motion), Live Photos, Góc siêu rộng (Ultrawide), Dolby Vision HDR, Deep Fusion, Cinematic, Chống rung quang học (OIS), Chế độ hành động (Action Mode), Chân dung đêm, Bộ lọc màu, Ban đêm (Night Mode), Photonic Engine'),
(4, 13, N'12 MP'),
(4, 14, N'Xóa phông, Trôi nhanh thời gian (Time Lapse), Smart HDR 4, Retina Flash, Quay video ProRes, Quay video Full HD, Quay video 4K, Quay chậm (Slow Motion), Nhãn dán (AR Stickers), Live Photos, Deep Fusion, Cinematic, Chụp đêm, Chống rung điện tử kỹ thuật số (EIS), Bộ lọc màu, Photonic Engine'),
(4, 15, N'OLED'),
(4, 16, N'Super Retina XDR (1290 x 2796 Pixels)'),
(4, 17, N'6.7" - Tần số quét 120 Hz'),
(4, 18, N'2000 nits'),
(4, 19, N'Kính cường lực Ceramic Shield');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(4, 20, N'4323 mAh'),
(4, 21, N'Li-Ion'),
(4, 22, N'20 W'),
(4, 23, N'Tiết kiệm pin, Sạc pin nhanh, Sạc không dây MagSafe, Sạc không dây');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(4, 24, N'Mở khoá khuôn mặt Face ID'),
(4, 25, N'Âm thanh Dolby Atmos, Phát hiện va chạm (Crash Detection), Màn hình luôn hiển thị AOD, Loa kép, HDR10, DCI-P3, Công nghệ True Tone, Công nghệ hình ảnh Dolby Vision, Công nghệ HLG, Chạm 2 lần sáng màn hình, Apple Pay'),
(4, 26, N'IP68'),
(4, 27, N'Ghi âm mặc định'),
(4, 28, N'H.264(MPEG4-AVC), ProRes, HEVC'),
(4, 29, N'MP3, ALAC, AAC');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(4, 30, N'Hỗ trợ 5G'),
(4, 31, N'1 Nano SIM & 1 eSIM'),
(4, 32, N'Wi-Fi MIMO, Wi-Fi hotspot, Wi-Fi 802.11 a/b/g/n/ac/ax'),
(4, 33, N'QZSS, GPS, GLONASS, GALILEO, BEIDOU'),
(4, 34, N'v5.3'),
(4, 35, N'Lightning'),
(4, 36, N'Lightning'),
(4, 37, N'NFC');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(4, 38, N'Nguyên khối'),
(4, 39, N'Khung thép không gỉ & Mặt lưng kính cường lực'),
(4, 40, N'Dài 160.7 mm - Ngang 77.6 mm - Dày 7.85 mm - Nặng 240 g'),
(4, 41, N'09/2022'),
(4, 42, N'iPhone (Apple)');
--Samsung Galaxy S24 Ultra id5
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(5, 1, N'Android 14'),
(5, 2, N'Snapdragon 8 Gen 3 for Galaxy'),
(5, 3, N'3.39 GHz'),
(5, 4, N'Adreno 750'),
(5, 5, N'12 GB'),
(5, 6, N'256 GB'),
(5, 7, N'229 GB'),
(5, 8, N'Không giới hạn');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(5, 9, N'Chính 200 MP & Phụ 50 MP, 12 MP, 10 MP'),
(5, 10, N'HD 720p@30fps, FullHD 1080p@60fps, FullHD 1080p@30fps, FullHD 1080p@240fps, FullHD 1080p@120fps, 8K 4320p@30fps, 4K 2160p@60fps, 4K 2160p@30fps, 4K 2160p@120fps'),
(5, 11, N'Có'),
(5, 12, N'Ảnh Raw, Zoom quang học, Zoom kỹ thuật số, Xóa phông, Video chân dung, Video chuyên nghiệp, Tự động lấy nét (AF), Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Super HDR, Siêu độ phân giải, Quét mã QR, Quay video hiển thị kép, Quay Siêu chậm (Super Slow Motion), Quay chậm (Slow Motion), Làm đẹp, Góc siêu rộng (Ultrawide), Chụp ảnh chuyển động, Chụp một chạm, Chụp hẹn giờ, Chống rung quang học (OIS), Chống rung kỹ thuật số (VDIS), Chuyên nghiệp (Pro), Bộ lọc màu, Ban đêm (Night Mode)'),
(5, 13, N'12 MP'),
(5, 14, N'Xóa phông, Video chân dung, Video chuyên nghiệp, Trôi nhanh thời gian (Time Lapse), Quay video HD, Quay video Full HD, Quay video 4K, Quay chậm (Slow Motion), Nhãn dán (AR Stickers), Làm đẹp, Góc rộng (Wide), Flash màn hình, Chụp ảnh chuyển động, Chụp đêm, Chụp một chạm, Chụp hẹn giờ, Chụp bằng cử chỉ, Chân dung đêm, Bộ lọc màu'),
(5, 15, N'Dynamic AMOLED 2X'),
(5, 16, N'2K+ (1440 x 3120 Pixels)'),
(5, 17, N'6.8" - Tần số quét 120 Hz'),
(5, 18, N'2600 nits'),
(5, 19, N'Kính cường lực Corning Gorilla Armor');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(5, 20, N'5000 mAh'),
(5, 21, N'Li-Ion'),
(5, 22, N'45 W'),
(5, 23, N'Tiết kiệm pin, Sạc pin nhanh, Sạc ngược không dây, Sạc không dây');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(5, 24, N'Mở khoá vân tay dưới màn hình, Mở khoá khuôn mặt'),
(5, 25, N'Ứng dụng kép (Dual Messenger), Đa cửa sổ (chia đôi màn hình), Âm thanh Dolby Atmos, Âm thanh AKG, Vision Booster, Tối ưu game (Game Booster), Trợ lý ảo Samsung Bixby, Trợ lý ảo Google Assistant, Trợ lý note thông minh, Trợ lý chỉnh ảnh, Trợ lý chat thông minh, Thu nhỏ màn hình sử dụng một tay, Samsung Pay, Samsung DeX (Kết nối màn hình sử dụng giao diện tương tự PC), Ray Tracing, Phiên dịch trực tiếp, Mở rộng bộ nhớ RAM, Màn hình luôn hiển thị AOD, Loa kép, Không gian thứ hai (Thư mục bảo mật), Khoanh vùng search đa năng, Hệ thống tản nhiệt Vapor Chamber, Cử chỉ thông minh, Chặn tin nhắn, Chặn cuộc gọi, Chạm 2 lần tắt/sáng màn hình'),
(5, 26, N'IP68'),
(5, 27, N'Ghi âm mặc định, Ghi âm cuộc gọi'),
(5, 28, N'WEBM, MP4, MKV, M4V, FLV, AV1, 3GP, 3G2'),
(5, 29, N'XMF, WAV, RTX, RTTTL, OTA, OGG, OGA, MXMF, MP3, Midi, M4A, IMY, FLAC, AWB');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(5, 30, N'Hỗ trợ 5G'),
(5, 31, N'2 Nano SIM hoặc 2 eSIM hoặc 1 Nano SIM + 1 eSIM'),
(5, 32, N'Wi-Fi MIMO, Wi-Fi hotspot, Wi-Fi Direct, Wi-Fi 802.11 a/b/g/n/ac/ax, Dual-band (2.4/5/6 GHz)'),
(5, 33, N'QZSS, GPS, GLONASS, GALILEO, BEIDOU'),
(5, 34, N'v5.3'),
(5, 35, N'Type-C'),
(5, 36, N'Type-C'),
(5, 37, N'NFC');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(5, 38, N'Nguyên khối'),
(5, 39, N'Khung Titan & Mặt lưng kính cường lực'),
(5, 40, N'Dài 162.3 mm - Ngang 79 mm - Dày 8.6 mm - Nặng 232 g'),
(5, 41, N'01/2024'),
(5, 42, N'Samsung');

-- Xiaomi 13 Pro id6
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(6, 1, N'Android 13'),
(6, 2, N'Snapdragon 8 Gen 2 8 nhân'),
(6, 3, N'1 nhân 3.2 GHz, 4 nhân 2.8 GHz & 3 nhân 2 GHz'),
(6, 4, N'Adreno 740'),
(6, 5, N'12 GB'),
(6, 6, N'256 GB'),
(6, 7, N'240 GB'),
(6, 8, N'Không giới hạn');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(6, 9, N'Chính 50 MP & Phụ 50 MP, 50 MP'),
(6, 10, N'HD 720p@30fps, FullHD 1080p@60fps, FullHD 1080p@30fps, 8K 4320p@24fps, 4K 2160p@60fps, 4K 2160p@30fps, 4K 2160p@24fps'),
(6, 11, N'Có'),
(6, 12, N'Ảnh Raw, Zoom kỹ thuật số, Xóa phông, Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Siêu độ phân giải, Siêu trắng, Siêu cận (Macro), Quay video hiển thị kép, Quay chậm (Slow Motion), Phơi sáng, Làm đẹp'),
(6, 13, N'32 MP'),
(6, 14, N'Xóa phông, Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Quay video HD, Quay video Full HD, Quay chậm (Slow Motion), Làm đẹp, HDR, Chụp đêm, Bộ lọc màu'),
(6, 15, N'AMOLED'),
(6, 16, N'2K+ (1440 x 3200 Pixels)'),
(6, 17, N'6.73" - Tần số quét 120 Hz'),
(6, 18, N'1900 nits'),
(6, 19, N'Kính cường lực Corning Gorilla Glass Victus');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(6, 20, N'4820 mAh'),
(6, 21, N'Li-Po'),
(6, 22, N'120 W'),
(6, 23, N'Sạc pin nhanh, Sạc ngược không dây, Sạc không dây');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(6, 24, N'Mở khoá vân tay dưới màn hình, Mở khoá khuôn mặt'),
(6, 25, N'Ứng dụng kép (Nhân bản ứng dụng), Âm thanh Dolby Atmos, Tối ưu game (Game Turbo), Trợ lý ảo Google Assistant, Thu nhỏ màn hình sử dụng một tay, Theo dõi nhịp tim bằng cảm biến vân tay, Mở rộng bộ nhớ RAM, Màn hình luôn hiển thị AOD, Loa kép, Không gian thứ hai, Khoá ứng dụng, Công nghệ tản nhiệt LiquidCool'),
(6, 26, N'IP68'),
(6, 27, N'Ghi âm mặc định, Ghi âm cuộc gọi'),
(6, 28, N'MP4, AV1'),
(6, 29, N'OGG, MP3, Midi, FLAC');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(6, 30, N'Hỗ trợ 5G'),
(6, 31, N'2 Nano SIM'),
(6, 32, N'Wi-Fi Direct, Dual-band (2.4 GHz/5 GHz)'),
(6, 33, N'QZSS, GPS, GLONASS, GALILEO, BEIDOU'),
(6, 34, N'v5.3, LE, A2DP'),
(6, 35, N'Type-C'),
(6, 36, N'Type-C'),
(6, 37, N'NFC, Hồng ngoại');
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(6, 38, N'Nguyên khối'),
(6, 39, N'Khung kim loại & Mặt lưng gốm'),
(6, 40, N'Dài 162.9 mm - Ngang 74.6 mm - Dày 8.38 mm - Nặng 229 g'),
(6, 41, N'02/2023'),
(6, 42, N'Xiaomi');

-- Oppo Reno10 id7
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(7, 1, N'Android 13'),
(7, 2, N'MediaTek Dimensity 7050 5G 8 nhân'),
(7, 3, N'2.6 GHz'),
(7, 4, N'Mali-G68 MC4'),
(7, 5, N'8 GB'),
(7, 6, N'256 GB'),
(7, 7, N'236 GB'),
(7, 8, N'Không giới hạn');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(7, 9, N'Chính 64 MP & Phụ 32 MP, 8 MP'),
(7, 10, N'HD 720p@960fps, HD 720p@60fps, HD 720p@30fps, HD 720p@240fps, FullHD 1080p@60fps, FullHD 1080p@480fps, FullHD 1080p@30fps, FullHD 1080p@120fps, 4K 2160p@30fps'),
(7, 11, N'Có'),
(7, 12, N'Zoom quang học, Zoom kỹ thuật số, Xóa phông, Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Siêu độ phân giải, Quét tài liệu, Quay video hiển thị kép, Quay chậm (Slow Motion), Nhãn dán (AR Stickers), Lấy nét theo pha (PDAF), Làm đẹp, HDR, Góc siêu rộng (Ultrawide), Google Lens, Chống rung quang học (OIS), Chuyên nghiệp (Pro), Bộ lọc màu, Ban đêm (Night Mode)'),
(7, 13, N'32 MP'),
(7, 14, N'Xóa phông, Tự động lấy nét (AF), Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Quay video HD, Quay video Full HD, Nhãn dán (AR Stickers), Làm đẹp A.I, HDR, Chụp đêm, Chống rung, Bộ lọc màu'),
(7, 15, N'AMOLED'),
(7, 16, N'Full HD+ (1080 x 2412 Pixels)'),
(7, 17, N'6.7" - Tần số quét 120 Hz'),
(7, 18, N'800 nits'),
(7, 19, N'Kính cường lực AGC DT-Star2');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(7, 20, N'5000 mAh'),
(7, 21, N'Li-Po'),
(7, 22, N'67 W'),
(7, 23, N'Tiết kiệm pin, Sạc siêu nhanh SuperVOOC, Siêu tiết kiệm pin');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(7, 24, N'Mở khoá vân tay dưới màn hình, Mở khoá khuôn mặt'),
(7, 25, N'Ứng dụng kép (Nhân bản ứng dụng), Đa cửa sổ (chia đôi màn hình), Trợ lý ảo Google Assistant, Mở rộng bộ nhớ RAM, Màn hình luôn hiển thị AOD, Loa kép, Khoá ứng dụng, HDR10+, Cử chỉ thông minh, Cử chỉ màn hình tắt, Chế độ đơn giản (Giao diện đơn giản), Chế độ trẻ em (Không gian trẻ em)'),
(7, 26, N'IPX4'),
(7, 27, N'Ghi âm mặc định, Ghi âm cuộc gọi'),
(7, 28, N'MP4, AV1'),
(7, 29, N'OGG, MP3, Midi, FLAC');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(7, 30, N'Hỗ trợ 5G'),
(7, 31, N'2 Nano SIM (SIM 2 chung khe thẻ nhớ)'),
(7, 32, N'Wi-Fi MIMO, Wi-Fi hotspot, Wi-Fi Direct, Wi-Fi 6, Dual-band (2.4 GHz/5 GHz)'),
(7, 33, N'QZSS, GPS, GLONASS, GALILEO, BEIDOU'),
(7, 34, N'v5.3'),
(7, 35, N'Type-C'),
(7, 36, N'Type-C'),
(7, 37, N'OTG, NFC, Hồng ngoại');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(7, 38, N'Nguyên khối'),
(7, 39, N'Khung hợp kim & Mặt lưng thuỷ tinh hữu cơ'),
(7, 40, N'Dài 162.43 mm - Ngang 74.19 mm - Dày 7.99 mm - Nặng 185 g'),
(7, 41, N'08/2023'),
(7, 42, N'OPPO');

-- Vivo V27 id8
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(8, 1, N'Android 13'),
(8, 2, N'MediaTek Dimensity 7200 5G 8 nhân'),
(8, 3, N'2.8 GHz'),
(8, 4, N'Mali G610 MC4'),
(8, 5, N'8 GB'),
(8, 6, N'128 GB'),
(8, 8, N'Không giới hạn');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(8, 9, N'Chính 50 MP & Phụ 8 MP, 2 MP'),
(8, 10, N'4K 2160p@30fps'),
(8, 11, N'Có'),
(8, 12, N'Xóa phông, Trôi nhanh thời gian (Time Lapse), Toàn cảnh (Panorama), Siêu độ phân giải, Siêu trắng, Siêu cận (Macro), Quay chậm (Slow Motion), Phơi sáng kép, Làm đẹp, Chống rung quang học (OIS), Chuyên nghiệp (Pro), Bộ lọc màu, Ban đêm (Night Mode)'),
(8, 13, N'50 MP'),
(8, 14, N'Quay video 4K, Phơi sáng kép, Làm đẹp, Chụp đêm'),
(8, 15, N'AMOLED'),
(8, 16, N'Full HD+ (1080 x 2400 Pixels)'),
(8, 17, N'6.78" - Tần số quét 120 Hz'),
(8, 18, N'Đang cập nhật'),
(8, 19, N'Đang cập nhật');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(8, 20, N'4600 mAh'),
(8, 21, N'Li-Po'),
(8, 22, N'66 W'),
(8, 23, N'Sạc pin nhanh');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(8, 24, N'Mở khoá vân tay dưới màn hình, Mở khoá khuôn mặt'),
(8, 28, N'TS, MP4, MKV, FLV, AV1, 3GP'),
(8, 29, N'WAV, Vorbis, MP3, MP2, MP1, Midi, FLAC, AAC');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(8, 30, N'Hỗ trợ 5G'),
(8, 31, N'2 Nano SIM'),
(8, 32, N'Dual-band (2.4 GHz/5 GHz)'),
(8, 33, N'QZSS, GPS, GLONASS, GALILEO, BEIDOU'),
(8, 34, N'v5.3'),
(8, 35, N'Type-C'),
(8, 36, N'Type-C'),
(8, 37, N'OTG');

INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(8, 38, N'Nguyên khối'),
(8, 39, N'Đang cập nhật'),
(8, 40, N'Dài 164.1 mm - Ngang 74.8 mm - Dày 7.4 mm - Nặng 180 g'),
(8, 41, N'03/2023'),
(8, 42, N'vivo');

select * from Product
----* Accessories
--1. Wireless Charger
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(3, 56, N'WIA008'),                
(3, 57, N'100-240V~50/60Hz, 0.7A'),
(3, 58, N'Không dây: 15W Max'),    
(3, 59, N'15 W'),                  
(3, 60, N'Sạc không dây'),        
(3, 61, N'Việt Nam'),              
(3, 62, N'Mỹ'),                    
(3, 63, N'Belkin');               

select * from Product_Spec
select * from Spec_Type
-- 2. AirPods Pro 2 id13
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(13, 72, N'Dùng 6 giờ - Sạc Hãng không công bố'), 
(13, 73, N'Dùng 30 giờ - Sạc Hãng không công bố'), 
(13, 74, N'Sạc MagSafe, Type-C'), 
(13, 75, N'Active Noise Cancellation, Chip Apple H2, Adaptive EQ, Ambient Sound'), 
(13, 76, N'Android, iOS, Windows, macOS (Macbook, iMac)'), 
(13, 77, N'Sạc không dây, Trợ lý ảo Siri, Chống nước & bụi IP54, Có mic thoại, Sạc nhanh, Chống ồn chủ động ANC'),
(13, 78, N'1 thiết bị'), 
(13, 79, N'Cảm ứng chạm'), 
(13, 80, N'Tăng/giảm âm lượng, Phát/dừng chơi nhạc, Chuyển bài hát, Bật trợ lý ảo, Chuyển chế độ, Nhận/Ngắt cuộc gọi, Bật/Tắt chống ồn'),
(13, 81, N'Dài 3.09 cm - Rộng 2.18 cm - Cao 2.17 cm'), 
(13, 82, N'5.3 g'), 
(13, 83, N'Mỹ'), 
(13, 84, N'Việt Nam / Trung Quốc (tùy lô hàng)'), 
(13, 85, N'Apple');

-- Samsung Galaxy Buds 2 Pro id14
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(14, 86, N'Dùng 5 giờ - Sạc Khoảng 70 phút'),
(14, 87, N'Dùng 23 giờ - Sạc Khoảng 130 phút'), 
(14, 88, N'Type-C'), 
(14, 89, N'Âm thanh Hi-Fi, Active Noise Cancelling, Công nghệ ENC, Ambient Sound, 360 Reality Audio'),
(14, 90, N'Android, iOS (iPhone), Windows'), 
(14, 91, N'SmartThings'), 
(14, 92, N'Chống nước IPX7, 3 Micro chống ồn, Hỗ trợ sạc không dây Qi, Sạc nhanh, Chống ồn chủ động ANC'), 
(14, 93, N'1 thiết bị'), 
(14, 94, N'Bluetooth 5.3'), 
(14, 95, N'Cảm ứng chạm'), 
(14, 96, N'Phát/dừng chơi nhạc, Chuyển bài hát, Nhận/Ngắt cuộc gọi, Bật/Tắt chống ồn'), 
(14, 97, N'Dài 2.4 cm - Rộng 2.1 cm - Cao 1.7 cm'), 
(14, 98, N'5.5 g'), 
(14, 99, N'Hàn Quốc'), 
(14, 100, N'Việt Nam'), 
(14, 101, N'Samsung');

-- iPad (Apple) id11
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(11, 102, N'Retina IPS LCD'),               
(11, 103, N'1640 x 2360 Pixels'),           
(11, 104, N'10.9" - Tần số quét Hãng không công bố'), 
(11, 105, N'iPadOS 15'),                    
(11, 106, N'Apple M1'),                     
(11, 107, N'Hãng không công bố'),          
(11, 108, N'Apple GPU 8 nhân'),            
(11, 109, N'8 GB'),                         
(11, 110, N'64 GB'),                        
(11, 111, N'49 GB'),
(11, 112, N'12 MP'),                        
(11, 113, N'HD 720p@30fps, FullHD 1080p@60fps, FullHD 1080p@30fps, FullHD 1080p@25fps, 4K 2160p@60fps, 4K 2160p@30fps, 4K 2160p@25fps, 4K 2160p@24fps'), 
(11, 114, N'Zoom kỹ thuật số, Tự động lấy nét (AF), Tua nhanh thời gian (Time-lapse), Toàn cảnh (Panorama), Quay chậm (Slow Motion), HDR, Gắn thẻ địa lý, Góc rộng'),
(11, 115, N'12 MP'),                         
(11, 116, N'Tự động lấy nét (AF), Quay video HD, Live Photos, Góc rộng, Bộ lọc màu'),
(11, 117, N'5G'),                           
(11, 118, N'1 Nano SIM & 1 eSIM'),         
(11, 119, N'Nghe gọi qua FaceTime'),        
(11, 120, N'Wi-Fi hotspot, Wi-Fi 802.11 a/b/g/n/ac/ax, MIMO, Dual-band'), 
(11, 121, N'iBeacon, GPS'),                 
(11, 122, N'v5.0'),                         
(11, 123, N'Type-C'),                       
(11, 124, N'Type-C'), 
(11, 125, N'Âm thanh Dolby Atmos, Trung tâm màn hình, Nam châm & sạc cho Apple Pencil, Mở khoá bằng vân tay, Kết nối bàn phím rời, Kết nối Apple Pencil 2, Dolby Vision, Micro kép'),
(11, 126, N'Có'), 
(11, 127, N'28.6 Wh (~ 7587 mAh)'),         
(11, 128, N'Li-Po'),                        
(11, 129, N'Sạc pin nhanh'),                
(11, 130, N'20 W'),                         
(11, 131, N'20 W'),
(11, 132, N'Nhôm nguyên khối'),            
(11, 133, N'Dài 247.6 mm - Ngang 178.5 mm - Dày 6.1 mm - Nặng 462 g'), 
(11, 134, N'03/2022'),                      
(11, 135, N'iPad (Apple)');


--* Smart Watches
DELETE FROM Product_Spec
WHERE Product_ID = 24;
-- Apple Watch id12
INSERT INTO Product_Spec (Product_ID, Spec_ID, Spec_Value) VALUES
(12, 136, N'OLED'),         
(12, 137, N'1.9 inch'),                            
(12, 138, N'430 x 352 pixels'),                 
(12, 139, N'41 mm '),
(12, 140, N'Kính Sapphire'),
(12, 141, N'Thép không gỉ'),
(12, 142, N'Thép không gỉ'),
(12, 143, N'Hãng không công bố'),
(12, 144, N'191134 cm'),
(12, 145, N'Có'),
(12, 146, N'Dài 41 mm - Ngang 35 mm - Dày 10.7 mm - Nặng 42.3 g'),
(12, 147, N'Chạy bộ, Bơi lội, Đạp xe'),         
(12, 148, N'eSIM'),                              
(12, 149, N'Nghe gọi độc lập'),                  
(12, 150, N'Phát hiện té ngã, Kết nối bluetooth với tai nghe, 4G/LTE'), 
(12, 151, N'Chống nước 5 ATM - ISO 22810:2010 (Tắm, bơi vùng nước nông)'),
(12, 152, N'Điện tâm đồ, Đo lượng tiêu thụ oxy tối đa (VO2 Max), Đo nồng độ oxy (SpO2), Ước tính ngày rụng trứng, Chấm điểm giấc ngủ, Tính quãng đường chạy, Theo dõi giấc ngủ, Theo dõi mức độ stress, Theo dõi chu kỳ kinh nguyệt, Nhắc nhở nhịp tim cao, thấp, Đo nhịp tim, Đếm số bước chân'),
(12, 153, N'Tính năng Family Setup, Trợ lý giọng nói, Nâng cổ tay sáng màn hình, Màn hình cảm ứng, Đồng hồ bấm giờ, Điều khiển chụp ảnh, Điều khiển chơi nhạc, Từ chối cuộc gọi, Thay mặt đồng hồ, Rung thông báo, Dự báo thời tiết, Cuộc gọi khẩn cấp SOS, Báo thức, Always On Display, Chuyển vùng quốc tế'),
(12, 154, N'Line, Messenger (Facebook), Viber, Zalo, Tin nhắn, Cuộc gọi'), 
(12, 155, N'Khoảng 1.5 ngày (ở chế độ tiết kiệm pin), Khoảng 18 giờ (ở chế độ sử dụng thông thường)'), 
(12, 156, N'Hãng không công bố'),              
(12, 157, N'Hãng không công bố'),              
(12, 158, N'Đế sạc nam châm'),                
(12, 159, N'Apple S8'),                      
(12, 160, N'32 GB'),                           
(12, 161, N'watchOS phiên bản mới nhất'),     
(12, 162, N'iPhone 8 trở lên với iOS phiên bản mới nhất'), 
(12, 163, N'Watch'),                           
(12, 164, N'Bluetooth v5.3, GPS, NFC, Wifi'),  
(12, 165, N'Cảm biến ánh sáng môi trường, Cảm biến điện học (ECG), Cảm biến nhịp tim quang học thế hệ 3, Cao áp kế, Con quay hồi chuyển, Gia tốc kế, La bàn'),
(12, 166, N'Beidou, GLONASS, GPS, QZSS'),      
(12, 167, N'Trung Quốc'),                      
(12, 168, N'09/2022'),                         
(12, 169, N'Tiếng Việt, Tiếng Anh'),           
(12, 170, N'Apple');

select * from Product
SELECT Spec_ID, Spec_Name, Group_ID FROM Spec_Type WHERE Group_ID IN (18,19,20,21,22,23);
----------------------------------------
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
 
   -- 10 tháng 7cập nhật thông số kỹ thuật theo dạng table 
 

-- Link hình mô tả sản phẩm 
 UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/240259/Kit/iphone-14-note-new.jpg'
   WHERE Product_ID = 1;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/301795/Kit/samsung-galaxy-s23-note.jpg'
   WHERE Product_ID = 2;

   update Product
set Product_Image = 'https://cdn-mms.hktvmall.com/HKTV/mms/uploadProductImage/ef95/7974/98bf/uFrkWaECgO20240705143836_515.jpg'
where Product_ID = 3

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/251192/Kit/iphone-14-pro-max-note.jpg'
   WHERE Product_ID = 4;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/307174/Kit/samsung-galaxy-s24-ultra-note.jpg'
   WHERE Product_ID = 5;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/282903/Kit/xiaomi-13-pro-hinh-note.jpg'
   WHERE Product_ID = 6;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/42/305695/Kit/oppo-reno10-note-new.jpg'
   WHERE Product_ID = 7;
--Vivo V27 hk có phần mô tả chi tiết

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/9499/327247/de-sac-khong-day-magnetic-15w-belkin-boostcharge-wia008-2-750x500.jpg'
   WHERE Product_ID = 3;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/54/315014/tai-nghe-bluetooth-airpods-pro-2nd-gen-usb-c-charge-apple-1-750x500.jpg'
   WHERE Product_ID = 13;

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/54/286045/tai-nghe-bluetooth-true-wireless-galaxy-buds2-pro-den-7-750x500.jpg'
   WHERE Product_ID = 14;
--iPad Air 5 ( hk có phần mô tả )

UPDATE Product 
   SET Product_Detail_Image = 'https://cdn.tgdd.vn/Products/Images/7077/289844/Slider/vi-vn-apple-watch-s8-lte-45mm-day-thep-(1).jpg'
   WHERE Product_ID = 12;

--Asus ROG Phone 7 ( hk có phần mô tả )
--Black Shark 5 Pro ( hk có phần mô tả)
update Product
set Product_Image = 'https://cdn-mms.hktvmall.com/HKTV/mms/uploadProductImage/ef95/7974/98bf/uFrkWaECgO20240705143836_515.jpg'
where Product_ID = 3

SELECT * FROM Product;
select * from Users

select * from Role

select * from Product where Category_ID = 1

update Category
set Category_Image = 'fa-gamepad'
where Category_ID = 4;

select * from Category



select * from Category


ALTER TABLE Orders
ADD Order_FullName VARCHAR(100);

update Orders
set Order_FullName = 'User 01'
where Order_ID

INSERT INTO Orders (User_ID, Shipping_Address, Order_Phone, Note, Total_Amount, Payment_Method, Status)
VALUES 
(3, '789 User Road', '0111222333', 'Please deliver quickly', 1029.98, 'COD', 'Processing');

select * from Orders

-- Tìm tên constraint
SELECT name
FROM sys.check_constraints
WHERE parent_object_id = OBJECT_ID('Orders') AND definition LIKE '%Payment_Method%';

-- Sau đó xóa constraint đó:
ALTER TABLE Orders DROP CONSTRAINT CK__Orders__Payment___628FA481;
-- Rồi mới DROP COLUMN
ALTER TABLE Orders DROP COLUMN Payment_Method;

ALTER TABLE Orders
ADD CONSTRAINT CK_Orders_PaymentMethod
CHECK (Payment_Method IN ('COD', 'InStore'));

DELETE FROM Orders
WHERE Order_ID = 2;

DELETE FROM Order_Detail
WHERE Order_ID = 2;

select * from Order_Detail

select * from Orders

select * from Product

DBCC CHECKIDENT ('Orders', RESEED, 1);
DBCC CHECKIDENT ('Order_Detail', RESEED, 2);

Select max(Order_ID) from Orders
Select max(Order_Detail_ID) from Order_Detail

select * from Spec_Type

SELECT Product_ID, Spec_ID , COUNT(*) AS SoLanLap
FROM Product_Spec
GROUP BY  Product_ID, Spec_ID
HAVING COUNT(*) > 1;


WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Spec_Name, Group_ID
               ORDER BY Spec_ID
           ) AS rn
    FROM Spec_Type
)
DELETE FROM CTE
WHERE rn > 1
AND Spec_ID NOT IN (
    SELECT Spec_ID FROM Product_Spec
);

DELETE FROM Spec_Type
WHERE Spec_ID BETWEEN 62 AND 80;

SELECT DISTINCT Spec_ID
FROM Product_Spec
WHERE Spec_ID BETWEEN 62 AND 80;

DELETE FROM Product_Spec
WHERE Product_Spec_ID BETWEEN 1358 AND 1403;

Select * from Product_Spec
Select * from Product
