
--تعداد همه سفارش های کارمندان به جز سفارش های کارمند شماره 9
select
		o.EmployeeID,
		count(o.OrderID) as OrderCount
from dbo.Orders as o
where o.EmployeeID <> 9
group by EmployeeID;
go

--سفارش کارمند های که تعداد سفارش آن ها بیش از 20 باشد
select
		o.CustomerID,
		count(o.orderID) as orderCount
from dbo.Orders as o
group by o.CustomerID
having COUNT(o.OrderID) > 20;
go

--کارمند های که تعداد سفارش های آن ها بیش از 70 است به جز کارمند 9
select
	o.EmployeeID ,
	Count(o.OrderID) as orderCount
from dbo.Orders as o
where o.EmployeeID <> 9
group by o.EmployeeID
having Count(o.OrderID) > 70;
go


--سفارش های مشتری 71 به تفکیک هر سال به همراه تعداد سفارش ها و مجموع هزینه های ارسال
select 
		o.CustomerID,
		Year(o.OrderDate) as orderCount,
		count(o.OrderID) as orderCount,
		SUM(o.Freight) as TotalFreight
from dbo.Orders as o
where o.CustomerID = 71
group by o.CustomerID , Year(o.OrderDate);
go


--فهرستی از 5 مشتری که بیشترین تعداد ثبت سفارش را دارند
select
		top 5
		o.CustomerID,
		Count(O.OrderID) as orderCount
from dbo.Orders as o
group by o.CustomerID
order by orderCount desc;
go 

--یک شرط می تواند در where باشد اما در قسمت select نیامده باشد
select
	o.EmployeeID,
	count(o.OrderID) as orderCount
from dbo.Orders as o
where o.CustomerID < 50
group by o.EmployeeID;
go

--می توان مقداری را در hanivg محاسبه کردن اما در select نیاورد
select
	o.EmployeeID , o.CustomerID
from dbo.Orders as o
group by o.EmployeeID , o.CustomerID
having Count(o.OrderID) > 5;
go

--یک فیلد میتواند در 2 نقش حضور داشته باشد
--در محاسباتی ها و در گروه بندی ها
select 
	c.City ,
	 Count(c.City) as CityNum
from dbo.Customers as c
group by c.City;
go


--تعداد کل مشتری های تهران و اضفهان
select
	Count(c.City) as cityCount
from dbo.Customers as c
where c.City in (N'تهران',N'اضفهان');
go


 --having  همیشه با  group by  می آید نه تنها
 select
		c.CustomerID
 from dbo.Customers as c
 group by c.CustomerID
 having COUNT(c.State) > 0;
 go

 --group by all filter out شده ها را نیز نمایش میدهد
 select
		o.EmployeeID,
		Count(o.OrderID) as o
 from dbo.Orders as o
 where o.EmployeeID between 1 and 3
 group by all o.EmployeeID
 -- group by o.EmployeeId
 order by o.EmployeeID;
 go

 -----------RollUp----------
 --سر جمع سفارش ها را هم بده
 select
	o.CustomerID,
	count(o.OrderID) as count
 from dbo.Orders as o
 group by Rollup (o.CustomerID);
 go

 --rollUp sample 2
select
	o.EmployeeID,
	YEAR(o.OrderDate) as orderYear,
	MONTH(o.OrderDate) as orderMoth,
	Count(o.OrderID) as num
from dbo.Orders as o
where o.EmployeeID in (1,2)
group by rollUp (o.EmployeeID,YEAR(o.OrderDate),MONTH(o.OrderDate));
go

--grouping برای این که راحت تر بفهمیم کی سرجمع ما محاسبه شده
select
	o.EmployeeID,
	Year(o.OrderDate),
	MONTH(o.OrderDate),
	Count(o.OrderID),
	Grouping(o.EmployeeID),
	Grouping(Year(o.OrderDate)),
	Grouping(MONTH(o.OrderDate))
from dbo.Orders as o
group by rollup(o.EmployeeID,Year(o.OrderDate),MONTH(o.OrderDate));
go

--------cube n pow 2 حالت

--در حالت تکی مشابه رول آپ خروجی می دهد
select
	o.CustomerID,
	count(o.OrderID) as num
from dbo.Orders as o
group by cube(o.CustomerID);
go

select
	o.EmployeeID,
	Year(o.OrderDate),
	MONTH(o.OrderDate),
	Count(o.OrderID)
from dbo.Orders as o
group by cube(o.EmployeeID,Year(o.OrderDate),MONTH(o.OrderDate))
order by o.EmployeeID;
go


select
	o.EmployeeID,
	Year(o.OrderDate),
	MONTH(o.OrderDate),
	Count(o.OrderID),
	Grouping(o.EmployeeID),
	Grouping(Year(o.OrderDate)),
	Grouping(MONTH(o.OrderDate))
from dbo.Orders as o
group by cube(o.EmployeeID,Year(o.OrderDate),MONTH(o.OrderDate))
order by o.EmployeeID;
go























