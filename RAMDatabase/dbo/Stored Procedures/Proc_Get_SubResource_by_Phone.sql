-- ==========================================================================================
-- Author:		William Chen
-- Create date: Jan.5, 2021
-- Description:	get subset of resource by using Phone number
-- ==========================================================================================
CREATE PROCEDURE [dbo].[Proc_Get_SubResource_by_Phone] 
@phone varchar(50) = '',
@lang nvarchar(50) = 'en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

declare @PhoneChanged varchar(50)
SET  @PhoneChanged = dbo.stripNonNumber(LTRIM(RTRIM(@Phone)))
if len(@PhoneChanged) >1 
	Begin
		SET @PhoneChanged =  @PhoneChanged+'%'
		SELECT     DISTINCT   
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
								a.Coverage,
								a.IsHelpline
		FROM            RamResource AS a 
						   INNER JOIN      CityLocation AS c	ON a.PhysicalCityID = c.CityId  
						   INNER JOIN      Province AS p		ON a.PhysicalProvinceID = p.ProvinceID  
						   INNER JOIN      ETLLoad AS ETL		ON a.ETLLoadID = ETL.ETLLoadID  
						   INNER JOIN      SubCategory AS SC	ON SC.SubCategoryID = a.SubCategoryID  
						   INNER JOIN      TopCategory AS TC	ON TC.TopCategoryID = a.TOPCategoryID
						   -- Return only those resources whose TopCategoryID is in the allowing TopCategory list
							INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
							-- Return only those resources whose PhysicalCityID is in the allowing City list
							INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
		WHERE dbo.stripNonNumber (a.phone) like @PhoneChanged  
		and a.LanguageOfRecord = @lang    AND SC.Active = 1 AND TC.Active = 1 
		ORDER BY        a.TOPCategoryID,  a.SubCategoryID, a.Map
	END 
	ELSE
			SELECT 
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
								a.Coverage,
								a.IsHelpline
			 FROM            RamResource AS a 
						   INNER JOIN      CityLocation AS c	ON a.PhysicalCityID = c.CityId  
						   INNER JOIN      Province AS p		ON a.PhysicalProvinceID = p.ProvinceID  
						   INNER JOIN      ETLLoad AS ETL		ON a.ETLLoadID = ETL.ETLLoadID  
						   INNER JOIN      SubCategory AS SC	ON SC.SubCategoryID = a.SubCategoryID  
						   INNER JOIN      TopCategory AS TC	ON TC.TopCategoryID = a.TOPCategoryID
						   -- Return only those resources whose TopCategoryID is in the allowing TopCategory list
							INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
							-- Return only those resources whose PhysicalCityID is in the allowing City list
							INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
		WHERE  1=2
		ORDER BY        a.TOPCategoryID,  a.SubCategoryID, a.Map
END