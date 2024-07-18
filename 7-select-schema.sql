
--نمونه سلکت از دیتا بیس
select 
	o.OrderID , o.CustomerID , o.EmployeeID , o.OrderDate
from dbo.Orders as o;
Go

--دریافت اسکیمای پیش فرض دیتا بیس ما
select SCHEMA_NAME();
go

--دریافت لیست اسکیما های دیتابسی جاری
select * from sys.schemas
go

--ساخت اسکیما به اسم دلخواه
create schema Mahdi;
go

--ساخت جدول در اسکیمای ایجاد شده توسط من
create table Mahdi.Tbl1
(
	Id int
);
go

--اطلاعات جداول و اسکیمای مربوط به آن ها 
--بدون شرط تمامی جداول را می آورد
select * from INFORMATION_SCHEMA.TABLES
where TABLE_NAME = 'Tbl1'

--در سلکت زدن اول اسکیمای پیش فرض را نگاه می کند اگر جدول در اسکیمای درگری باشد 
-- باید صراحتا اعلام شود
select *
from Mahdi.Tbl1;
go

insert into Mahdi.Tbl1(Id)
values(1),(2),(3),(4),(5);
go

--اول جداول داخش حذفش شوند بعد خودش !!!
drop schema if exists Mahdi;
go