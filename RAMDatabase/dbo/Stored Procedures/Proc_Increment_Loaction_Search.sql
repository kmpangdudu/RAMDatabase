-- ===============================================================================
-- Author:		WILLIAM CHEN
-- Create date: Nov. 26, 2015
-- Description:	Loaction Increment search for auto-complete
-- Revision: on Feb.5, 2016
-- changed search table from [dbo].[CityLocation] to [dbo].[SuggestionWord]    --- Will do 
-- On March 4, 2017
--		add @token, added a table VARIABLE @ALLCITY, then fitle from @ALLCITY by access control list 
--      finally, output from fitled records        
-- ===============================================================================
CREATE PROCEDURE [dbo].[Proc_Increment_Loaction_Search]
	-- Add the parameters for the stored procedure here
@token NVARCHAR(50),
@L nvarchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-- insert into a temp table to fitle by access control list
DECLARE  @ALLCITY  TABLE(
cityid int ,
CITY NVARCHAR(255) NULL,
Province NVARCHAR(255) NULL 
)


-----------------------------------
-- SELECT ALL marched CITY
-----------------------------------
INSERT INTO @ALLCITY
SELECT   c.cityid,    c.[CityName] AS [CITY] ,   p.ProvinceAlias  AS [PROVINCE]   
FROM [dbo].[CityLocation] AS c join province AS p ON c.ProvinceID = p.ProvinceID
WHERE p.ProvinceID < 15 and c.[CityName] like ''+ @L+'%'


----------------------------------------------
-- Filte from #result by access control list
----------------------------------------------
SELECT cityid, [CITY], [PROVINCE]    FROM @ALLCITY
WHERE CityID IN (select * from F_Get_ALL_Allow_City(@token))
ORDER BY [CITY], [PROVINCE]


--On March 4, 2017 commented blow
--SELECT   c.cityid, c.ProvinceID, c.[CityName]+ ', '+ p.ProvinceAlias AS Location  
--FROM [dbo].[CityLocation] AS c join province AS p ON c.ProvinceID = p.ProvinceID
--WHERE p.ProvinceID < 15 and c.[CityName] like ''+ @L+'%'
--ORDER BY c.[CityName], p.ProvinceAlias

END
