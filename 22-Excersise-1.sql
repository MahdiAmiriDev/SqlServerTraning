
--کدام یک از مشتریان استان تهران کم ترین تعداد ثبت سفارش را داشته اند
select
		top 1 with ties
		c.CustomerID,Count(o.OrderID) as orderCount
from dbo.Orders as o
join dbo.Customers as c
on o.CustomerID = c.CustomerID
where c.State = N'تهران'
group by c.CustomerID
order by orderCount;
go

--هرکدام از مشتریان استان تهران یا کرمان به چه تعداد از محصول آب پرتقال سفارش داده اند
select
		c.CustomerID,c.State,sum(od.Qty)
from dbo.Customers as c
join dbo.Orders as o
on c.CustomerID = o.CustomerID
join dbo.OrderDetails as od 
on o.OrderID = od.OrderID
join dbo.Products as p
on od.ProductID = p.ProductID
where c.State in (N'تهران',N'کرمان')
and p.ProductName = N'آب پرتقال'
group by c.CustomerID , c.State

--اختلاف میان جدیدترین و قدیمی ترین سفارش هرکدام از مشتریان اصفهانی چند روز است
select
		c.CustomerID,
		DATEDIFF(DAY,Min(o.OrderDate),Max(o.OrderDate)) as day_diff
from dbo.Customers as c
join dbo.Orders as o
	on c.CustomerID = o.CustomerID
where c.State = N'اصفهان'
group by c.CustomerID;
go

--کدام یک از مشتری های ما ثبت سفارش نداده و فیلد شهر او برابر نال است
select
	c.CustomerID , c.State , o.OrderID
from dbo.Customers as c
left join dbo.Orders as o
	on c.CustomerID = o.OrderID
where c.State is null and
o.OrderID is null

--کوئری بنویسید که تعدا سفارش های شرکت های را که در استان زنجان واقع شدهاند را نمایش دهد
select
	c.CustomerID , count(o.OrderID) as num
from dbo.Orders as o
right join dbo.Customers as c
on o.CustomerID = c.CustomerID
where c.State = N'زنجان'
group by c.CustomerID;
go

---کدام یک از کارمندان سنش از 50 بیبش تر است و تعداد سفارشات ثبت شده اش هم از 100 بیش تر است؟
select
		e.LastName , Count(o.OrderID) as orderCount,
		DATEDIFF(YEAR,e.Birthdate,GETDATE()) as empYear
from dbo.Employees as e
join dbo.Orders as o
	on e.EmployeeID = o.EmployeeID
where DATEDIFF(YEAR,e.Birthdate,GETDATE()) > 50
group by e.LastName,DATEDIFF(YEAR,e.Birthdate,GETDATE())
	having count(o.OrderID) > 100;
go

---مشخصات کارمندانی که از تاریخ 2016-05-01 به بعد هیج سفارشی نداشته اند
select
	e.EmployeeID,e.FirstName,e.LastName
from dbo.Employees as e
Except
select 
	e.EmployeeID , e.FirstName , e.LastName
from dbo.Orders as o
join dbo.Employees as e
on o.EmployeeID = e.EmployeeID
where o.OrderDate > '20160501'

--به ازای هر سال تعداد سفارشات ثبت شده در 6 ماه پایانی سال را نمایش دهید
select 
		Year(o.OrderDate) as OrderYear,
		Count(o.OrderID) as orderCount
from dbo.Orders as o
where MONTH(o.OrderDate) > 6
group by all Year(o.OrderDate);
go
--روش دوم نوشتن کوئری دوم
select 
		Year(o.OrderDate) as OrderYear,
		Count(case when MONTH(o.OrderDate) > 6 then 1 End) as orderCount
from dbo.Orders as o
group by Year(o.OrderDate)
go