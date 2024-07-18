use test01;
go

--اگر جدول وجود داشت آن را حذف کن
drop table if exists UserTable;
go

--ایجاد جدول با 2 ستون و نام یوزر
create table UserTable
(
	Code Int Not Null,
	Family Nvarchar(100) null
);
go

--اطلاعات مربوط به جدول را به ما می دهد
exec SP_HELP 'UserTable';
go

--اطلاعاتی راجب جدول به ما میدهد 2
select * from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME = 'UserTable';
go

--افزودن داده به جدول
insert into UserTable(Code,Family)
Values(1,N'امیری'),(2,N'کریمی');
go

select * from UserTable;
go

--حذف جدول در صورت جود داشتن
drop table if exists UserTable;
go

--ساخت مجدد جدول با نوع داده متفاوت
create table UserTable
(
	Family Varchar(10)
);
Go

select * from UserTable

--تغییر نوع داده جدول 
alter table UserTable
alter column Family Nvarchar(100);
Go

--درج رکورد به جدول
insert into UserTable(Family)
	Values(N'امیدی'),(N'امیری'),(N'سلیمی');
Go

select * from UserTable

--درج کاراکتر بزرگتر از نوع داده جدول
insert into UserTable(Family)
Values(N'dksdf kjadsf iedksdf kdsfk ksdfhse osdfh kjsdfh osheo hghsdkeog hsdhf kksdleh hsdkkeowhfu
kjakf khshf idheiwhdxmxhkdhg kskerk')

--ساخت جدولی با ستونی که داری گام شروع و شمارنده است
create Table IdentityUsers
(
--از 1 شروع کن و یکی یکی برو جلو یا بیا عقب-1 یا 10 تا 10 تا برو جلو 
--نکته ستون که ادنتیتی است خودش مقدار می گیرد
	ID int Identity(1,1),
	Family Nvarchar(50)
);
go

select * from IdentityUsers


insert into IdentityUsers(Family)
values(N'جواد'),(N'مهران'),(N'مهدی'),(N'حمید'),(N'جلیل'),(N'غلی');
go

--اضافه کردن ستون به جدول
--این 2 ستون نال پذیر هستند و به ازای مقادیری که مقدار ندارد
--مقدار نال می دهیم
alter table IdentityUsers
Add Country Nvarchar(50) null,
    City Nvarchar(50) null;
go