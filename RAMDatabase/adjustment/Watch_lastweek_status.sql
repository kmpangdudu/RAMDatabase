--  Weekly watch
DECLARE @c NVARCHAR(50) = N'Montréal'
DECLARE @SD DATE ='2018-10-07' --Start Sunday
DECLARE @ED DATE = '2018-10-13' -- End Saturday
SELECT * FROM ram.dbo.V_LastWeek_User_From_Top_30_City
SELECT logdate, COUNT(apilogid) as [Num] FROM apilog WHERE cscity = @c AND logdate >= @SD AND logdate < DATEADD(DAY, 1, @ED) group BY logdate WITH ROLLUP
-- Barrière, Surrey, BC, Beauharnois, QC, Surrey, Montague, PE, CA
--  Montréal  ,   Kelowna ,  Toronto ,  Maniwaki,  Ottawa
--  Fredericton, NB, Banff,   Norway House, MB, Niagara Falls, ON, 
-- Kitchener,  Sainte-thérèse,   Ottawa, Barrie, Oshawa, ON,