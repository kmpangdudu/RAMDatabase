CREATE procedure [dbo].[ACLID_usage_by_month]
as
begin
select a.[year] ,a.[month]
, case when a.[KHP sum] + b.[BlackLabs sum] is null  then '' else a.[KHP sum] + b.[BlackLabs sum] end as [RAM]
, case when c.[Foundry sum] is null then '' else c.[Foundry sum] end as [Foundry]
, case when d.[KHPChat sum] is null then '' else d.[KHPChat sum] end as [KHPChat]
, case when e.[ChatApp sum] is null then '' else e.[ChatApp sum] end as [ChatApp]
, case when f.[Chat sum] is null then '' else f.[Chat sum] end as [Chat]
, case when g.[hackathon sum] is null then '' else g.[hackathon sum] end as [hackathon]
 from 
-- KHP  = 1
(select  case when year(logdate) is null then '0' else year(logdate) end as [year]  
, CASE WHEN month(logdate) is null then '0' else  month(logdate) end as [month]  
, count(*) as [KHP sum] from apilog  
where aclid = 1
group by CUBE (year(logdate), month(logdate))
) as a
-- BlackLabs = 3
left join (
select  case when year(logdate) is null then '0' else year(logdate) end as [year]  
, CASE WHEN month(logdate) is null then '0' else  month(logdate) end as [month]   
, count(*) as [BlackLabs sum] from apilog where aclid = 3
group by CUBE (year(logdate), month(logdate))
) as b on a. [year] = b.[year] and  a.[month] = b.[month]
-- Foundry = 5
left join 
(
select  case when year(logdate) is null then '0' else year(logdate) end as [year]  
, CASE WHEN month(logdate) is null then '0' else  month(logdate) end as [month]    
, count(*) as [Foundry sum] from apilog where aclid = 5
group by CUBE (year(logdate), month(logdate))
) as c
on a. [year] = c.[year] and  a.[month] = c.[month]
-- KHPChat =4 
left join 
(
select  case when year(logdate) is null then '0' else year(logdate) end as [year]   
, CASE WHEN month(logdate) is null then '0' else  month(logdate) end as [month]  
, count(*) as [KHPChat sum] from apilog where aclid = 4
group by CUBE (year(logdate), month(logdate))
) as d
on a. [year] = d.[year] and  a.[month] = d.[month]
-- ChatApp =6 
left join 
(
select  case when year(logdate) is null then '0' else year(logdate) end as [year]   
, CASE WHEN month(logdate) is null then '0' else  month(logdate) end as [month]   
, count(*) as [ChatApp sum] from apilog where aclid = 6
group by CUBE (year(logdate), month(logdate))
) as e
on a. [year] = e.[year] and  a.[month] = e.[month]
-- Chat  = 7 
left join 
(
select  case when year(logdate) is null then '0' else year(logdate) end as [year]   
, CASE WHEN month(logdate) is null then '0' else  month(logdate) end as [month]  
, count(*) as [Chat sum] from apilog where aclid = 7
group by Cube (year(logdate), month(logdate))
) as f
on a. [year] = f.[year] and  a.[month] = f.[month]
-- Chat  = 8
left join 
(
select  case when year(logdate) is null then '0' else year(logdate) end as [year]  
, CASE WHEN month(logdate) is null then '0' else  month(logdate) end as [month]  
, count(*) as [hackathon sum] from apilog where aclid = 8
group by Cube (year(logdate), month(logdate))
) as g
on a. [year] = g.[year] and  a.[month] = g.[month]

order by a.[year] ,a.[month]
end