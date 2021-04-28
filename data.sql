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