


use NikamoozDB;
go

create table GroupTable
(
	Score int
);
go

insert into GroupTable
	values (2),(3),(4),(10);
go

-----------------Aggregate functions -----------------
select
		count(gt.Score) as num,
		SUM(gt.Score) as total,
		Max(gt.Score) as maxVal,
		Min(gt.Score) as minVal,
		Avg(gt.Score * 1.0) as avrg -- حالت عادی اینت می شناسد برای دریافت قسمت اعشار ضرب کردیم
								    --اگر اعشار نخواهیم خود اینت می دهد
									--در واقع تبدیل نوع داده انجام داده ایم
from dbo.GroupTable as gt;
go

--------------- Group by --------------

select distinct o.EmployeeID , o.CustomerID
from dbo.Orders as o
order by o.EmployeeID , o.CustomerID
--- خروجی 2 دستور بالا مشابه هم است
--گروه بندی می کند به این صورت که از هر گروه یک نمایده آورده و خروجی مشابه قبلی است
select o.EmployeeID , o.CustomerID
from dbo.Orders as o
group by o.EmployeeID , o.CustomerID;
go

--خطا هر فیلید در سلکت بیاید باید در گروپ بای هم موجود باشد
select 
		o.EmployeeID , o.CustomerID
from dbo.Orders as o
group by o.EmployeeID -- o.CustomerID;
go

--می توان گروه بندی مقداری داشته باشد که در سلکت نیامده باشد
select 
		o.EmployeeID 
from dbo.Orders as o
group by o.EmployeeID ,o.CustomerID;
go


--اگر فیلدی در گروه بندی نیامده باشد نمی توان آن را در 
-- مرتب سازی قرار گیرد
--چون فیلد ها بر اساس گروه بندی آورده می شوند پس نمی داند مرتب سازی باید 
--شماره سفارش کدام فیلد مورد استفاده قرار گیرد
select
	o.EmployeeID , o.CustomerID
from dbo.Orders as o
group by o.EmployeeID , o.CustomerID
order by o.OrderID

-------------group by with aggregate function ----------

--تعداد سفارش به ازای هر مشتری
 select
	o.CustomerID,COUNT(o.OrderID) as OrderCount ,
	Max(o.OrderDate) as LastOrderDate
 from dbo.Orders as o
 group by o.CustomerID;
 go

  
select
		c.City , c.State,
		count(c.CustomerID) as customerCount
from dbo.Customers as c
group by c.City , c.State

--تمرین
-- سفارش های هر کارمند به تفکیک هر سال که شامل تعدا کل سفارش و مجموع کرایه های ثبت شده
--توجه سال که از نوع اگریگیت نیست پش در گروپ بای شرکت کند
 select
		o.EmployeeID , 
		Year(o.OrderDate) as OrderYear,
		count(o.OrderID) as orderCount,
		sum(o.Freight) as Rate
 from dbo.Orders as o
 group by o.EmployeeID , Year(o.OrderDate)
 order by o.EmployeeID , OrderYear
 go














