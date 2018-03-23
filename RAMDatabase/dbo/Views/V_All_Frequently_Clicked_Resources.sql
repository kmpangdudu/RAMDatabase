-- select [dbo].[fn_get_ResourceNum_from_Log_keywords] (17) 
-- all
CREATE view [dbo].[V_All_Frequently_Clicked_Resources]
AS
select resc.num as [ResourcesNum], count(resc.num) as num from 
(
select a.apilogid,  
 [dbo].[fn_get_ResourceNum_from_Log_keywords] (a.apilogid) as num 
 from apilog as a 
where a.cscontent ='unique'  
) as resc
group by  resc.num

