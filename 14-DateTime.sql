

select GETDATE();
go

--سال ماه و روز تاریخ را گرفته
select
		o.OrderID,
		YEAR(o.OrderDate) as yearDate,
		MONTH(o.OrderDate) as monthDate,
		DAY(o.OrderDate) as DayDate
from dbo.Orders as o;
go

--خروجی به ما حروف می دهد
select
		DATENAME(YEAR,'20170915'),
		DATENAME(MONTH,'20170915'),
		DATENAME(DAY,'20170915'),
		DATENAME(DAYOFYEAR,'20170915'),
		DATENAME(WEEKDAY,'20170915');
go

--خروجی به ما عدد می دهد
select
		DatePart(YEAR,'20170915'),
		DatePart(MONTH,'20170915'),
		DatePart(DAY,'20170915'),
		DatePart(DAYOFYEAR,'20170915'),
		DatePart(WEEKDAY,'20170915');
go

--اضافه کردن یا کم کردن مقداری از یک تاریخ
select
		DATEADD(year,1,'20170915'), --'2017-09-15'
		DATEADD(year,-1,'20170915'),
		DATEADD(MONTH,1,'20170915'),
		DATEADD(DAY,1,'20170915'),
		DATEADD(DAY,-1,'20170915');
go

--اختلاف 2 تاریخ را بدست آوردن
select DATEDIFF(DAY,'20130920',Getdate());
go

--اختلاف 2 تاریخ به روز
select DATEDIFF(DAY,'19140628',GETDATE());
go

--به ثانیه
select DATEDIFF_Big(SECOND,'19140628',GETDATE());
go

select ISDATE('20140212');
select ISDATE('2000212');
select ISDATE('20121212');
go 