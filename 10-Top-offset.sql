use NikamoozDB;
go

--تمامی کارمندانی که با مشتری 71 خرید داشته اند به صورت تکرای
 select od.EmployeeID
 from dbo.Orders as od
 where od.CustomerID = 71;
 go

 --همون قبلی به صورت غیر تکراری کارمند هارو میده
 select Distinct od.EmployeeID
 from dbo.Orders as od
 where od.CustomerID = 71;
 go


 select distinct od.EmployeeID , Year(od.OrderDate) as orderYear
 from dbo.Orders as od
 where od.CustomerID = 72
 order by od.EmployeeID;
 go

 --خطا در صورتی که تعداد شرکت کننده های سلکت و اودر بای در حالت دیستینک یکی نباشد
select distinct od.State
from dbo.Employees as od
order by od.EmployeeID;
go

------------------ top ---------------

-- جدید ترین سفارش ها به صورت نزولی
 select od.OrderID , od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate Desc;
 go

 --پنج سفارش جدید
 select top 5 od.OrderID , od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate desc;
 go

 -- پنج سفارش قدیمی
 select top 5 od.OrderID , od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate asc;
 go

 --درصد پذیر نیز است انتخاب سفارش ها  
 select top(5) percent od.OrderID , od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate desc;
 go

 --آن های که مقدارشان برابر است نیز باور در خروجی
 select
	top 5 with ties od.OrderID , od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate desc;
 go

 --------------------------- offset-fetch ---------

 --یک کوئری با 2 سینتکس متفاوت
 select top 5 od.OrderID , od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate desc;
 go

 select od.OrderID ,od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate desc
 offset 0 row fetch next 5 row only;
 go

 --از رکورد 11 تا 15 جدید ترین سفارش ها یعنی 10 تای اول را بپر
 select od.OrderID , od.OrderDate
 from dbo.Orders as od
 order by od.OrderDate desc
 offset 10 row fetch next 5 row only;
 go

--offset بدون  fetch 
--یعنی تعداد گفته شده را نادیده بگیر
--افست می گویید از کجا شروع کند
select od.OrderID , od.OrderDate
from dbo.Orders as od
order by od.OrderDate desc , od.OrderID desc
offset 10 row;
go