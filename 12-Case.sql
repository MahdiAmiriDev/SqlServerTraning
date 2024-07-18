

--نمونه از 
-- search case
select
	case
		when c.Region is null then N'بدون مقدار است'
		--when c.Region is not null then N'با مقدار است'
		Else c.Region
		End as Case_test 
from dbo.Customers as c;
go

--نمونه سیمپل کیس
select
	p.ProductID,p.ProductName,p.CategoryID,
	Case p.CategoryID
	when 1 then N't'
	when 2 then 'g'
	when 3 then 's'
	else 'sdf'
	End as CategoryName
from dbo.Products as p
order by CategoryName;
go


--سرچ نمونه دیگر
select od.ProductID , od.UnitPrice,
		case 
			when od.UnitPrice < 50 then 'kamter'
			when od.UnitPrice between 50 and 100 then '50 ta 100'
			when od.UnitPrice > 100 then 'bishtar'
			else 'unknow'
			end as UnitpriceCategory
from dbo.OrderDetails as od;
go


--sample 2 of search case
 select
		e.EmployeeID , e.FirstName , e.TitleofCourtesy,
		Case
			when e.TitleofCourtesy in ('Mrs.','Ms.') then 'Female'
			when e.TitleofCourtesy = 'Mr.' then 'Male'
			Else 'Unknow'
			End as Gender
 from dbo.Employees as e;
 go

--مقادیری که مچ نباشد نال میگیرد
select c.City ,
		case c.City
		when N'تهران' then N'پایتخت'
		End as N'نوع شهر'
from dbo.Customers as c;
go


--در حالت asc مقادیری که  null هستند را اول می آورد
-- و در حالت desc مقادیر  null  ار آخر می آورد
select
		c.CustomerID , c.Region
from dbo.Customers as c
order by c.Region asc;
go

--راه حل استفاده از کیس است
-- order by with case
--به همراه مرتب سازی 
select c.CustomerID , c.Region 
from dbo.Customers as c
order by 
		case when c.Region is null then 1 else 0 end --, c.Region;
go

--مثال کامل از سورتینگ و کیس
select c.CustomerID , c.Region 
from dbo.Customers as c
order by 
		case when c.Region is null then 1 else 0 end asc , c.Region asc,c.CustomerID desc;
go











