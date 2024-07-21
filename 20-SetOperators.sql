 
 --Union All
 --اجتماع بین 2 جدول به همراه مقدار های تکراری
 select 
	e.State , e.City , e.Region
 from dbo.Employees as e
 Union All
 select
	c.State , c.City , c.Region
 from dbo.Customers as c;
 go

 --Union
 --عدم مشارکت ردیف های که مقدار تکراری دارند در اجتماع ما
select 
	e.State , e.City , e.Region
 from dbo.Employees as e
 Union 
 select
	c.State , c.City , c.Region
 from dbo.Customers as c;
 go

 --نکته اسم ستون ها را همیشه از کوئری اول می گیرد
 select 
	e.State as N'استان' , e.City , e.Region
 from dbo.Employees as e
 Union 
 select
	c.State , c.City , c.Region
 from dbo.Customers as c;
 go

 --مرتب سازی در ست اوپراتور ها نمی تواند روی کوئری اول باشد چون
 --نوع اولی را کرست و دومی را ریزالت ست کرده که سبب بروز خطا می شود
  select 
	e.State as N'استان' , e.City , e.Region
 from dbo.Employees as e
 order by e.City
 Union 
 select
	c.State , c.City , c.Region
 from dbo.Customers as c;
 go

 --راه حل قرار دادن در کوئری دوم تا روی کل تاثیر گذار شود
 select 
	e.State as N'استان' , e.City , e.Region
 from dbo.Employees as e

 Union 
 select
	c.State , c.City , c.Region
 from dbo.Customers as c
 order by e.Region
 go

 --تعداد ستون ها باید برابر باشد وگرنه خطا می دهد
 select 
	e.State , e.City , e.Region
 from dbo.Employees as e
 Union 
 select
	c.State , c.City
 from dbo.Customers as c
 order by e.Region
 go

 --نوع داده ها باید یکسان باشد وگرنه خطا می دهد
select 
	e.State
 from dbo.Employees as e
 Union 
 select
	c.CustomerID
 from dbo.Customers as c
 go

 ------- Intersect ----------
 --برای گرفتن اشتراک بین 2 مجموعه کاربرد دارد
 -- تکراری ها را در نظر نمی گیرد و یک بار می آورد
select
	c.State , c.Region , c.City
from dbo.Customers as c
intersect
select
	e.State , e.Region , e.City
from dbo.Employees as e;
go


--کوئری بالا با استفاده از جوین
select
	distinct
	c.State , c.Region , c.City
from dbo.Customers as c 
join dbo.Employees as e
on c.State = e.State and
	c.Region = e.Region and
	c.City = e.City;
go

------- Except ------
-- تفاضل بین 2 مجموعه را حساب می کند 
-- a - b آنچه در آ هست در بی نیست را نمایش می دهد
-- نتیجه 
--a-b با  b-a متفاوت است
select
	c.Region , c.City , c.State
from dbo.Customers as c
Except
select
	e.Region , e.City , e.State
from dbo.Employees as e

select
	e.Region , e.City , e.State
from dbo.Employees as e
Except
select
	c.Region , c.City , c.State
from dbo.Customers as c

----- اولویت بندی با پرانتز 
select
	s.Region , s.City , s.State
from dbo.Suppliers as s
Except
select
	e.Region , e.City , e.State
from dbo.Employees as e
Intersect
select
	c.Region , c.City , c.State
from dbo.Customers as c
---- با پرانتز 
(select
	s.Region , s.City , s.State
from dbo.Suppliers as s
Except
select
	Region , City ,State
from dbo.Employees)
Intersect
select
	c.Region , c.City , c.State
from dbo.Customers as c


























   