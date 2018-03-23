
CREATE view [dbo].[V_LastWeek_User_From_City]
AS
SELECT * FROM 
( select TOP (10) cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where (logdate >= dbo.fn_lastweek_startday() and logdate <dbo.fn_lastweek_endday() ) and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
ORDER BY NUM DESC ) AS a
