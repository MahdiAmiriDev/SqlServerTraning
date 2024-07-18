

select c.CustomerID , c.Region
from dbo.Customers as c
where c.Region = N'جنوب';
go

--مخالف جنوب ها را بده 
-- نال را نیز جزو جنوب نمی داند
select c.CustomerID , c.State , c.Region , c.City
from dbo.Customers as c
where c.Region <> N'جنوب';
go

--شرط غلط است چون با ناشناخته داری مقایسه می کنی !!!
select c.CustomerID
from dbo.Customers as c
where c.Region = null;
go

--راه حل این است 
select c.CustomerID , c.Region
from dbo.Customers as c
where c.Region is null;
go

--راه حل دوم
select c.CustomerID , c.Region
from dbo.Customers as c
where c.Region is not null;
go

--شرط اشتباه اند و نال باهم چون داری با ناشناخته مقایسه می کنی !!!
select c.CustomerID , c.Region
from dbo.Customers as c
where c.Region <> N'جنوب' 
and c.Region is null

--راه حل  استفاده از اور است 
select c.CustomerID , c.Region
from dbo.Customers as c
where c.Region <> N'جنوب' 
OR c.Region is null


--تابع ISNULL(check , replacement value);
-- مقدار اگر نال بود جایگزین کن با اونی که من گفتم
Declare @str1 varchar(100) = null;
select ISNULL(@str1, 'my variable is null');
go

--مثال با پدیده نال
select c.CustomerID , c.State , c.Region , c.City
from dbo.Customers as c
where ISNULL(c.Region,N'نامشخص') <> N'جنوب';
go

--all at once -----

--چون در هر فاز کل آن فاز یکجا اجرا می شود خطا دارد بنا بر این باید جدگانه نوشته شده
-- و عملیات را روی آن انجام دهیم
select od.CustomerID , Year(od.OrderDate) as orderYear,
			orderYear + 1 as nextYear
from dbo.Orders as od;
go

select
o.CustomerID , Year(o.orderDate) as orderYear,
Year(o.OrderDate) + 1 as NextYear
from dbo.Orders as o;
go






