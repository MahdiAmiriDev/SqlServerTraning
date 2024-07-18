
--فیلتر کردن سفارش ها براساس سفارش مربوط به مشتری 71
select o.OrderID , o.CustomerID
from dbo.Orders as o
where o.CustomerID = 71;
go

--سفارش های که شناسه آن ها برابر مقادیر داخل پرانتز باشد
select o.OrderID , o.OrderDate
from dbo.Orders as o
where o.OrderID in (10248,10253,10320);
Go

--سفارش های که شامل داخل پرانتز نباشد 
select o.OrderID , o.OrderDate
from dbo.Orders as o
where o.OrderID not in (10248,10253,10320);
Go

--BETWEEN Operator
select o.EmployeeID,o.OrderID
from dbo.Orders as o
where o.EmployeeID between 3 and 7;
go

--BETWEEN Operator Vs IN
select o.EmployeeID , o.OrderID
from dbo.Orders as o
where o.EmployeeID in (3,4,5,6,7);
go

 select e.FirstName, e.LastName
 from dbo.Employees as e
 where e.LastName like N'ا%';
 go

 select e.FirstName,e.LastName
 from dbo.Employees as e
 where e.LastName like N'[^ا]%';
 go

 select e.FirstName, e.LastName
 from dbo.Employees as e
 where e.LastName not like N'ا%';
 go

 select e.FirstName,e.LastName
 from dbo.Employees as e
 where e.LastName like N'%ی';
 go

 select e.FirstName , e.LastName
 from dbo.Employees as e
 where e.LastName like N'[ا-پ]%';
 go

 select e.FirstName,e.LastName
 from dbo.Employees as e
 where e.FirstName like N'س__';
 go

 ----------Compersatin Operator -----

 select o.OrderID,o.OrderDate
 from dbo.Orders as o
 where o.OrderDate >= '20160430';
 go

 select o.OrderDate , o.EmployeeID
	from dbo.Orders as o
 where o.OrderDate >= '20160430' And
	   o.EmployeeID in (1,2,3);
 go


 select o.OrderDate , o.EmployeeID
	from dbo.Orders as o
 where o.OrderDate >= '20160430' OR
	  o.EmployeeID in (1,2,3);
 go



--- Arechmatic operators ---

select od.OrderID , od.ProductID , od.Qty , od.UnitPrice , od.Discount,
		od.Qty * od.UnitPrice * (1 - od.Discount) as Val
from dbo.OrderDetails as od;
go


select 10 + 2 * 3
go

--- اولیت دهی به داخل پرانتز
select (10 + 2) * 3
go


select O.CustomerID , O.EmployeeID
from dbo.Orders as o
where (
		(o.CustomerID = 3 
		And o.EmployeeID in (1,2,3))

	  OR

	  (o.CustomerID = 4
	  and o.EmployeeID in (4,5,6))

	  );
GO