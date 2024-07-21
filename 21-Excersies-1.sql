
--تعداد سفارش ها از تاریخی به بعد
select
	 count(distinct o.OrderID) as orderCount
from dbo.Orders as o
where o.OrderDate > '2016-05-04' ;
go

--تعداد سفارش ها به ازای ماه دوم هر سال میلادی
select
	Year(o.OrderDate) as orderYear,
	MONTH(o.OrderDate) as OrderMonth,
	Count(distinct o.OrderID) as OrderCount
from dbo.Orders as o
where MONTH(o.OrderDate) = 2
group by Year(o.OrderDate) , MONTH(o.OrderDate)
--having MONTH(o.OrderDate) = 2;
go
 
--میانگین نرخ کرایه فروش هر سفارش به ازای هر ماه از سال میلادی
select
	YEAR(o.OrderDate) as orderYear,
	MONTH(o.OrderDate) as orderMonth,
	Avg(o.Freight) as avg_freight
from dbo.Orders as o
group by YEAR(o.OrderDate),MONTH(o.OrderDate);
go

--جدیدترین و قدیمی ترین و تعداد سفارش های هر مشتری با این شرط که تاریخ 
--ثبت سفارش در محدوده سه ماه اول سال 2015 و تعداد آن ها بیش از 2 ثبت سفارش باشد

select
		o.CustomerID , Count(distinct o.OrderID) as orderCount,
		MAX(o.OrderDate) as NewOrder,
		Min(o.OrderDate) as oldOrder
from dbo.Orders as o
where MONTH(o.OrderDate) in (1,2,3)
and Year(o.OrderDate) = '2015'
group by o.CustomerID
having Count(distinct o.OrderID) > 2
order by o.CustomerID
go

--این بهتر است
select
		o.CustomerID , Count(distinct o.OrderID) as orderCount,
		MAX(o.OrderDate) as NewOrder,
		Min(o.OrderDate) as oldOrder
from dbo.Orders as o
where o.OrderDate between '2015-01-01' and '2015-03-31'
group by o.CustomerID
having Count(distinct o.OrderID) > 2
order by o.CustomerID
go
