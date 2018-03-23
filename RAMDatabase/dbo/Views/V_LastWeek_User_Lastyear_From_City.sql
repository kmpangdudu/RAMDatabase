

CREATE view [dbo].[V_LastWeek_User_Lastyear_From_City]
AS
select cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where (logdate >= DATEADD(YEAR,-1,dbo.fn_lastweek_startday()) and logdate < DATEADD(YEAR,-1,dbo.fn_lastweek_endday() )) 
and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
