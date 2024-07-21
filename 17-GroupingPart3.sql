 
 --تعداد سفارش های مشتری ها با کارمندان در صورتی که مشتری 1 یا 2 باشد
 select
		o.EmployeeID , o.CustomerID,
		Count(o.OrderID) as orderCount
 from dbo.Orders as o
 where o.CustomerID = 1 OR
		o.CustomerID = 2
 group by o.EmployeeID , o.CustomerID;
 go

 ------------- به تفکیک سال همان بالایی
  select
		o.CustomerID,
		Count(o.OrderID) as orderCount,
		Year(o.OrderDate) as orderYear
 from dbo.Orders as o
 where o.CustomerID = 1 OR
		o.CustomerID = 2
 group by o.CustomerID, Year(o.OrderDate);
 go

 --------------------------------------grouping sets --------------
 -- ترکیب های دلخواه خود را اعلام می کنیم

 select
		o.EmployeeID,
		o.CustomerID,
		YEAR(o.OrderDate) as orderYear,
		Count(o.OrderDate) as count
 from dbo.Orders as o
 where o.CustomerID = 1 Or o.CustomerID =2
 group by grouping sets 
 (
	(o.EmployeeID,o.CustomerID),
	(o.EmployeeID,Year(o.OrderDate)),
	(o.CustomerID,Year(o.OrderDate))
 );
go


----- مرتب شده بالایی
 select
		o.EmployeeID,
		o.CustomerID,
		YEAR(o.OrderDate) as orderYear,
		Count(o.OrderDate) as count
 from dbo.Orders as o
 where o.CustomerID = 1 Or o.CustomerID =2
 group by grouping sets 
 (
	(o.EmployeeID,o.CustomerID),
	(o.EmployeeID,Year(o.OrderDate)),
	(o.CustomerID,Year(o.OrderDate)),
	() -- تجمیع همه
 )
 order by
		  case
				when YEAR(o.OrderDate) is null then 1 ---اول
				when o.EmployeeID is null then 2 -- دوم
				when o.CustomerID is null then 3 -- سوم 
		 End;
go

---تشخیص گروه بندی ها به روشی ساده تر
--- به توان 2 می رساند فیلد را از این طریق متوجه می شویم که کدام مورد در گروه بندی شرکت کرده است
 select
		o.EmployeeID,
		o.CustomerID,
		YEAR(o.OrderDate) as orderYear,
		Count(o.OrderDate) as count,
		GROUPING_ID(o.EmployeeID,o.CustomerID,YEAR(o.OrderDate)) as GroupingIdFeild
 from dbo.Orders as o
 where o.CustomerID = 1 Or o.CustomerID =2
 group by grouping sets 
 (
	(o.EmployeeID,o.CustomerID),
	(o.EmployeeID,Year(o.OrderDate)),
	(o.CustomerID,Year(o.OrderDate))
 );
go

--- همان قبلی ار مرتب سازی کنیم
 select
		o.EmployeeID,
		o.CustomerID,
		YEAR(o.OrderDate) as orderYear,
		Count(o.OrderDate) as count,
		case GROUPING_ID(o.EmployeeID,o.CustomerID,YEAR(o.OrderDate))
		when 4 then 'sal , moshtari'
		when 2 then 'sal , karmand'
		when 1 then 'karmand , moshtari'
		end as groupingFeild

 from dbo.Orders as o
 where o.CustomerID = 1 Or o.CustomerID =2
 group by grouping sets 
 (
	(o.EmployeeID,o.CustomerID),
	(o.EmployeeID,Year(o.OrderDate)),
	(o.CustomerID,Year(o.OrderDate))
 );
go

 select
		o.EmployeeID,
		o.CustomerID,
		YEAR(o.OrderDate) as orderYear,
		Count(o.OrderDate) as count,
		case GROUPING_ID(o.EmployeeID,o.CustomerID,YEAR(o.OrderDate))
		when 4 then 'sal , moshtari'
		when 2 then 'sal , karmand'
		when 1 then 'karmand , moshtari'
		end as groupingFeild

 from dbo.Orders as o
 where o.CustomerID = 1 Or o.CustomerID =2
 group by grouping sets 
 (
	(o.EmployeeID,o.CustomerID),
	(o.EmployeeID,Year(o.OrderDate)),
	(o.CustomerID,Year(o.OrderDate))
 );
go