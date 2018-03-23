-----------------------------------------
--
--  Globally CITY
--
-----------------------------------------
CREATE PROCEDURE [yos].[GlobalCity]
@End int =1,
@D DATE = '2017-09-01'
AS
BEGIN
 
 Declare @loop int = 1;
 while @loop <=@end
BEGIN  -- While Start here
 
--SET @D = CAST(ISNULL(@D, GETDATE()) as date);
if object_id('tempdb..#SAMPLE') is not null
    drop table #SAMPLE;

CREATE TABLE #SAMPLE 
(
ID INT IDENTITY(1,1) NOT NULL,  
country nvarchar (2),
region nvarchar (2),
city nvarchar (20),
thip nvarchar (20),
host nvarchar (20) ,
lat numeric (18,10),
long numeric (18,10),
uagency nvarchar (500)  
)

DECLARE @UA NVARCHAR(500) 
--  UK  
------------------
DECLARE  @M   NVARCHAR(20) = N'Liverpool'
DECLARE  @R NVARCHAR(2) =N'H8'
DECLARE  @C NVARCHAR(2) =N'GB'
DECLARE @lat numeric (18,10) = 53.4167000000
DECLARE @long numeric (18,10) = -3.0000000000
DECLARE  @Mip NVARCHAR(20) = '2.24.77.10'
SET @UA  =N'Mozilla/5.0 (iPad; CPU OS 9_3_5 like Mac OS X) AppleWebKit/601.1.46 (KHTML, like Gecko) Version/9.0 Mobile/13G36 Safari/601.1'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Manchester'
SET  @R   =N'I2'
SET  @C    =N'GB'
SET  @lat    = 53.5500000000
SET  @long   = -2.3000000000
set @Mip = '2.24.78.228'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8'

insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'London'
SET  @R   =N'H9'
SET  @C    =N'GB'
SET  @lat    = 51.5092000000
SET  @long   = -0.0955000000
set @Mip = '2.24.105.20'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:55.0) Gecko/20100101 Firefox/55.0'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Leeds'
SET  @R   =N'H3'
SET  @C    =N'GB'
SET  @lat    = 53.8000000000
SET  @long   = -1.5833000000
set @Mip = '2.22.146.164'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:55.0) Gecko/20100101 Firefox/55.0'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Birmingham'
SET  @R   =N'H3'
SET  @C    =N'GB'
SET  @lat    = 52.4796000000
SET  @long   = -1.9378000000
set @Mip = '2.24.7.128'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:55.0) Gecko/20100101 Firefox/55.0'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Manchester'
SET  @R   =N'I2'
SET  @C    =N'GB'
SET  @lat    = 53.4663000000
SET  @long   = -2.1342000000
set @Mip = '2.24.2.128'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:55.0) Gecko/20100101 Firefox/55.0'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Liverpool'
SET  @R   =N'H8'
SET  @C    =N'GB'
SET  @lat    = 53.4167000000
SET  @long   = -3.0000000000
set @Mip = '2.24.23.4'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.3; WOW64; rv:55.0) Gecko/20100101 Firefox/55.0'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)




------------------
-- Greece
------------------
SET  @M    = N'Athens'
SET  @R   =N'35'
SET  @C    =N'GR'
SET  @lat    = 37.9833000000
SET  @long   = 23.7333000000
SET  @Mip   = '5.54.6.115'
SET @UA  =N'Mozilla/5.0 (Windows NT 10.0; WOW64; rv:48.0) Gecko/20100101 Firefox/48.0'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Thessaloníki'
SET  @R   =N'13'
SET  @C    =N'GR'
SET  @lat    = 40.6403000000
SET  @long   = 22.9439000000
SET  @Mip   = '5.144.225.242'
SET @UA  =N'Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.0 Mobile/14G60 Safari/602.1'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Pireo'
SET  @R   =N'35'
SET  @C    =N'GR'
SET  @lat    = 37.9614000000
SET  @long   = 23.6389000000
SET  @Mip   = '5.203.68.138'
SET @UA  =N'Mozilla/5.0 (Linux; Android 5.0.1; 10DTB12A Build/LRX22C) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)



------------------
-- Franch
------------------
SET  @M    = N'Paris'
SET  @R   =N'A8'
SET  @C    =N'FR'
SET  @lat    = 48.8628000000
SET  @long   = 2.3292000000
SET  @Mip   = '217.195.21.80'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:47.0) Gecko/20100101 Firefox/47.0'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Marseille'
SET  @R   =N'B8'
SET  @C    =N'FR'
SET  @lat    = 43.2854000000
SET  @long   = 5.3761000000
SET  @Mip   = '217.167.132.175'
SET @UA  =N'Mozilla/5.0 (Linux; Android 5.1.1; SAMSUNG SM-G530W Build/LMY47X) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/3.3 Chrome/38.0.2125.102 Mobile Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Toulouse'
SET  @R   =N'B3'
SET  @C    =N'FR'
SET  @lat    = 43.5995000000
SET  @long   = 1.4332000000
SET  @Mip   = '217.109.148.141'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Guéret'
SET  @R   =N'B1'
SET  @C    =N'FR'
SET  @lat    = 46.2667000000
SET  @long   = 1.8667000000
SET  @Mip   = '5.50.112.48'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Marseille'
SET  @R   =N'B1'
SET  @C    =N'FR'
SET  @lat    = 43.3722000000
SET  @long   = 5.3539000000
SET  @Mip   = '5.50.115.248'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Nice'
SET  @R   =N'B1'
SET  @C    =N'FR'
SET  @lat    = 43.7136000000
SET  @long   = 7.2595000000
SET  @Mip   = '5.50.122.167'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Paris'
SET  @R   =N'A8'
SET  @C    =N'FR'
SET  @lat    = 48.8565000000
SET  @long   = 7.2595000000
SET  @Mip   = '5.50.123.41'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/603.3.8 (KHTML, like Gecko) Version/10.1.2 Safari/603.3.8'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)




------------------
-- Germany
------------------
SET  @M    = N'Berlin'
SET  @R   =N'16'
SET  @C    =N'DE'
SET  @lat    = 52.5167000000
SET  @long   = 13.4000000000
SET  @Mip   = '80.150.248.52'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Munich'
SET  @R   =N'02'
SET  @C    =N'DE'
SET  @lat    = 48.1098000000
SET  @long   = 11.6183000000
SET  @Mip   = '91.15.121.23'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Hamburg'
SET  @R   =N'04'
SET  @C    =N'DE'
SET  @lat    = 53.5553000000
SET  @long   = 9.9950000000
SET  @Mip   = '92.210.137.146'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Frankfurt Am Main'
SET  @R   =N'05'
SET  @C    =N'DE'
SET  @lat    = 50.1457000000
SET  @long   = 8.6549000000
SET  @Mip   = '79.243.82.6'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Frankfurt'
SET  @R   =N'05'
SET  @C    =N'DE'
SET  @lat    = 50.1167000000
SET  @long   = 8.6833000000
SET  @Mip   = '95.172.68.157'
SET @UA  =N'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)






------------------
-- US
------------------
SET  @M    = N'San Francisco'
SET  @R   =N'CA'
SET  @C    =N'US'
SET  @lat    = 37.7758000000
SET  @long   = -122.4128000000
SET  @Mip   = '50.203.58.40'
SET @UA  =N'Mozilla/5.0 (Linux; Android 5.0; SM-N900W8 Build/LRX21V) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.125 Mobile Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Philadelphia'
SET  @R   =N'PA'
SET  @C    =N'US'
SET  @lat    = 40.0491000000
SET  @long   = -75.2281000000
SET  @Mip   = '50.203.59.39'
SET @UA  =N'Mozilla/5.0 (Linux; Android 5.1.1; SM-G530W Build/LMY47X) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/3.3 Chrome/38.0.2125.102 Mobile Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Miami'
SET  @R   =N'FL'
SET  @C    =N'US'
SET  @lat    = 25.6586000000
SET  @long   = -80.3568000000
SET  @Mip   = '50.203.63.94'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)


------------------
-- New Zeland
------------------
SET  @M    = N'Auckland'
SET  @R   =N'E7'
SET  @C    =N'NZ'
SET  @lat    = -36.8447000000
SET  @long   = 174.7336000000
SET  @Mip   = '14.1.34.48'
SET @UA  =N'Mozilla/5.0 (Linux; Android 7.0; SM-G955W Build/NRD90M; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/59.0.3071.125 Mobile Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

SET  @M    = N'Wellington'
SET  @R   =N'G2'
SET  @C    =N'NZ'
SET  @lat    = -41.3000000000
SET  @long   = 174.7833000000
SET  @Mip   = '27.123.21.133'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/59.0.3071.115 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

SET  @M    = N'Christchurch'
SET  @R   =N'E9'
SET  @C    =N'NZ'
SET  @lat    = -43.5831000000
SET  @long   = 172.6644000000
SET  @Mip   = '27.121.98.0'
SET @UA  =N'Mozilla/5.0 (iPhone; CPU iPhone OS 10_2_1 like Mac OS X) AppleWebKit/602.4.6 (KHTML, like Gecko) Version/10.0 Mobile/14D27 Safari/602.1'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)


------------------
-- Australia
------------------
SET  @M    = N'Melbourne'
SET  @R   =N'02'
SET  @C    =N'AU'
SET  @lat    = -37.8103000000
SET  @long   = 144.9544000000
SET  @Mip   = '1.178.127.64'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Perth'
SET  @R   =N'08'
SET  @C    =N'AU'
SET  @lat    = -31.9674000000
SET  @long   = 115.8621000000
SET  @Mip   = '1.122.88.0'
SET @UA  =N'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.135 Safari/537.36 Edge/12.10240'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Adelaide'
SET  @R   =N'02'
SET  @C    =N'AU'
SET  @lat    = -34.9287000000
SET  @long   = 138.5986000000
SET  @Mip   = '1.123.13.160'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Sydney'
SET  @R   =N'02'
SET  @C    =N'AU'
SET  @lat    = -33.8612000000
SET  @long   = 151.1982000000
SET  @Mip   = '14.137.69.235'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)



------------------
-- Hungary
------------------
SET  @M    = N'Budapest'
SET  @R   =N'05'
SET  @C    =N'HU'
SET  @lat    = 47.4810000000
SET  @long   = 19.0724000000
SET  @Mip   = '5.38.131.192'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

 
------------------
-- Indonesia
------------------
SET  @M    = N'Surabaya'
SET  @R   =N'08'
SET  @C    =N'ID'
SET  @lat    = -7.2492000000
SET  @long   = 112.7508000000
SET  @Mip   = '180.247.41.0'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
------------------
-- Peru
------------------
SET  @M    = N'Lima'
SET  @R   =N'15'
SET  @C    =N'PE'
SET  @lat    = -12.0678000000
SET  @long   = -77.0886000000
SET  @Mip   = '157.191.243.6'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)


------------------
-- Russia
------------------
SET  @M    = N'Moscow'
SET  @R   =N'48'
SET  @C    =N'PE'
SET  @lat    = 55.7485000000
SET  @long   = 37.6184000000
SET  @Mip   = '2.60.214.13'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Yekaterinburg'
SET  @R   =N'48'
SET  @C    =N'PE'
SET  @lat    = 56.8575000000
SET  @long   = 60.6125000000
SET  @Mip   = '79.172.57.2'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Saint Petersburg'
SET  @R   =N'48'
SET  @C    =N'PE'
SET  @lat    = 59.8944000000
SET  @long   = 30.2642000000
SET  @Mip   = '92.100.132.1'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)


------------------
-- Italy	
------------------
SET  @M    = N'Rome'
SET  @R   =N'07'
SET  @C    =N'IT'
SET  @lat    = 41.8919000000
SET  @long   = 12.5113000000
SET  @Mip   = '2.33.112.133'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Milan'
SET  @R   =N'09'
SET  @C    =N'IT'
SET  @lat    = 45.4823000000
SET  @long   = 9.2410000000
SET  @Mip   = '2.33.112.133'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
SET  @M    = N'Florence'
SET  @R   =N'16'
SET  @C    =N'IT'
SET  @lat    = 43.7793000000
SET  @long   = 11.2463000000
SET  @Mip   = '2.33.126.10'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Belgium
------------------
SET  @M    = N'Antwerpen'
SET  @R   =N'01'
SET  @C    =N'BE'
SET  @lat    = 51.2167000000
SET  @long   = 4.4167000000
SET  @Mip   = '2.33.143.255'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Norway
------------------
SET  @M    = N'Oslo'
SET  @R   =N'12'
SET  @C    =N'NO'
SET  @lat    = 59.9050000000
SET  @long   = 10.7487000000
SET  @Mip   = '176.11.163.15'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Finland
------------------
SET  @M    = N'Helsinki'
SET  @R   =N'13'
SET  @C    =N'FI'
SET  @lat    = 60.1641000000
SET  @long   = 24.7136000000
SET  @Mip   = '37.203.211.255'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)


------------------
-- Switzerland
------------------
SET  @M    = N'Oslo'
SET  @R   =N'12'
SET  @C    =N'CH'
SET  @lat    = 47.3667000000
SET  @long   = 8.5500000000
SET  @Mip   = '5.39.2.205'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Poland
------------------
SET  @M    = N'Warsaw'
SET  @R   =N'78'
SET  @C    =N'PL'
SET  @lat    = 52.2500000000
SET  @long   = 21.0000000000
SET  @Mip   = '5.60.21.192'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Spain
------------------
SET  @M    = N'Madrid'
SET  @R   =N'29'
SET  @C    =N'ES'
SET  @lat    = 40.4165000000
SET  @long   = -3.7026000000
SET  @Mip   = '77.227.118.198'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Sweden
------------------
SET  @M    = N'Stockholm'
SET  @R   =N'26'
SET  @C    =N'SE'
SET  @lat    = 59.3600000000
SET  @long   = 18.0009000000
SET  @Mip   = '2.22.60.6'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Denmark
------------------
SET  @M    = N'Copenhagen'
SET  @R   =N'17'
SET  @C    =N'DK'
SET  @lat    = 55.6759000000
SET  @long   = 12.5655000000
SET  @Mip   = '2.111.36.10'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)


------------------
-- Ireland	
------------------
SET  @M    = N'Dublin'
SET  @R   =N'17'
SET  @C    =N'IE'
SET  @lat    = 53.3389000000
SET  @long   = -6.2595000000
SET  @Mip   = '31.187.26.10'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)

------------------
-- Netherlands
------------------
SET  @M    = N'Amsterdam'
SET  @R   =N'07'
SET  @C    =N'NL'
SET  @lat    = 52.3500000000
SET  @long   = 4.9167000000
SET  @Mip   = '13.106.102.10'
SET @UA  =N'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.90 Safari/537.36'
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)
insert into #SAMPLE Values (@C,@R,@M,  @mIP, @Mip,@lat,	@long, @UA)












---- Create the variables for the random number generation
DECLARE @Random INT;
DECLARE @Upper INT;
DECLARE @Lower INT;

SET @Lower = 1 ---- The lowest random number
-- create random sample data
declare @sampleCount int 
select @sampleCount = Count(*) from #SAMPLE
select @Upper =  count (*) from #SAMPLE  
SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)

 
declare @country nvarchar (2);
declare @region nvarchar (2);
declare @city nvarchar (20);
declare @thip nvarchar (20);
declare @host nvarchar (20) ;
declare @lat1 numeric (18,10);
declare @long1 numeric (18,10);
declare @uagency nvarchar (500) ;

select  @country  = country   from #sample   where id = @random 
select  @region   = region 	  from #sample   where id = @random
select  @city  	  = city  	  from #sample   where id = @random
select  @thip 	  = thip 	  from #sample   where id = @random
select  @host  	  = host  	  from #sample   where id = @random
select  @lat1  	  = lat  	  from #sample   where id = @random
select  @long1    = long  	  from #sample   where id = @random
select  @uagency  = uagency	  from #sample   where id = @random


-- work on APILOG table
select @Upper =  count (apilogid) from apilog where cscity = 'Mountain View' and csuseragent like '%bot%' and logdate = @d
SELECT @Random = ROUND(((@Upper - @Lower -1) * RAND() + @Lower), 0)
 

 declare @myIP1 int
 

 
 select top (1) @myIP1 = apilogid from 
(select top (@Random ) apilogid from apilog  where  cscity = 'Mountain View' and csuseragent like '%bot%'  and logdate = @d   order by apilogid) a
order by apilogid desc
 

 --select apilogid, logdate, logtime, cscontent, csendpoint,  csip, cscountry, csregion, cscity, latitude, longitude,  cshost,  csuseragent 
 --from apilog 
 --where apilogid = @myIP1 ;

 update apilog set 
  cscountry = @country ,
  csregion =  @region  ,
  cscity = @city  	 ,
  csip = @thip 	, 
  cshost = @host  ,	 
  latitude = @lat1  	, 
  longitude = @long1  ,	 
  csuseragent = @uagency 
 where apilogid = @myIP1;

SELECT        apilogid, logdate, logtime, cscontent, csendpoint,  cscountry, csregion, cscity, csurl
FROM            apilog
WHERE        (apilogid = @myIP1)



 
 select @loop = @loop +1;
END   -- while loop end here
END  --- procedure 