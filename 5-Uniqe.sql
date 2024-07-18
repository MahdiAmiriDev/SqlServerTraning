

create Table UniqStud
(
	Code int Constraint uq Unique,
	FirstName Nvarchar(100)
);
Go



Insert into UniqStud(Code,FirstName)
Values(1,N'ali'),(2,N'mmd');
Go

--تکراری مورد قبول نیست
Insert into UniqStud(Code,FirstName)
Values(1,N'soheil')

--یکبار نال را می پذیرد
Insert into UniqStud(Code,FirstName)
Values(null,N'soheil');
go

--ترکیبی نیز امکان پذیر است که در سطح جدول رخ می دهد


