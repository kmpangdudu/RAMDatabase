-- =============================================
-- Author:		<Author,,Name>
-- Create date: July 24, 2021
-- Description:	Get all RAM Resource by lang 
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Get_All_V3_Ram_by_Lang]
  @lang nvarchar(20) = 'en',
  @token NVARCHAR (50) = '',
  @a int

 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 

if ( @a = 0 )
-- @a =0 then Table Sample 2000 Rows, else output all records
		SELECT	 
								a.ETLLoadID, 
								a.ResourceAgencyNum,
								a.Map, 
								a.SubCategoryID, 
								a.TOPCategoryID, 
          
								a.PublicName AS Name, 
			 
								a.AgencyDescription, 
								a.PhysicalAddress, 
	 
								CASE c.CityName WHEN 'TBD' THEN '' ELSE c.CityName END AS City, 
				 
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
								a.NormalWaitTime,
								a.IsHelpline
								, case @lang
									when 'en' then
										case  when etl.[CustomTargetPopulation] is null then 'Open to all' else etl.[CustomTargetPopulation] end
									when 'fr' then 
										case  when etl.[CustomTargetPopulation] is null then 'Ouvert à tous' else etl.[CustomTargetPopulation] end
									end as CustomTargetPopulation
						 
	
		FROM            RamResource AS a tablesample (2000 Rows) 
							INNER JOIN		CityLocation		AS c	ON a.PhysicalCityID = c.CityId  
							INNER JOIN		Province			AS p	ON a.PhysicalProvinceID = p.ProvinceID  
							INNER JOIN		ETLLoad				AS ETL	ON a.ETLLoadID = ETL.ETLLoadID  
							INNER JOIN		SubCategory			AS SC	ON SC.SubCategoryID = a.SubCategoryID  
							INNER JOIN		TopCategory			AS TC	ON TC.TopCategoryID = a.TOPCategoryID
							-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
							INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
							-- Return only those resources whose PhysicalCityID is in the allowing City list
							INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
 
		WHERE a.LanguageOfRecord = @lang  AND  SC.Active = 1 AND TC.Active = 1

Else

		SELECT	 
								a.ETLLoadID, 
								a.ResourceAgencyNum,
								a.Map, 
								a.SubCategoryID, 
								a.TOPCategoryID, 
          
								a.PublicName AS Name, 
			 
								a.AgencyDescription, 
								a.PhysicalAddress, 
	 
								CASE c.CityName WHEN 'TBD' THEN '' ELSE c.CityName END AS City, 
				 
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
								a.NormalWaitTime,
								a.IsHelpline
								, case @lang
									when 'en' then
										case  when etl.[CustomTargetPopulation] is null then 'Open to all' else etl.[CustomTargetPopulation] end
									when 'fr' then 
										case  when etl.[CustomTargetPopulation] is null then 'Ouvert à tous' else etl.[CustomTargetPopulation] end
									end as CustomTargetPopulation
						 
	
		FROM            RamResource AS a 
							INNER JOIN		CityLocation		AS c	ON a.PhysicalCityID = c.CityId  
							INNER JOIN		Province			AS p	ON a.PhysicalProvinceID = p.ProvinceID  
							INNER JOIN		ETLLoad				AS ETL	ON a.ETLLoadID = ETL.ETLLoadID  
							INNER JOIN		SubCategory			AS SC	ON SC.SubCategoryID = a.SubCategoryID  
							INNER JOIN		TopCategory			AS TC	ON TC.TopCategoryID = a.TOPCategoryID
							-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
							INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
							-- Return only those resources whose PhysicalCityID is in the allowing City list
							INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 

		WHERE a.LanguageOfRecord = @lang  AND  SC.Active = 1 AND TC.Active = 1

END