use NikamoozDB;


--شرکت های که بیش از 10 سفارش داشته اند 
--subquery in select
select
	o.CustomerID , (select c.CompanyName
						from dbo.Customers as c
							where o.CustomerID = c.CustomerID) 
from dbo.Orders as o
group by o.CustomerID
having Count(o.OrderID) > 10;
go

--حالت غیر مناسب چون نال هارو هم می آورد
select
	c.CompanyName , (select count(o.OrderID) from dbo.Orders as o
						where c.CustomerID = o.CustomerID
							having count(o.OrderID) > 10) as num
		from dbo.Customers as c

--روش دوم که مشکل دارد
--outter query => customer
--راه حل اول
select
	c.CompanyName,
		(select count(o.OrderID)
			from dbo.Orders as o
			where c.CustomerID = o.CustomerID)
from dbo.Customers as c
where (select count(o2.OrderID)
		from dbo.Orders as o2
			where o2.CustomerID = c.CustomerID) > 10;
go


--راه حل دوم استفاده از drive table
select * 
from (select
			c.CompanyName ,
					(select count(o.OrderID) from dbo.Orders as o
						where c.CustomerID = o.CustomerID
							having count(o.OrderID) > 10) as num
		from dbo.Customers as c) as tmp
where tmp.num is not null;
go

--روش دوم drive table
select * 
from (select
			c.CompanyName ,
			(select count(o.OrderID) from dbo.Orders as o
			where c.CustomerID = o.CustomerID
			having count(o.OrderID) > 10) as num
	from dbo.Customers as c) as tmp
where tmp.num > 10;
go

--نکته نمی توان به صورت تنها از order by در drive table استفاده کرد
--راه حل استفاده از ترکیب top & drive table 

select tmp.CustomerID
from (
select
	o.CustomerID
from dbo.Orders as o
order by o.CustomerID) as tmp

--راه حل ترکیب top order by

select tmp.CustomerID
from (
select distinct top 10000
	o.CustomerID
from dbo.Orders as o
order by o.CustomerID) as tmp

--نکته دو فیلد هم نام نمی توان در درایو تیبل گذاشت
--راه حل alias دادن به نام جدول


------------------------------------------

--کدام مشتری ها در هر فاکتور بیش از 5 مورد کالا سفارش داده اند
--join subquery driveTable

select
	 distinct o.CustomerID,count(od.OrderID) as num
from dbo.Orders as o
join dbo.OrderDetails as od
	on o.OrderID = od.OrderID
where o.OrderID = od.OrderID
	group by o.CustomerID ,o.OrderID
	having count(od.OrderID) > 5;
go

--subquery
--order is outter
select o.CustomerID
		,(select count(od.OrderID) from dbo.OrderDetails as od
			where o.OrderID = od.OrderID
			group by od.OrderID
			having count(od.OrderID) > 5) as num
from dbo.Orders as o
order by num;
go

--orderDetail in outter
select
		distinct count(od.OrderID)
		,(select  o.CustomerID from dbo.Orders as o
			where od.OrderID = o.OrderID) as cId
from dbo.OrderDetails as od
group by od.OrderID
having count(od.OrderID) > 5;
go

--drive table
--غیر هوشمندانه
select 
	 tmp.CustomerID , tmp.num
from (select o.CustomerID
		,(select count(od.OrderID) from dbo.OrderDetails as od
			where o.OrderID = od.OrderID
			group by od.OrderID
			having count(od.OrderID) > 5) as num
from dbo.Orders as o) as tmp
where tmp.num is not null
group by tmp.CustomerID , tmp.num;
go

--drive table
--هوشمندانه خارج کردن فیلتر 
--having از drive table
select 
	 tmp.CustomerID , tmp.num
from (select o.CustomerID
		,(select count(od.OrderID) from dbo.OrderDetails as od
			where o.OrderID = od.OrderID
			group by od.OrderID) as num
from dbo.Orders as o) as tmp
where tmp.num > 5
group by tmp.CustomerID , tmp.num;
go

--drive table تو در تو
select
	dt2.orderYear , dt2.cust_num
from (select
		dt1.orderYear , count(distinct dt1.CustomerID) as cust_num
		from (
			select year(OrderDate) as orderYear,CustomerID
				from dbo.Orders) as dt1
		group by orderYear) as dt2;
go


----------------- Part 2 CTE -----------------
--non recursive and recursive
 --دریافت کد و نام شرکت های تهرانی 
 --با استفاده مجدد
 --با درایو تیبل برای جوین مجبور به تکرار کد می شویم
 with tehran_customer
 as
 (
	select
		c.CustomerID , c.CompanyName
	from dbo.Customers as c
	where c.State = N'تهران'
 )
 select 
	tc1.CompanyName , tc1.CustomerID
	from tehran_customer as tc1
	join tehran_customer as tc2
	on tc1.CustomerID = tc2.CustomerID;
go

--کوئری بنویسید که تا مشخص کند در هر سال جه تعداد مشتری داریم

with customersCte
as
(
	select
		 Year(o.OrderDate) as yearOrder , o.CustomerID 
	from dbo.Orders as o
)
select 
	c.yearOrder , 
	count(distinct c.CustomerID) as num
from customersCte as c
group by c.yearOrder;
go

--فهرست تعداد مشتریان هرسال و سال قبل از آن و بررسی میزان افزایش یا کاهیش
--تعداد مشتری نسبت به سال قبل 
--محاسبه تعداد مشتری ها در بخش کوئری دورنی cte انجام شود
--join
select
		year(o1.OrderDate) as orderYear,
		count(distinct o1.CustomerID) as cust_num,
		count(distinct o2.CustomerID) as previous,
		count(distinct o1.CustomerID) - count(distinct o2.CustomerID) as growth
from dbo.Orders as o1
left join dbo.Orders as o2
	on Year(o1.OrderDate) = Year(o2.OrderDate) + 1
group by Year(o1.OrderDate) , Year(o2.OrderDate);
go

--cte
with cust_per_year
as
(
	select
		Year(o1.OrderDate) as orderYear,
		count(distinct o1.CustomerID) as cust_num
		from dbo.Orders as o1
		group by Year(o1.OrderDate)
)
select
	c.orderYear,
	c.cust_num as custNum,
	ISNULL(p.cust_num,0) as previousCustNum,
	c.cust_num - ISNULL(p.cust_num,0) as growth
from cust_per_year as c
left join cust_per_year as p
	on c.orderYear = p.orderYear +1;
go


















 

















































