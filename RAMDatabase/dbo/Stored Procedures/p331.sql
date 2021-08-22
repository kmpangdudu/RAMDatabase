-- ==========================================================================================
-- Author:		William Chen
-- Create date: Apr.24, 2017
-- Description:	get resource by filter map; mapped, list, both and shelter
-- ==========================================================================================
create PROCEDURE p331
@type NVARCHAR(50) =N'Mapped',
@lang NVARCHAR(50) = 'en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT @type = LTRIM (RTRIM (@TYPE));

DECLARE @t NVARCHAR(50);
SELECT  @t=
	CASE  @type
		WHEN	'MAP'	THEN	 N'MAPPED'  
		WHEN	'M'		THEN	 N'MAPPED'  
		WHEN	'0'		THEN	 N'MAPPED'  
		WHEN	'L'	THEN	 N'LIST'  
		WHEN	'1'		THEN	 N'LIST'  
		WHEN	'B'		THEN	 N'BOTH'
		WHEN	'H'		THEN	 N'BOTH'
		WHEN	'2'		THEN	 N'BOTH'
		WHEN	'S'		THEN	 N'SHELTER'
		WHEN	'3'		THEN	 N'SHELTER'				  
	END;

SELECT		DISTINCT
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
					INNER JOIN       CityLocation AS c	ON a.PhysicalCityID = c.CityId  
					INNER JOIN       Province AS p		ON a.PhysicalProvinceID = p.ProvinceID  
					INNER JOIN       ETLLoad AS ETL		ON a.ETLLoadID = ETL.ETLLoadID  
					INNER JOIN       SubCategory AS SC	ON SC.SubCategoryID = a.SubCategoryID 
					INNER JOIN       TopCategory AS TC	ON TC.TopCategoryID = a.TOPCategoryID
				  	-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
					INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
					-- Return only those resources whose PhysicalCityID is in the allowing City list
					INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
WHERE A.[MAP] = @t and a.LanguageOfRecord  = @lang  AND SC.Active = 1  AND TC.Active = 1
ORDER BY  a.TOPCategoryID,  a.SubCategoryID 
--a.PhysicalProvinceID, a.PhysicalCityID,
END