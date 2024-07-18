use test01

--ایجاد جدولی که دارای یک کلید اصلی است
create table Students01
(
	Code Int Constraint pk Primary Key,
	FirstName Nvarchar(188),
	LastName Nvarchar(188),
	Age Int
);
Go

sp_helpConstraint 'Students01';
Go

--در درج کردن به جدول لازم نیست حتما ستون هارو معرفی کینم
insert into Students01
Values(1000,N'سمیرا',N'احمدی',15),(1001,N'جعفر',N'جباری',14);
go

select * from Students01;
go

--خطای درج چون که فیلد اولی کلید اصلی است
insert into Students01
Values(1000,N'مهدی',N'امیری',15)
go

insert into Students01
Values(null,N'مهدی',N'امیری',15)
go

--کلید اصلی در سطح جدول
--نیاز است اول فیلد تعریف شود دوم کانسترینت

drop table Students01

--کلید ترکیبی در سطح جدول
create table Stud
(
	Code Int,
	FirstName Nvarchar(188),
	LastName Nvarchar(188),
	Age Int,
	Constraint pkComposite PRIMARY KEY(Code,FirstName)
);
Go


insert into Stud(Code,FirstName,LastName,Age)
values(1,N'علی',N'جباری',2)

select * from Stud

--باید ترکیب هر دو تکراری نباشد 
--اگر یکی تکراری باشد مشکلی ندارد
insert into Stud(Code,FirstName,LastName,Age)
values(2,N'علی',N'sghl',2)