﻿
-- =============================================
-- Author:		William Chen
-- Create date: Oct.20, 2015
-- Description:	get resource by using Top Category
-- Reversion: Aug.15, 2016, added Parameter @token to check access control list 
-- =============================================
create PROCEDURE p356
@SubCategoryID int,
@lang nvarchar(50) ='en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT     DISTINCT  
						a.ETLLoadID, 
						a.ResourceAgencyNum,
						a.Map, 
						a.SubCategoryID, 
						CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory_fr END AS SubCategory, 
						a.TOPCategoryID, 
                        CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS TopCategory, 
						a.PublicName AS Name, 
						--CASE c.CityName WHEN 'TBD' THEN a.publicname ELSE CONVERT(NVARCHAR(2000), 
                        --a.publicname + ', ' + c.CityName + ', ' + p.[ProvinceAlias]) END AS PublicNames, 
						a.AgencyDescription, 
						a.PhysicalAddress, 
						a.PhysicalCityID, 
                        CASE c.CityName WHEN 'TBD' THEN '' ELSE c.CityName END AS City, 
						a.PhysicalProvinceID, 
						CASE p.[ProvinceAlias] WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS Province, 
                        a.PhysicalCountry, 
						a.PhysicalPostalCode, 
						REPLACE(ETL.TaxonomyTerm, '/', ' ') AS STerm, 
						REPLACE(ETL.TaxonomyTerms, '/', ' ') AS LTerms, 
						a.PhysicalAddressIsPrivate, 
						a.Latitude, 
						a.Longitude, 
                        a.HoursOfOperation, 
						a.Phone, 
						a.WebsiteAddress, 
						a.Eligibility, 
						a.DisabilitiesAccess, 
						a.FeeStructureSource, 
						a.ApplicationProcess, 
						a.DocumentsRequired, 
						a.LanguagesOfferedList, 
						a.LanguageOfRecord, 
                        a.WorkHours, 
						a.CustomEligibilitybyAge, 
						a.Coverage, 
						a.CoverageArea, 
						a.NormalWaitTime
FROM            RamResource AS a 
                  INNER JOIN      CityLocation AS c		ON a.PhysicalCityID = c.CityId  
                  INNER JOIN      Province AS p			ON a.PhysicalProvinceID = p.ProvinceID  
                  INNER JOIN      ETLLoad AS ETL		ON a.ETLLoadID = ETL.ETLLoadID  
                  INNER JOIN      SubCategory AS SC		ON SC.SubCategoryID = a.SubCategoryID  
                  INNER JOIN      TopCategory AS TC		ON TC.TopCategoryID = a.TOPCategoryID
				   -- Return only those resources whose TopCategoryID is in the allowing TopCategory list
					INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
					-- Return only those resources whose PhysicalCityID is in the allowing City list
					INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
WHERE a.SubCategoryID = @SubCategoryID and a.LanguageOfRecord = @lang    AND SC.Active = 1 AND TC.Active = 1 
ORDER BY        a.TOPCategoryID,  a.SubCategoryID, a.Map
--a.PhysicalProvinceID, a.PhysicalCityID, 
END