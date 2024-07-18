--ساخت جدول به همراه کانسترینت های داده شده
create table Students 
(
	NationalCode int Constraint myConst1 Default 0,
	Family Nvarchar(100) not null,
	MedicalStatus Nvarchar(100) Constraint MyConst2 Default N'ندارد',
	BloodGroup Nvarchar(100) Constraint MyConst3 Default N'0000'
);
Go

--مشاهده constraint های جدول ساخته شده
SP_HelpConstraint 'Students';
go

insert into Students(Family)
values (N'احمدی'),(N'راد'),(N'سعیدی');
go

--کانسترینت های پیش فرص همگی اعمال شده اند
select * from Students

--مفدار پیش فرض را برای ستون های قبلی نیز می گذارد
Alter table Students 
Add Code2 int default 99 with values;
go

select * from Students

--مقدار پیش فرض را برای ستون های قبلی نمی گذارد
Alter table Students 
Add Code3 int default 99;
go

--ویرایش جدول و مقدار پیش فرض برای شهر اضافه شده
alter table students 
add Default N'تهران' for city

-- Check Constraint ------

create table Employees
(
	Id int constraint checkValue Check (id >= 100),
	Country Nvarchar(100) Constraint CheckCountry Check(Country in (N'ایتالیا',N'ایران',N'آمریکا')),
	Barcode varchar(100) Check (Barcode Like ('[0-9][a-h]%'))
);
go

sp_helpConstraint 'Employees';
go

--درج در جدول 
insert into Employees
values(100,N'آمریکا','0a/'),(101,N'ایران','1e/ir'),(100,N'ایتالیا','8h/10');
go

select * from Employees

--خطا دارد
insert into Employees
values(99,N'آمریکا','0a/')
go

--خطا دارد
insert into Employees
values(100,N'لهستان','0a/')
go

Alter table Employees
Add Col1 int default -1 with values
go

select * from Employees

--به ستونی که از قبل وجود دارد یک شرط چکینگ اضافه می کنیم 
-- چون از قبل مقدار داریم و این شرط را نقض می کند
--عبارت کلیدی را می نویسیم که قبلی ها را ایراد نگیرد
alter table Employees
With NoCheck Add Check (Col1 > 1000);
go

--درج خطا دارد چون شرط رعایت نشده است
insert into Employees
values(101,N'آمریکا','0a/',999);
go

--درج صحیح
insert into Employees
values(101,N'آمریکا','0a/',1001);
go