
--طول رشته
select len(N'سلام');
--فضای اشغالی
select DATALENGTH(N'سلام');


select LOWER('HeLLO LoRD');
go

select UPPER('hello god');
go

select LTRIM('   salam');
go

select RTRIM('salam     ');
go

select LEFT(N'سلام',2);
go

select Right(N'محمد',2);
go

select SUBSTRING('salam khobi',1,5);
go

select CHARINDEX('mahdi','salam esm man mahdi ast',1);
go

select PATINDEX('[0-9]%','3ab');
go

select REPLACE('salam','s','d');
go

select REPLICATE('mamad',3);
go

select 'esm man' + 'mahdi amiri'+ 'nist !' as fullName;
go

select CONCAT('salam',' ','esm',' ','to',' ','chieh');
go

















