-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[getMapByCategoriesFR] 
	-- Add the parameters for the stored procedure here
@c1 varchar(5) = '0',
@c2 varchar(5) = '0',
@c3 varchar(5) = '0',
@c4 varchar(5) = '0',
@c5 varchar(5) = '0',
@c6 varchar(5) = '0',
@c7 varchar(5) = '0',
@c8 varchar(5) = '0',
@c9 varchar(5) = '0' 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
 SELECT DISTINCT
		m.[ETLLoadID]
	  ,k.KHPCategoryID
      ,[PublicName]
      ,[AgencyDescription]
      ,[TaxonomyLevelNameID]
      ,[PhysicalAddress]
      ,c.CityName
      ,p.Province
      ,[PhysicalCountry]
      ,UPPER([PhysicalPostalCode]) as PhysicalPostalCode
      ,m.[Latitude]
      ,m.[Longitude]
      ,[HoursOfOperation]
      ,[Phone]
      ,[WebsiteAddress]
      ,[Eligibility]
      ,[DisabilitiesAccess]
      ,[FeeStructureSource]
      ,[ApplicationProcess]
      ,[DocumentsRequired]
      ,[LanguagesOfferedList]
      ,[LanguageOfRecord]
      ,[WorkHours]
      ,[CustomEligibilitybyAge]
 
  FROM [RAM].[dbo].[Map] as m left join [RAM].[dbo].[CityLocation] as c on m.PhysicalCityID = c.CityId
  left join [RAM].[dbo].[Province] as p on m.PhysicalProvinceID = p.ProvinceID
  left join [RAM].[dbo].[ETLLoadIDAndKHPCategoryID] k on m.ETLLoadID = k.etlloadid  
  where [LanguageOfRecord] = 'fr'
  AND 
  ( k.KHPCategoryID = convert(int,@c1) or
  k.KHPCategoryID = convert(int,@c2) or
  k.KHPCategoryID = convert(int,@c3) or
  k.KHPCategoryID = convert(int,@c4) or
  k.KHPCategoryID = convert(int,@c5) or
  k.KHPCategoryID = convert(int,@c6) or
  k.KHPCategoryID = convert(int,@c7) or
  k.KHPCategoryID = convert(int,@c8) or 
  k.KHPCategoryID = convert(int,@c9))
  order by m.[ETLLoadID]
END
