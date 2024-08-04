use NikamoozDB;
go

--شرکت های که بیش از 10 سفارش داشته اند
select 
	c.CompanyName,c.CustomerID
from dbo.Orders as o
join dbo.Customers as c
on o.CustomerID = c.CustomerID
group by c.CompanyName , c.CustomerID
having Count(o.OrderID) > 10
order by c.CustomerID;
go

--روش اول در where
select 
	c.CompanyName , c.CustomerID
from dbo.Customers as c
where c.CustomerID in (select	
						o.CustomerID
						from dbo.Orders as o
						group by o.CustomerID
						having count(o.OrderID) > 10);
go

--روش دوم در where
select 
	c.CompanyName , c.CustomerID
from dbo.Customers as c
where (select count(o.OrderID)				
		from dbo.Orders as o
		where c.CustomerID = o.CustomerID) > 10;
go

--روش سوم در where
select 
	c.CompanyName , c.CustomerID
from dbo.Customers as c
where c.CustomerID = (select o.CustomerID
						from dbo.Orders as o
						where o.CustomerID = c.CustomerID
						group by o.CustomerID
						having count(o.OrderID) > 10);
go

--روش اول exists
select
	c.CustomerID , c.CompanyName
from dbo.Customers as c
where exists (select 1
				from dbo.Orders as o
				where o.CustomerID = c.CustomerID
				having count(o.OrderID) > 10);
go

--روش اول در select
select
	c.CompanyName,
	(select
	 c.CustomerID
	from dbo.Orders as o
	where c.CustomerID = o.CustomerID
	having count(o.OrderID) > 10)
from dbo.Customers as c;
go

--روش دوم با select
--این روش از قبلی هم بهتره
select
	 o.CustomerID,
	 (select c.CompanyName
	 from dbo.Customers as c
	 where c.CustomerID =  o.CustomerID) as companyName
from dbo.Orders as o
group by o.CustomerID
having Count(o.OrderID) > 10

--تعداد سفارش شرکت هایی که در زنجان هستند
--join
select
	c.CompanyName,
	Count(o.OrderID) as num
from dbo.Customers as c
left join dbo.Orders as o
on o.CustomerID = c.CustomerID
where c.State = N'زنجان'
group by c.CompanyName;
go

--subquey select
select
	 c.CompanyName ,
	 (select count(o.OrderID) from dbo.Orders as o
		where c.CustomerID = o.CustomerID)
from dbo.Customers as c
where c.State = N'زنجان'

--روش اشتباه
select
	count(o.OrderID) as num
	,(select c.CompanyName from dbo.Customers as c
		where c.CustomerID = o.CustomerID and c.State = N'زنجان')
from dbo.Orders as o
group by o.CustomerID;
go

--- کوئری بنویسید که محصولاتی که قیمت واحد آن ها از میانگین قیمت محصولات بیشتر یا برابر است
--روش اشتباه
select
	p.ProductID , p.UnitPrice
from dbo.Products as p
group by p.ProductID , p.UnitPrice
having p.UnitPrice >= AVG(p.UnitPrice);
go
--روش دوم صحیح است
select
	p.ProductID , p.UnitPrice
from dbo.Products as p
where (p.UnitPrice) >= (select avg(p2.UnitPrice) 
						from dbo.Products p2);
go


--مشخصات کارمندی که کم ترین تعداد ثبت سفارش را داسته است
select top 1 o.EmployeeID , e.FirstName , e.LastName,
		Count(o.OrderID)
from dbo.Orders as o
join dbo.Employees as e
on o.EmployeeID = e.EmployeeID
group by o.EmployeeID , e.FirstName , e.LastName
order by Count(o.OrderID);
go
--In Subquery
select e.EmployeeID,e.FirstName , e.LastName
from dbo.Employees as e
where e.EmployeeID in (select top 1  EmployeeID 
						from dbo.Orders as o
							group by EmployeeID
							order by Count(o.OrderID))
--IN WHERE SECOND
select e.EmployeeID,e.FirstName , e.LastName
from dbo.Employees as e
where e.EmployeeID = (select top 1  EmployeeID 
						from dbo.Orders as o
							group by EmployeeID
							order by Count(o.OrderID))
--Subquery in Select 
select
	top 1 o.EmployeeID,(select e.FirstName 
					from dbo.Employees as e
					where e.EmployeeID = o.EmployeeID),
					(select e.LastName 
					from dbo.Employees as e
					where e.EmployeeID = o.EmployeeID)
from dbo.Orders as o
group by o.EmployeeID
order by count(o.OrderID);
go

--subquery in order by clause
select top 1
		FirstName,LastName,EmployeeID
	from dbo.Employees as e
	order by (select count(o.OrderID) from dbo.Orders as o
				where o.EmployeeID = e.EmployeeID);
go

--مشخصات شرکت های که حداقل در یکی از ماه های سال 2015 سفارش داشته اما
--در سال 2016 هنوز درخواست سافرش نداشتها ند
select
	c.CompanyName,c.CustomerID
from dbo.Customers as c
where exists (select 1
				from dbo.Orders as o
					where c.CustomerID = o.CustomerID
					and Year(o.OrderDate) = 2015)
except
select
	c.CompanyName,c.CustomerID
from dbo.Customers as c
where exists (select 1
				from dbo.Orders as o
					where c.CustomerID = o.CustomerID
					and Year(o.OrderDate) = 2016);
go

--with exists and not exists
select
	 c.CustomerID , c.CompanyName
from dbo.Customers as c
where exists (select 1 from dbo.Orders as o
				where c.CustomerID = o.CustomerID
				and Year(o.OrderDate) = 2015 and not exists
				(select 1 from dbo.Orders as o2
				where o2.CustomerID = c.CustomerID
				and year(o2.OrderDate) = 2016));
go

--with in
select
	c.CustomerID , c.CompanyName
from dbo.Customers as c
where c.CustomerID in (select o.CustomerID from dbo.Orders as o
				where c.CustomerID = o.CustomerID
				and Year(o.OrderDate) = 2015)
and c.CustomerID not in (select o.CustomerID from dbo.Orders as o
				where c.CustomerID = o.CustomerID
				and Year(o.OrderDate) = 2016)

