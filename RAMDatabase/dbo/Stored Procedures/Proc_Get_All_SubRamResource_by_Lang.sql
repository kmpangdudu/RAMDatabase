-- =============================================
-- Author:		William Chen
-- Create date: 2020-11-07
-- Description:	Get subset of Resource list records by language by 4D asked
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Get_All_SubRamResource_by_Lang]
 @lang nvarchar(20) = 'en',
 @token NVARCHAR (50)
AS
BEGIN

	SET NOCOUNT ON;

SELECT	DISTINCT
						a.ETLLoadID,
						a.ResourceAgencyNum,
						a.Map, 
						a.SubCategoryID, 
						a.TOPCategoryID, 
						a.PublicName AS Name, 
						a.PhysicalAddress, 
                        CASE c.CityName WHEN 'TBD' THEN '' ELSE c.CityName END AS City, 
						CASE p.[ProvinceAlias] WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS Province, 
						a.PhysicalPostalCode, 
						a.PhysicalAddressIsPrivate, 
						a.Latitude, 
						a.Longitude, 
						a.Phone, 
						a.WebsiteAddress, 
						a.Coverage
	
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
ORDER BY        a.TOPCategoryID,  a.SubCategoryID, a.Map
END