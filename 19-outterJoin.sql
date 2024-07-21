use NikamoozDB;
go

--همه مشتری های که ثبت سفارش داشته اند
select
   c.CustomerID , c.CompanyName , o.OrderID
from dbo.Customers as c
join dbo.Orders as o
on c.CustomerID = o.CustomerID
order by c.CustomerID;
go

--همه مشتری های که ثبت سفارش داشته اند به همراه تمام ان های که ثبت سفارش نداشته اند
select
		c.CustomerID , c.CompanyName , o.OrderID
from dbo.Customers as c
Left join dbo.Orders as o
on o.CustomerID = c.CustomerID
order by c.CustomerID;
go

--همه مشتری های که ثبت سفارش نداشته اند
select
		c.CustomerID , c.CompanyName , o.OrderID
from dbo.Customers as c
Left join dbo.Orders as o
on o.CustomerID = c.CustomerID
where o.OrderID is null
order by c.CustomerID;
go

--- !!! نوشتن شرط اند در قسمت مربوط به جوین کاری اشتباه است به دلیل منطق 
--3vl
select
	c.CustomerID , c.CompanyName , o.OrderID
from dbo.Customers as c
left join dbo.Orders as o
on c.CustomerID = o.CustomerID
and o.OrderID is null
order by c.CustomerID;
go


--تمام مشتری های ثبت سفارش داشته اند و آن های که نداشته اند به همراه جزئیات سفارش
select
		c.CustomerID,c.CompanyName,o.OrderID,
		od.ProductID,od.Qty
from dbo.Customers as c
left join dbo.Orders as o
on c.CustomerID = o.CustomerID
left join dbo.OrderDetails as od
on o.OrderID = od.OrderID
order by c.CustomerID;
go







