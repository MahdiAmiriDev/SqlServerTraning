
--الیاس دهی به ستونی که در جدول وجود خارجی ندارد
select o.OrderID , Year(o.OrderDate) as OrderYear
from dbo.Orders as o;
go

--یک کوئری اشتباه را اصلاح می کنیم 
select od.OrderID , Year(od.OrderDate) as DateYear
from dbo.Orders as od
where od.OrderDate > 2015

select od.OrderID , Year(od.OrderDate) as DateYear
from dbo.Orders as od
where od.OrderDate > '2015'

select od.OrderID , Year(od.OrderDate) as DateYear
from dbo.Orders as od
where od.OrderDate > '20151230'

--- Order By ----

select od.EmployeeID , Year(od.OrderDate) as OrderYear
from dbo.Orders as od
where od.CustomerID = 71
order by od.EmployeeID Desc;
go

select od.EmployeeID , Year(od.OrderDate) as OrderYear
from dbo.Orders as od
where od.CustomerID = 71
order by od.EmployeeID Asc;
go

-- الیاس سلکت در اوردر بای شناخته می شود !
select od.EmployeeID , Year(od.OrderDate) as OrderYear
from dbo.Orders as od
where od.CustomerID = 71
order by OrderYear;
go

select e.EmployeeID , e.Region , e.City
from dbo.Employees as e
order by e.Region , e.City;
go

-- جدول را دیده چون اول فرام را خوانده و لرومی ندارد انجه در سلکت است در اورد بای بیایید
--ستونی که در سلکت نیامده را نیز می توان در اوردر باری قرار داد چون اولویت اجرای اوردر بای خیلی پایین است
select e.FirstName , e.LastName
from dbo.Employees as e
order by e.City;
go

