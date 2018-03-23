
CREATE view [dbo].[V_All_User_From_City]
 AS
 SELECT   a.*  from
(select top (10) cscity + ', '+csregion+', '+ cscountry as [city] , count(apilogid) as [num]
from apilog 
where  cscountry ='CA' AND cscity != ''
group by cscity + ', '+csregion+', '+ cscountry 
order by num desc) as a 
