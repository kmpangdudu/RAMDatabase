-- =============================================
-- Author:		William Chen
-- Create date: <Create Date,,>
-- version trace: 2015-06-18
-- Description:	get all English and French resource, including one who belongs to multiple class etc.
-- =============================================
CREATE PROCEDURE [dbo].[getAllMap] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT m.[ETLLoadID]
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
 
  FROM [dbo].[Map] as m left join [dbo].[CityLocation] as c on m.PhysicalCityID = c.CityId
  left join [dbo].[Province] as p on m.PhysicalProvinceID = p.ProvinceID
  left join [dbo].[ETLLoadIDAndKHPCategoryID] k on m.ETLLoadID = k.etlloadid  
  order by m.[ETLLoadID]
END
