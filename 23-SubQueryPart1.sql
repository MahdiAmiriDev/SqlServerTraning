 

 -- self contain subQuery
 -- in Where
 --جدید ترین سفارش با تاپ

 select top 1
		o.OrderID , o.OrderDate , o.EmployeeID , o.CustomerID,
		MAX(o.OrderDate) as newsOrder
 from dbo.Orders as o
 group by o.OrderID , o.OrderDate , o.EmployeeID , o.CustomerID
 order by o.OrderID desc;
 go

 --جدید ترین سفارش
select 
		o.OrderID , o.OrderDate , o.EmployeeID , o.CustomerID,
		MAX(o.OrderDate) as newsOrder
 from dbo.Orders as o
 group by o.OrderID , o.OrderDate , o.EmployeeID , o.CustomerID
 order by o.OrderID desc
 offset 0 rows fetch next 1 rows only;
 go

 --جدید ترین سفارش با متغییر
 declare @maxId as int = (select Max(OrderID) from dbo.Orders);
 select 
	o.EmployeeID,o.CustomerID,o.OrderID
 from dbo.Orders as o
	where OrderID = @maxId;
 go

 --مثال بالا با ساب کوئری مستقل
 select
	o.EmployeeID,o.CustomerID,o.OrderID,o.OrderDate
 from dbo.Orders as o
 where o.OrderID = (select max(o.OrderID) from dbo.Orders as o);
 go

 ----- subquery in select ----------
 
 --تعداد سفارش مشتری های
 select
		o.CustomerID , count(o.OrderID) as countOrder,830
 from dbo.Orders as o
 group by o.CustomerID;
 go

 --تعداد فارش هر مشتری به همراه تعداد کل سفارش های موجود
 declare @orderCount as int = (select count(OrderID) from dbo.Orders);
 select
		o.CustomerID,Count(o.OrderID) as num,
		@orderCount as total
from dbo.Orders as o
group by o.CustomerID;
go

--تعداد سفارش هر مشتری به همراه تعداد کل سفارش ثبت شده با subqry
--self contained subquery
 select
		o.CustomerID,Count(o.OrderID) as num,
		(select count(OrderID) from dbo.Orders) as total
from dbo.Orders as o
group by o.CustomerID;
go

--کوئری بنویسد که علاوه بر تعداد سفارشهای ثبت شده توسط هر کارمند جدیدترین و قدیمی ترین سفارش
--ثبت شده در میان تمامی سفارش ها از تمامی کارمندان را هم نمایش بدهد

select
		o.EmployeeID,Count(o.OrderID) as num,
		(select max(OrderDate) from dbo.Orders) as MaxOrderDate,
		(select min(OrderDate) from dbo.Orders) as MinOrderDate
from dbo.Orders as o
group by o.EmployeeID;
go
--اگر اینطوری بنویسی به ازای هر کارمند مقدار را می دهدی که غلط می شود !!!!!!!!!!!
select
		o.EmployeeID,Count(o.OrderID) as num,
		max(OrderDate)as MaxOrderDate,
		min(OrderDate) as MinOrderDate
from dbo.Orders as o
group by o.EmployeeID;
go

---همه کارمندانی که نام خانوادگی آن ها با پ شروع بشود شماره سفارش رو بده
select
	o.OrderID , e.LastName 
from dbo.Employees as e
join dbo.Orders as o
	on e.EmployeeID = o.EmployeeID
where e.LastName like N'پ%';
go


--با subQuery self-contained
select
		o.OrderID
from dbo.Orders as o
	where o.EmployeeID = (select e.EmployeeID from dbo.Employees as e
								 where e.LastName like N'پ%');
go

--کوئری بالا فقط با حرف ت شروع شوند
-- نکته در این حالت بیش از یک مقدار می دهد ساب کوئری ما
--multi value VS Single Value
select
		o.OrderID
from dbo.Orders as o
	where o.EmployeeID in (select e.EmployeeID from dbo.Employees as e
								 where e.LastName like N'ت%');
go

--مشتری های ثبت سفارش نداشته اند را نمایش دهید از بین مشتری ها
select 
	c.CustomerID
from dbo.Orders as o
right join dbo.Customers as c
	on o.CustomerID = c.CustomerID
where o.OrderID is null

 --کوئری بالا با استفاده از subQuery
 select
	c.CustomerID
 from dbo.Customers as c
	where c.CustomerID not in (select o1.CustomerID from dbo.Orders as o1);
go

--مشاهده مشخصات تمامی شرکت های که ففط در تاریخ 
--2016-05-05 ثبت سفارش نداشته اند subQuery-MultiValue
select
	c.CustomerID , c.CompanyName
from dbo.Customers as c
	where c.CustomerID not in (select o.CustomerID from dbo.Orders as o
								where o.OrderDate = '2016-05-05');
go
--کوئری بالا با except
select
	c.CustomerID 
from dbo.Customers as c
except
	select o.CustomerID from dbo.Orders as o
								where o.OrderDate = '2016-05-05'
go


--کوئری بنویسید که فقط مشخصات شرکت هایی را نمایش دهد که سفارش های درخواست شده آن ها
--فرد بوده یا اصلا درخواست سفارش نداشته اند
select
	c.CustomerID , c.CompanyName
from dbo.Customers as c
where c.CustomerID not in (select distinct o.CustomerID from dbo.Orders as o
							where o.OrderID % 2 = 0);
go							

---------- SubQuery Corelated --------------------
--جدید ترین سفارش به ازای هر مشتری
select
	o.CustomerID , Max(o.OrderID) as MaxOrderd
from dbo.Orders as o
group by o.CustomerID

--with corelated subQuery
select
	distinct o1.CustomerID,
	(select Max(o2.OrderID)
		from dbo.Orders as o2
		where o1.CustomerID = o2.CustomerID) as MaxOrderId
from dbo.Orders as o1;
go
--کوئری بالا در قسمت where
select
	o1.CustomerID , o1.OrderID
from dbo.Orders as o1
where o1.OrderID = (select max(o2.OrderID) from dbo.Orders as o2 
					where o1.CustomerID = o2.CustomerID);
go

--نمایش تعداد سفارش همه شرکت ها حتی آن هایی که سفارش نداشته اند
select
	c.CustomerID , c.CompanyName,
	count(o.OrderID) as num
from dbo.Customers as c
left join dbo.Orders as o
	on c.CustomerID = o.CustomerID
group by c.CustomerID,c.CompanyName;
go

select	
	  c.CustomerID,c.CompanyName,
	(select count(o.OrderID) from dbo.Orders as o
		where c.CustomerID = o.CustomerID) as num
from dbo.Customers as c;
go

--مشتری که ثبت سفارش داشته را نشان نمی دهد چون 
--از جدول order که کوئری بیرونی است استفاده کردیم
--سفارش داشته ها را ففط می دهد
select
	o.CustomerID,
	(select c.CompanyName from dbo.Customers as c
	where o.CustomerID = c.CustomerID) as companyName
from dbo.Orders as o
group by o.CustomerID;
go

--تاریخ جدیدترین سفارش هر شرکت حتی آن های که سفارش نداشته اند
--with join
select
	c.CustomerID,c.CompanyName,
	Max(o.OrderDate) as newOrder
from dbo.Orders as o
RIGHT join dbo.Customers as c
on c.CustomerID = o.CustomerID
group by c.CustomerID,c.CompanyName;
go
--with corelated subquery in Select
select
	c.CustomerID,c.CompanyName,
	(select Max(o.OrderDate) from dbo.Orders as o
	where c.CustomerID = o.CustomerID) as num
from dbo.Customers as c;
go

----------- EXISTS -------
--نمایش لیست سفارش های موجود در جدول orders
select *
from dbo.Orders as o
where exists (select 1 from dbo.Customers
				where City = N'تهران') ;--حداقل یک مشتری در تهران باشد
go

select *
from dbo.Orders as o
where exists (select 1 from dbo.Customers
				where City = N'بیرجند') ;--حداقل یک مشتری در بیرجند باشد
go

select *
from dbo.Orders as o
where exists (select 1 from dbo.Customers
				where City = N'گرچ') ;--حداقل یک مشتری در گرج باشد
go


select *
from dbo.Orders as o
where not exists (select 1 from dbo.Customers
				where City = N'گرچ') ;--هیچ مشتری در کرج نباشد
go

--نمایش اطلاعات تمامی مشتری های دارای سفارش
select
	c.CustomerID
from dbo.Customers as c
where exists(select 1 from dbo.Orders as o
				where c.CustomerID = o.CustomerID);
go
--تمامی مشتری های که سفارش  نداشته اند
select
	c.CustomerID
from dbo.Customers as c
where not exists(select 1 from dbo.Orders as o
				where c.CustomerID = o.CustomerID);
go

--نام و نام خانوادگی کارمندانی که با مشتری شماره 18 سفارش داشته اند
select
	e.FirstName , e.LastName
from dbo.Employees as e
where e.EmployeeID in (select o.EmployeeID from dbo.Orders as o
						where o.CustomerID = 18);
go

--ترکیب بین 
--exists and corelated subquery
select
	e.FirstName , e.LastName
from dbo.Employees as e
where exists (select 1 from dbo.Orders as o
				where o.CustomerID = 18 and
					e.EmployeeID = o.EmployeeID);
go























































































