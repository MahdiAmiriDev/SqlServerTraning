--اگر دیتابسی در 
--use
--باشد اجرا نمی شود و خطا می دهد
Drop Database if exists test
go

create database test

use test

--برای مشاهده اطلاعات دیتابیس
select * from sys.sysfiles; 
go

--مشاهده اطلاعات دیتابسی جاری
exec SP_HELPFILE;
go



--دستور ساخت یک دیتا بیسی جدید
create database Test01
ON
(Name = TestDB1,FileName='E:\TmpDb\test01data1.mdf',Size=10mb,MAXSIZE=100,FileGrowth=20mb),
(Name = TestDB2,FileName='E:\TmpDb\test01data2.ndf',Size=15mb,MAXSIZE=100,FileGrowth=20%),
(Name = TestDB3,FileName='E:\TmpDb\test01data3.ndf',Size=10mb,MAXSIZE=Unlimited,FileGrowth=20)
Log on
(Name = TestL1,FileName='E:\TmpDb\test01Log1.ldf',Size=100mb,MAXSIZE=100,FileGrowth=20mb),
(Name = TestL2,FileName='E:\TmpDb\test01Log2.ldf',Size=50mb,MAXSIZE=100,FileGrowth=20mb)
Go

select * from sys.sysfiles

exec SP_HELPFILE

--برای تغییر در دیتابسی باید ALTER نوشت
Alter database test
Add File (Name = TestDb4,FileName='D:\TempDb\test01data4.ndf',size=10mb,MaxSize=100,FileGrowth=20mb)
	Go
-- میتوان فایل لاگ را در محلی جداگانه از فایل های اصلی دیتابسی نگه داری کرد
Alter database test
Add Log File (Name = TestL3,FileName='D:\TempDb\test01log3.ldf',size=10mb,MaxSize=100,FileGrowth=20mb)
	Go

