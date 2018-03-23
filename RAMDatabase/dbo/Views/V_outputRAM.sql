/****** Script for SelectTopNRows command from SSMS  ******/
CREATE view V_outputRAM
as
SELECT 
       '"' + [ResourceAgencyNum] + '"' AS [ResourceAgencyNum]
      ,'"' + [Map] + '"' AS [Map]
	  ,'"' + s.[SubCategory] + '"' AS [SubCategory]
	  ,'"' + t.[TopCategory] + '"' AS [TopCategory]
      ,'"' + [PublicName] + '"' AS [PublicName]
      ,'"' + [AgencyDescription] + '"' AS [AgencyDescription]
	  ,'"' + tax.[TaxonomyLevelName] + '"' AS [TaxonomyLevelName]
      ,'"' + [PhysicalAddress] + '"' AS [PhysicalAddress] 
      ,'"' + c.[CityName]    + '"' AS   [City]
      ,'"' + p.ProvinceAlias   + '"' AS [Province]
      ,'"' + [PhysicalCountry] + '"' AS [Country]
      ,'"' + [PhysicalPostalCode] + '"' AS [PostalCode]
      ,'"' + CONVERT(VARCHAR, r.[Latitude]) + '"' AS [Latitude]
      ,'"' + CONVERT(VARCHAR, r.[Longitude]) + '"' AS [Longitude]
      ,'"' + [HoursOfOperation] + '"' AS [HoursOfOperation]
      ,'"' + [Phone] + '"' AS [Phone]
      ,'"' + [WebsiteAddress] + '"' AS [Website]
      ,'"' + [Eligibility] + '"' AS [Eligibility]
      ,'"' + [DisabilitiesAccess] + '"' AS [DisabilitiesAccess]
      ,'"' + [FeeStructureSource] + '"' AS [FeeStructureSource]
      ,'"' + [ApplicationProcess] + '"' AS [ApplicationProcess] 
      ,'"' + [DocumentsRequired] + '"' AS [DocumentsRequired]
      ,'"' + [LanguagesOfferedList] + '"' AS [LanguagesOfferedList]
      ,'"' + [LanguageOfRecord] + '"' AS [LanguageOfRecord]
      ,'"' + [WorkHours] + '"' AS [WorkHours]
      ,'"' + [CustomEligibilitybyAge] + '"' AS [CustomEligibilitybyAge]
      ,'"' + [CoverageArea] + '"' AS [CoverageArea]
      ,'"' + [Coverage] + '"' AS [Coverage]
      ,'"' + [NormalWaitTime] + '"' AS [NormalWaitTime]
      ,'"' + CONVERT(VARCHAR,r.[createdDate]) + '"' AS [createdDate]
  FROM [RAM].[dbo].[RamResource]  as r 
  join [dbo].[TaxonomyLevelName] as tax on r.TaxonomyLevelNameID = tax.TaxonomyLevelNameID
  join [dbo].[SubCategory] as s on r.SubCategoryID = s.SubCategoryID
  join [dbo].[TopCategory] as t on r.TOPCategoryID = t.TopCategoryID
  join [dbo].[Province] as p on r.PhysicalProvinceID = p.ProvinceID
  join [dbo].[CityLocation] as c on r.PhysicalCityID = c.CityId
  WHERE r.PhysicalCityID <> 0  AND  r.PhysicalProvinceID <> 99
