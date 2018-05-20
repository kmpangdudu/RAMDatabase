DECLARE @c NVARCHAR(50) = N'Surrey'
DECLARE @SD date ='2018-05-13' --Start Sunday
DECLARE @ED DATE = '2018-05-19' -- End Saturday
SELECT * FROM ram.dbo.V_LastWeek_User_From_Top_30_City
SELECT logdate, COUNT(apilogid) FROM apilog WHERE cscity = @c AND logdate >= @SD AND logdate < DATEADD(DAY, 1, @ED) group BY logdate WITH ROLLUP