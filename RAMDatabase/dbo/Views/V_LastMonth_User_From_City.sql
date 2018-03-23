
CREATE view [dbo].[V_LastMonth_User_From_City]
 AS
 select cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where (logdate >= dbo.fn_lastMonth_startday() and logdate <dbo.fn_lastMonth_endday() ) and cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
