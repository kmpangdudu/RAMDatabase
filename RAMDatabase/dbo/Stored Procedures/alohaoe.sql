-- =============================================
-- Author:		William Chen
-- Create date: March 3, 2018
-- Description:	Monitor RAM DB status
-- =============================================
CREATE PROCEDURE [dbo].[alohaoe] 
@StartDay date = null,
@Interval int = 15
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
-- get today date 
if @startDay is null SET @StartDay = CAST(ISNULL(@StartDay, GETDATE()) as date);
declare  @lastday date
set @lastday = dateadd(day,-@Interval,@startDay)


 ---------------------------------------
 -- 今日及前5天情况
 ---------------------------------------
 ;WITH CTE1
 AS
 (
 select   
[logdate]  
,ISNULL([all],0)
+ISNULL([language],0)
+ISNULL([subcategory],0) 
+ISNULL([TopCategory],0)
+ISNULL([unique],0)
+ISNULL([search],0)
+ISNULL([Answer],0)
+ISNULL([Box],0)
+ISNULL([circular],0)
+ISNULL([City],0)
+ISNULL([Provincal],0)
+ISNULL([This],0)
+ISNULL([Type],0)
+ISNULL([ ],0)
as N'总用量'   ---[RAM】.[apilog].[cscontent] = 'answer' 
,[unique] as N'打开记录'   ---[RAM】.[apilog].[cscontent] = 'unique' 
,[Answer] As N'问卷调查'   ---[RAM】.[apilog].[cscontent] = 'answer' 
,[All] as N'列目录'  ---[RAM】.[apilog].[cscontent] = 'all'
,[Language] as N'按语言列记录'   ---[RAM】.[apilog].[cscontent] = 'Language'
,[TopCategory] as N'按目录列记录'  ---[RAM】.[apilog].[cscontent] = 'TopCategory'
,[Subcategory] as N'按子目录列记录'
,[search] as N'搜索'
,[Box] as N'按矩形列记录' 
,[circular] as N'按圆列记录' 
,[City] as N'按城市列记录'
,[Provincal] as N'按省列记录'
,[This]
,[Type] as N'按类型列记录'
,[ ] as [Test]    ---[RAM】.[apilog].[cscontent] = ' '  [csendpoint] = 'test' 
 
from (select cscontent , logdate, apilogid 
		from apilog 
       ) as [SourceTable]

PIVOT
(
Count(apilogid)
for cscontent in (   [ ],[pu],[ru],
					[All],[Language],[subcategory],[TopCategory],[unique],[search],[Answer]
					,[Box] ,[circular] ,[City],[Provincal],[This],[Type]
				 )
) as PivotTable
where logdate >= @lastday and logdate <= @StartDay
 
),
-- 今日分类
CTE2 
as
(
Select 
[logdate]  
,[SEO] 
 
,[unique] as N'人打开'
from 
(
select 
	case 
		when cscontent='unique' then N'SEO'
	end as [cscontent]
 
	,   apilogid  ,[logdate]
	from ram.dbo.apilog  
	where csuseragent like '%bot%'
 
union
select 
	 cscontent
	,  apilogid ,[logdate]
	from ram.dbo.apilog  
	where   cscontent = 'unique'  and csuseragent not like '%bot%'

 ) as sourceTable 
	pivot
	(
	count (apilogid) for cscontent in (
										[SEO] 
								 
										,[unique]
										) 
	) as PIVOTTable
	where   logdate >= @lastday and logdate <= @StartDay
	)
SELECT CTE1.logdate, CTE1.[总用量]
,CTE1.[打开记录],CTE2.[人打开],CTE2.SEO
,CTE1.[问卷调查]
,CTE1.[列目录]
,cte1.[按语言列记录] as [语言记录] 
,CTE1.[按目录列记录] as [目录记录]
,CTE1.[按子目录列记录] as [子目录记录]
,CTE1.[搜索]
,CTE1.[按矩形列记录] as [矩形记录]
,CTE1.[按圆列记录] as [圆记录]
,CTE1.[按城市列记录]  as [城市记录]
,CTE1.[按省列记录] as [省记录]
,CTE1.This
,CTE1.[按类型列记录] as [类型记录]
,CTE1.Test
,CONVERT(VARCHAR(8),GETDATE(),108) as [时间]
 FROM CTE1 join CTE2 
 on CTE1.[logdate]   = CTE2.[logdate]  
 where   CTE1.[logdate] >= @lastday and CTE1.[logdate] <= @StartDay
order by  CTE1.logdate desc



-- 今日日志头500条
SELECT           apilogid as N'今日日志', logdate as [date], Cast(logtime as time(0)) as [Time],  cscontent, csendpoint, keywords, csip, cscountry, csregion, cscity, csuseragent
FROM            apilog where   logdate = @StartDay
ORDER BY apilogid DESC;




-- really call, not bot
declare @nb int
select @nb = count (apilogid) from apilog where logdate >= @StartDay   AND csuseragent not like '%bot%' AND csuseragent not like '%bingpreview%';
SELECT   @nb as N'人工含问卷', apilogid as [ID], logdate as [date], Cast(logtime as time(0)) as [Time],  cscontent, csendpoint, keywords, csip, cscountry, csregion, cscity, csuseragent
FROM            apilog where    logdate = @StartDay  AND csuseragent not like '%bot%' AND csuseragent not like '%bingpreview%'
ORDER BY apilogid DESC;




-- Top 10 city
select city as N'累计头10城(含加国问卷)' , NUm as N'数量' from [dbo].[V_All_User_From_City];


-- 本周头30个城市
SELECT city as N'本周前30城(含加国问卷)',  num as N'数量'  FROM [RAM].[dbo].[V_ThisWeek_User_From_Top30_City]


-- all called, from Canada city, from other country 
Select a0.logdate as N'日期(含问卷)' , a0.n N'总数', ca.c N'加拿大', CONVERT(Decimal(8,2),100.0*ca.c/a0.n) as N'加拿大百分' ,
fo.f N'其他国家', CONVERT(Decimal(8,2),100.0*fo.f/a0.n) as N'其他国家百分' , asu.s as N'全部问卷', jsu.s as N'加国问卷'
from 
( select a1.logdate, count(a1.apilogid) as [n] from apilog as a1 where logdate>=@lastday and logdate <=@StartDay   group by a1.logdate) as a0
left join 
(select a2.logdate,count(a2.apilogid) as [c] from apilog as a2 where a2.cscountry = 'CA' and logdate>=@lastday and logdate <=@StartDay group  by a2.logdate  ) as CA
on a0.logdate= ca.logdate
left join
(select a3.logdate,count(a3.apilogid) as [f] from apilog as a3 where a3.cscountry != 'CA' and logdate>=@lastday and logdate <=@StartDay  AND a3.csuseragent not like '%bot%'  AND csuseragent not like '%bingpreview%'  group  by a3.logdate   ) as [fo]
on a0.logdate=fo.logdate
left join 
(select a4.logdate, count(a4.apilogid) as [s] from apilog as a4 where a4.cscontent = 'answer' and logdate>=@lastday and logdate <=@StartDay  group by a4.logdate)  as [asu]
on a0.logdate = asu.logdate
left join 
(select a5.logdate, count(a5.apilogid) as [s] from apilog as a5 where a5.cscontent = 'answer' and cscountry = 'CA' and logdate>=@lastday and logdate <=@StartDay  group by a5.logdate ) as jsu
on a0.logdate = jsu.logdate
where a0.logdate>=@lastday and a0.logdate <=@StartDay 
order by a0.logdate desc
END

