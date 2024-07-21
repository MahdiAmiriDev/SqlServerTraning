use NikamoozDB;
go


--ترکیب تمامی حالت های کارمندان با مشتری ها از 2 جدول متفاوت
select 
		c.CustomerID,e.EmployeeID
from dbo.Customers as c
cross join dbo.Employees as e;
go

--کراس جوین 2 جدول متفاوت با استفاده از الیاس در حالتی که فیلد مشرک بین 2 جدول است
select
		c.CustomerID , o.EmployeeID
from dbo.Customers as c
cross join dbo.Orders as o;
go

--cross join with where filter ----
select
		c.CustomerID , e.EmployeeID
from dbo.Customers as c
cross join dbo.Employees as e
where c.CustomerID > 90;
go


--------------- Self Join --------------
--یک جدول را با خودش ترکیب کنیم

select
	e1.FirstName,e1.LastName,
	e2.FirstName,e2.LastName
from dbo.Employees as e1
cross join dbo.Employees as e2
order by e1.FirstName,e1.LastName;
go

select
	e1.FirstName,--e1.LastName,
	--e2.FirstName,
	e2.LastName
from dbo.Employees as e1
cross join dbo.Employees as e2
order by e1.FirstName,e1.LastName;
go

-- 2تا ایراد دارد 
-- خود نفر را با خودش تکرار می کند
--دوم
--یک بار علی را محمد زده دفعه دوم محمد را با علی می دهد تکرار دارد

---------------------------- inner Join -------------

--نام و نام خانوادگی کارمند های که تابه حال ثبت سفارش داشته اند به همراه شناسه سفارش کارمند
select
		e.FirstName,e.LastName,o.OrderID
from dbo.Employees as e
inner join dbo.Orders as o
on e.EmployeeID = o.EmployeeID;
go

--همون بالایی به شرط این که نام خانوادگی طرف با الف شروع نشده باشد
select
		e.FirstName,e.LastName,o.OrderID
from dbo.Employees as e
inner join dbo.Orders as o
on e.EmployeeID = o.EmployeeID
where e.LastName not like N'ا%';
go

--کوئری بنویسید که شامال فهرست شهرهای مشتری های باشد که بیش از 50 سفارش در سیستم ثبت کرده اند
select
		c.City,Count(o.OrderID)
from dbo.Orders as o
inner join dbo.Customers as c
on o.CustomerID = c.CustomerID
group by c.City
having Count(o.OrderID) > 50;
go


--کوئری بنویسید که مشخص کند کدام شهر کم ترین ثبت سفارش را داشته است
select
		top 1 with ties
		c.City,
		Count(o.OrderID) as orderCount
from dbo.Orders as o
inner join dbo.Customers as c
on o.CustomerID = c.CustomerID
group by c.City
order by orderCount asc;
go

--کوئری بنویسید که تا 3 محصولی که بیشترین فروش را از آن ها داشته ایم در نتایح نمایش دهد

select
		top 3
		p.ProductName,
		sum(od.Qty) as Total
from dbo.Products as p
inner join dbo.OrderDetails as od
on p.ProductID = od.ProductID
group by  p.ProductName
order by Total desc;
go

------ inner join : Composite join --------------

--ترکیب درست بودن 2 تا فیلد مشترک بین 2 جدول را می آورد

--select
--		c1.name,
--		c2.serial
--from dbo.comp1 as c1
--join dbo.com2 as c2
--on c1.id1 = c2.id1
--and c1.id2 = c2.id2


------------- non equi join ----------------------

-- تمامی ترکیبات دوتایی غیرتکراری از نام و نام خانوادگی کارمندان
select
		e1.EmployeeID,e1.FirstName,e1.LastName,
		e2.EmployeeID,e2.FirstName,e2.LastName
from dbo.Employees as e1
join dbo.Employees as e2
on e1.EmployeeID > e2.EmployeeID
order by e1.EmployeeID,e1.FirstName,e1.LastName;
go

--تمامی ترکیبات دوتایی از نام و نام خانوادگی کارمندان به جز حالت تشابه میان 
--یک کارمند با خودش در خروجی نمایش دهید
select
		e1.EmployeeID,e1.FirstName,e1.LastName,
		e2.EmployeeID,e2.FirstName,e2.LastName
from dbo.Employees as e1
join dbo.Employees as e2
on e1.EmployeeID <> e2.EmployeeID
order by e1.EmployeeID,e1.FirstName,e1.LastName;
go

------------------ Multi Join -------------------

--نام شرکت شناسه سفارش و شناسه محصول به همراه تعداد محصول خریداری شده در هر سفارش را نمایش دهید
select
		c.CompanyName,o.OrderID,od.ProductID,od.Qty
from dbo.Orders as o
join dbo.Customers as c
on o.CustomerID = c.CustomerID
join dbo.OrderDetails as od
on o.OrderID = od.OrderID;
go

--تمامی سفارش های درخواست شده به همراه مجموع تمام کالا های 
--هر سفارش که مربوط به شرکت های باشند که در استان تهران هستند

select
		o.CustomerID,c.CompanyName,o.OrderID,
		sum(od.Qty) as quantity
from dbo.Orders as o
join dbo.Customers as c
on o.CustomerID = c.CustomerID
join dbo.OrderDetails as od
on o.OrderID = od.OrderID
where c.State = N'تهران'
group by o.CustomerID,c.CompanyName,o.OrderID
go

--کوئری بنویسید که تعداد سفارش ها به همراه مجموه کل محصولات سفارش داده شده توسط
--شرکت های تهرانی را نمایش دهد
select
		 o.CustomerID,c.CompanyName,
		 Count(distinct o.OrderID) as orderCount,
				sum(od.Qty) as quantity
from dbo.Orders as o
join dbo.Customers as c
on o.CustomerID = c.CustomerID
join dbo.OrderDetails as od
on o.OrderID = od.OrderID
where c.State = N'تهران'
group by o.CustomerID,c.CompanyName
go
















