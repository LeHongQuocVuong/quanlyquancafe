CREATE DATABASE QuanLyQuanCafe
GO

USE QuanLyQuanCafe
GO

-- Food
-- Table
-- FoodCategory
-- Account
-- Bill
-- BillInfo

create table TableFood
(
	id int identity primary key,
	name nvarchar(100) not null default N'Chưa đặt tên',
	status nvarchar(100) not null default N'Trống' --Trống || Có người 
)
GO

create table Account
(
	UserName nvarchar(100) primary key,
	DisplayName nvarchar(100) not null default N'QuocVuong',
	PassWord nvarchar(1000) not null default 0,
	Type int not null default 0 -- 1:admin || 0:staff
)
GO

create table FoodCategory
(
	id int identity primary key,
	name nvarchar(100) not null default N'Chưa đặt tên'
)
GO

create table Food
(
	id int identity primary key,
	name nvarchar(100) not null default N'Chưa đặt tên',
	idCategory int not null,
	price float not null default 0

	FOREIGN KEY (idCategory) REFERENCES dbo.FoodCategory(id)
)
GO

create table Bill
(
	id int identity primary key,
	DateCheckIn date not null default getdate(),
	DateCheckOut date,
	idTable int not null,
	status int not null  default 0-- 1: Đã thanh toán, 0: Chưa thanh toán

	FOREIGN KEY (idTable) REFERENCES dbo.TableFood(id)
)
GO

create table BillInfo
(
	id int identity primary key,
	idBill int  not null,
	idFood int not null,
	count int not null default 0

	FOREIGN KEY (idBill) REFERENCES dbo.Bill(id),
	FOREIGN KEY (idFood) REFERENCES dbo.Food(id)
)
GO

INSERT INTO dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Type
)
VALUES
(   N'quocvuong', -- UserName - nvarchar(100)
    N'quocvuong', -- DisplayName - nvarchar(100)
    N'1', -- PassWord - nvarchar(1000)
    1    -- Type - int
    )

INSERT INTO dbo.Account
(
    UserName,
    DisplayName,
    PassWord,
    Type
)
VALUES
(   N'staff', -- UserName - nvarchar(100)
    N'staff', -- DisplayName - nvarchar(100)
    N'1', -- PassWord - nvarchar(1000)
    0    -- Type - int
    )
GO

CREATE PROC USP_GetAccountByUserName
@userName NVARCHAR(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO

EXEC dbo.USP_GetAccountByUserName @userName = N'quocvuong' -- nvarchar(100)
GO

CREATE PROC USP_Login
@userName NVARCHAR(100) , @passWord NVARCHAR(100)
AS
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName AND PassWord = @passWord
END
GO

-- Thêm bàn
DECLARE @i INT = 0

WHILE @i <= 21
BEGIN
	INSERT dbo.TableFood(name) VALUES(N'Bàn ' + CAST(@i AS NVARCHAR(100)))
	SET @i = @i + 1
END
GO

CREATE PROC USP_GetTableList
AS SELECT * FROM dbo.TableFood
GO

UPDATE dbo.TableFood SET status = N'Có người' WHERE id = 9
GO

EXEC dbo.USP_GetTableList
GO

-- thêm category
INSERT dbo.FoodCategory
	(name)
VALUES
(N'Hải sản' -- name - nvarchar(100)
    )

INSERT dbo.FoodCategory ( name )
VALUES (N'Nông sản')

INSERT dbo.FoodCategory ( name )
VALUES (N'Lâm sản')

INSERT dbo.FoodCategory ( name )
VALUES (N'Sản sản')

INSERT dbo.FoodCategory ( name )
VALUES (N'Nước')
GO

-- Thêm món ăn
INSERT dbo.Food
	(name, idCategory, price)
VALUES
(   N'Mực một nắng nướng sa tế', -- name - nvarchar(100)
    1,   -- idCategory - int
    120000  -- price - float
    )

INSERT dbo.Food (name, idCategory, price)
	VALUES (   N'Nghêu hấp xả', 1, 50000 )

INSERT dbo.Food (name, idCategory, price)
	VALUES (   N'Vú dê nướng sữa', 2, 60000 )

INSERT dbo.Food (name, idCategory, price)
	VALUES (   N'Heo rừng nướng muối ớt', 3, 75000 )

INSERT dbo.Food (name, idCategory, price)
	VALUES (   N'Cơm chiên mushi', 4, 999999 )

INSERT dbo.Food (name, idCategory, price)
	VALUES (   N'7up', 5, 15000 )

INSERT dbo.Food (name, idCategory, price)
	VALUES (   N'Cafe', 5, 12000 )
GO

-- Thêm Bill
INSERT dbo.Bill
	(
		DateCheckIn,
		DateCheckOut,
		idTable,
		status
	)
VALUES
	(   GETDATE(), -- DateCheckIn - date
		NULL, -- DateCheckOut - date
		1,         -- idTable - int
		0          -- status - int
		)

INSERT dbo.Bill
	(DateCheckIn, DateCheckOut, idTable, status)
VALUES
	(   GETDATE(), NULL, 2, 0 )

INSERT dbo.Bill
	(DateCheckIn, DateCheckOut, idTable, status)
VALUES
	(   GETDATE(), GETDATE(), 2, 1 )

GO

-- Thêm FillInfo
INSERT dbo.BillInfo
	(
		idBill,
		idFood,
		count
	)
VALUES
	(   1, -- idBill - int
		1, -- idFood - int
		2  -- count - int
		)

INSERT dbo.BillInfo
	(idBill, idFood, count)
VALUES
	(   1, 3, 4 )

INSERT dbo.BillInfo
	(idBill, idFood, count)
VALUES
	(   1, 5, 1 )

INSERT dbo.BillInfo
	(idBill, idFood, count)
VALUES
	(   2, 3, 4 )

INSERT dbo.BillInfo
	(idBill, idFood, count)
VALUES
	(   2, 6, 2 )

INSERT dbo.BillInfo
	(idBill, idFood, count)
VALUES
	(   3, 5, 2 )

GO

