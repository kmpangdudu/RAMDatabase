-- =============================================
-- Author:		William Chen
-- Create date: Feb.9,2018
-- Description:	某省，市在某时间段的访问量
-- =============================================
CREATE PROCEDURE  [dbo].[Proc_Stat_city_access]
 @province nvarchar(50) = N'All',
 @City nvarchar(50) = N'All',
 @startdate date = '2016-01-01',
 @enddate date  = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
IF @startdate = '' SELECT @startdate = '2015-01-01';
IF @enddate = '' SELECT @enddate = CONVERT(DATE,GETDATE());
select @province = LTRIM(RTRIM(@province));
select @City = LTRIM(RTRIM(@City));





IF @province = N'any' or @province = N'all' or @province = N''
	begin
	--  Victoria, BC - how many times was RAM used with Victoria as a search city in 2017. --    answer = 83
		SELECT [City] = @City,[Provine] = @province,   [From] = @startdate, [To] =  DATEADD(day,-1, @enddate)   ,   count(apilogid) as [vistors]
		FROM [RAM].[dbo].[apilog]   where     logdate >= @startdate    and    logdate < @enddate ;
	--  Victoria, BC - what was the top category searched throughout 2017?  --  
			select [apilogid]
			  ,[logdate]
			  ,[csmethod]
			  ,[cscontent]
			  ,[csendpoint]
			  ,[keywords]
			  ,[csip]
			  ,[cscountry]
			  ,[csregion]
			  ,[cscity]
			  ,[csstatus]
			  ,[cshost]
			  ,[csurl] 
			INTO #ORG
			FROM [dbo].[apilog]
			where (logdate >= @startdate) and (logdate < @enddate)
		;

		select [City] = @City,   [Provine] = @province,   [From] = @startdate, [To] =  DATEADD(day,-1, @enddate)   ,  t.TopCategory as [Searched Category] , count(a.keywords) as [Searched Times] 
		from
		(select keywords from #org where  cscontent = 'topcategory'
		union all
		select SUBSTRING (LEFT([keywords],4) ,1 ,CHARINDEX('/',LEFT([keywords],4))  -1)   as [keywords]
		 from #ORG	 where   cscontent = 'unique'
		 ) as [a] join [dbo].TopCategory as t on t.TopCategoryID  = a.keywords
		 group by t.TopCategory
		 order by [Searched Times] desc
	end 
else -- 明确的省市
	BEGIN
		IF @City = N'any' or @City = N'all' or @City = N''
			BEGIN  ---明确的省, 全部的市
			--  Victoria, BC - how many times was RAM used with Victoria as a search city in 2017. --    answer = 83
				SELECT [City] = @City,[Provine] = @province,   [From] = @startdate, [To] =  DATEADD(day,-1, @enddate),   count(apilogid) as [vistors]    
				FROM [RAM].[dbo].[apilog]   where csregion = @province   and  logdate >= @startdate  and   logdate < @enddate      ;
			--  Victoria, BC - what was the top category searched throughout 2017?  -- 
				select [apilogid]
					  ,[logdate]
					  ,[csmethod]
					  ,[cscontent]
					  ,[csendpoint]
					  ,[keywords]
					  ,[csip]
					  ,[cscountry]
					  ,[csregion]
					  ,[cscity]
					  ,[csstatus]
					  ,[cshost]
					  ,[csurl] 
					INTO #ORG_filtered_Prov
					FROM [dbo].[apilog]
					where csregion = @province   and (logdate >= @startdate) and (logdate < @enddate)
				;

				select [City] = @City,   [Provine] = @province,   [From] = @startdate, [To] =  DATEADD(day,-1, @enddate)   ,  t.TopCategory as [Searched Category] , count(a.keywords) as [Searched Times] 
				from
				(select keywords from #ORG_filtered_Prov where  cscontent = 'topcategory'
				union all
				select SUBSTRING (LEFT([keywords],4) ,1 ,CHARINDEX('/',LEFT([keywords],4))  -1)   as [keywords]
				 from #ORG_filtered_Prov	 
				 where   cscontent = 'unique'
				 ) as [a] join [dbo].TopCategory as t on t.TopCategoryID  = a.keywords
				 group by t.TopCategory
				 order by [Searched Times] desc
			END---明确的省, 全部的市
		ELSE
			BEGIN --明确的省市
		--  Victoria, BC - how many times was RAM used with Victoria as a search city in 2017. --    answer = 83
			SELECT [City] = @City,[Provine] = @province,   [From] = @startdate, [To] =  DATEADD(day,-1, @enddate),   count(apilogid) as [vistors]    
			FROM [RAM].[dbo].[apilog]   where csregion = @province and cscity = @City   and logdate >= @startdate     and   logdate < @enddate ;
		--  Victoria, BC - what was the top category searched throughout 2017?  -- 
			select [apilogid]
				  ,[logdate]
				  ,[csmethod]
				  ,[cscontent]
				  ,[csendpoint]
				  ,[keywords]
				  ,[csip]
				  ,[cscountry]
				  ,[csregion]
				  ,[cscity]
				  ,[csstatus]
				  ,[cshost]
				  ,[csurl] 
				INTO #ORG_filtered
				FROM [dbo].[apilog]
				where csregion = @province and cscity = @City  and (logdate >= @startdate) and (logdate < @enddate)
			;

			select [City] = @City,   [Provine] = @province,   [From] = @startdate, [To] =  DATEADD(day,-1, @enddate)   ,  t.TopCategory as [Searched Category] , count(a.keywords) as [Searched Times] 
			from
			(select keywords from #ORG_filtered where  cscontent = 'topcategory'
			union all
			select SUBSTRING (LEFT([keywords],4) ,1 ,CHARINDEX('/',LEFT([keywords],4))  -1)   as [keywords]
			 from #ORG_filtered	 
			 where   cscontent = 'unique'
			 ) as [a] join [dbo].TopCategory as t on t.TopCategoryID  = a.keywords
			 group by t.TopCategory
			 order by [Searched Times] desc
			 END -- 明确的省市

	END


END
