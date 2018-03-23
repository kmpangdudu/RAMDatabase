
-- =============================================
-- Author:		William Chen
-- Create date: Nov.10, 2015
-- Description:	Get Search result by using TopCategory AND subcategory AND Location 
-- =============================================
CREATE PROCEDURE [dbo].[Proc_TopCategory_Subcategory_Location_Search]
	-- Add the parameters for the stored procedure here
@TOPCategoryID INT = 0 ,
@SubCategoryID INT = 0 ,
@CityID INT = 0 , 
@lang NVARCHAR(50) = 'en'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF (@CityID = 0 ) 
	BEGIN
		IF (@TOPCategoryID = 0)  --- Get All Resources  任意category的 Resources 即全部数据
			BEGIN
			SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, A.[SubCategoryID]
				, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory END AS [SubCategory]
				, A.[TOPCategoryID]
				, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
				, A.[PublicName] AS [Name]
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + a.publicname+'</p>'+ c.CityName+', '+ p.[ProvinceAlias])	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress 
				, [PhysicalCityID]
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, [PhysicalProvinceID]
				, CASE p.[ProvinceAlias]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				JOIN [dbo].[SubCategory] AS SC ON SC.[SubCategoryID] = A.SubCategoryID
				JOIN [dbo].[TopCategory] AS TC ON TC.TopCategoryID = A.TOPCategoryID
				WHERE a.LanguageOfRecord = @lang  AND SC.Active = 1 AND TC.Active = 1 
				ORDER BY  SC.[SubCategoryID]  
			END
		ELSE IF (@SubCategoryID = 0)  ---  Get All 具体TopCategoryID = @TopCategoryID 的 Resources
				BEGIN 
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, A.[SubCategoryID]
				, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory END AS [SubCategory]
				, A.[TOPCategoryID]
				, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
				, A.[PublicName] AS [Name]
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + a.publicname+'</p>'+ c.CityName+', '+ p.[ProvinceAlias])	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress 
				, [PhysicalCityID]
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, [PhysicalProvinceID]
				, CASE p.[ProvinceAlias]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				JOIN [dbo].[SubCategory] AS SC ON SC.[SubCategoryID] = A.SubCategoryID
				JOIN [dbo].[TopCategory] AS TC ON TC.TopCategoryID = A.TOPCategoryID
				WHERE a.TOPCategoryID = @TOPCategoryID AND a.LanguageOfRecord = @lang   AND SC.Active = 1 AND TC.Active = 1 
				ORDER BY  SC.[SubCategoryID]  
				END
			ELSE  --- Get 具体 TopCategoryID = @TopCategoryID  并且  SubCategoryID = @SubCategoryID  的 Resources
				BEGIN
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, A.[SubCategoryID]
				, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory END AS [SubCategory]
				, A.[TOPCategoryID]
				, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
				, A.[PublicName] AS [Name]
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + a.publicname+'</p>'+ c.CityName+', '+ p.[ProvinceAlias])	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress 
				, [PhysicalCityID]
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, [PhysicalProvinceID]
				, CASE p.[ProvinceAlias]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				JOIN [dbo].[SubCategory] AS SC ON SC.[SubCategoryID] = A.SubCategoryID
				JOIN [dbo].[TopCategory] AS TC ON TC.TopCategoryID = A.TOPCategoryID
				WHERE a.TOPCategoryID = @TOPCategoryID AND a.SubCategoryID = @SubCategoryID AND a.LanguageOfRecord = @lang   AND SC.Active = 1 AND TC.Active = 1 
				ORDER BY  SC.[SubCategoryID]  
				END
	END
ELSE
	BEGIN
			IF (@TOPCategoryID = 0)  --- Get All Resources  任意category的 Resources 即全部数据
			BEGIN
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, A.[SubCategoryID]
				, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory END AS [SubCategory]
				, A.[TOPCategoryID]
				, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
				, A.[PublicName] AS [Name]
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + a.publicname+'</p>'+ c.CityName+', '+ p.[ProvinceAlias])	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress 
				, [PhysicalCityID]
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, [PhysicalProvinceID]
				, CASE p.[ProvinceAlias]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				JOIN [dbo].[SubCategory] AS SC ON SC.[SubCategoryID] = A.SubCategoryID
				JOIN [dbo].[TopCategory] AS TC ON TC.TopCategoryID = A.TOPCategoryID
				WHERE C.CityId = @CityID AND a.LanguageOfRecord = @lang   AND SC.Active = 1 AND TC.Active = 1 
				ORDER BY  SC.[SubCategoryID]  
			END
		ELSE IF (@SubCategoryID = 0)  ---  Get All 具体TopCategoryID = @TopCategoryID 的 Resources
				BEGIN 
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, A.[SubCategoryID]
				, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory END AS [SubCategory]
				, A.[TOPCategoryID]
				, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
				, A.[PublicName] AS [Name]
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + a.publicname+'</p>'+ c.CityName+', '+ p.[ProvinceAlias])	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress 
				, [PhysicalCityID]
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, [PhysicalProvinceID]
				, CASE p.[ProvinceAlias]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				JOIN [dbo].[SubCategory] AS SC ON SC.[SubCategoryID] = A.SubCategoryID
				JOIN [dbo].[TopCategory] AS TC ON TC.TopCategoryID = A.TOPCategoryID
				WHERE a.TOPCategoryID = @TOPCategoryID AND C.CityId = @CityID AND a.LanguageOfRecord = @lang   AND SC.Active = 1 AND TC.Active = 1 
				ORDER BY  SC.[SubCategoryID]  
				END
			ELSE  --- Get 具体 TopCategoryID = @TopCategoryID  并且  SubCategoryID = @SubCategoryID  的 Resources
				BEGIN
				SELECT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, A.[SubCategoryID]
				, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory END AS [SubCategory]
				, A.[TOPCategoryID]
				, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
				, A.[PublicName] AS [Name]
				, CASE c.CityName  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + a.publicname+'</p>'+ c.CityName+', '+ p.[ProvinceAlias])	 END  AS PublicNames
				, a.AgencyDescription
				, PhysicalAddress 
				, [PhysicalCityID]
				, CASE c.CityName  	WHEN 'TBD' THEN '' ELSE c.CityName END AS [City]
				, [PhysicalProvinceID]
				, CASE p.[ProvinceAlias]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS [Province]
				, a.PhysicalCountry   
				, a.PhysicalPostalCode
				, REPLACE(ETL.[TaxonomyTerm],'/',' ')  AS STerm
				, REPLACE(ETL.TaxonomyTerms,'/',' ')  AS LTerms
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				, a.Eligibility
				, a.DisabilitiesAccess
				, a.FeeStructureSource
				, a.ApplicationProcess
				, a.DocumentsRequired
				, a.LanguagesOfferedList
				, a.LanguageOfRecord
				, a.WorkHours
				, a.CustomEligibilitybyAge
				, a.changedDate
				, a.createdDate 
				FROM            RamResource   AS a 
				JOIN [dbo].[CityLocation] AS c ON a.PhysicalCityID = c.CityId 
				JOIN [dbo].[Province] AS p ON a.PhysicalProvinceID = p.ProvinceID
				JOIN [dbo].[ETLLoad] AS ETL ON a.ETLLoadID = ETL.ETLLoadID
				JOIN [dbo].[SubCategory] AS SC ON SC.[SubCategoryID] = A.SubCategoryID
				JOIN [dbo].[TopCategory] AS TC ON TC.TopCategoryID = A.TOPCategoryID
				WHERE a.TOPCategoryID = @TOPCategoryID AND a.SubCategoryID = @SubCategoryID AND C.CityId = @CityID AND a.LanguageOfRecord = @lang   AND SC.Active = 1 AND TC.Active = 1 
				ORDER BY  SC.[SubCategoryID]  
				END
	END

END

