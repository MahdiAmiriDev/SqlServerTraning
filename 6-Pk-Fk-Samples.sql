

create table Customers
(
	Id int Primary key,
	CompanyName Nvarchar(100)
);
Go

insert into Customers(Id,CompanyName)
Values(1,N'one'),(2,N'two'),(3,N'three');
go

select * from Customers

--ساخت جدول فرزند به این صورت که ارتباطی با جدول پدرش دارد
Create table Orders
(
	Id int References Customers(Id)
	On Delete Cascade
	On Update Cascade,
	OrderDate char(10)
);
Go


--درج مقادیر در جدول به صورت غیر تکراری
insert into Orders(Id,OrderDate)
Values(1,'12'),(2,'24'),(3,'2')
Go

--درچ رکوردی که یتیم است خطا میدهد
insert into Orders(Id,OrderDate)
Values(4,'54');
Go

--بروز رسانی پدر سبب بروزرسانی فرزند شده چون کس کید است
update Customers
set Id = 23
where Id = 1;
go

select * from Customers;
select * from Orders;

--سبب حذف فرزند شده تا یتیم نشود
delete Customers
where Id = 2

select * from Customers;
select * from Orders;


--کلید ترکیبی
create table Parent1
(
	Col1 int,
	col2 int,
	Primary key(col1,col2)
);
Go

--درج رکودر های در جدول
insert into Parent1
Values (1,1),(1,2),(2,1),(2,2);
go

--کلید ترکیبی در سطح جدول
create table Child2
(
  Fld1 int,
  Fld2 int,
  Title Nvarchar(30),
  Foreign key(Fld1,Fld2) References Parent1(Col1,Col2)
);
Go

create table Job_Type
(
	Id int Identity(0,10),
	Family Nvarchar(100),
	Title Nvarchar(50) Primary key
);
go


--نمونه پیشفرض شدن در صورت حذف مقدار
--نکته در جدول فرزند که چیزی را دیفالت می گذاریم حتما باید یک مثل خودش در 
--جدول پدر وچود داشته باشد
create table Emp
(
	Id int Identity(0,10) primary key,
	Family Nvarchar(100),
	JobTitle Nvarchar(50) References Job_Type(Title) On Delete Set Default Default N'unknow'
);
go 