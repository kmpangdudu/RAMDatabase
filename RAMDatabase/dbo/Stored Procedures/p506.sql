-- =============================================
-- Author:		William Chen
-- Create date: Mar.10, 2016
-- Description:	Search resource by using Province
-- revision :  Aug. 12, 2016
-- Added Parameter @token, 
-- =============================================
create PROCEDURE p506
@ProvinceID int,
@lang nvarchar(50) = 'en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
DECLARE @V INT -- 
SELECT TOP(1)  @V = ProvinceID    FROM    [dbo].[F_Get_Allow_Province] (@token)
IF @V = 0 
	BEGIN   -- allow access all provinces 
			SELECT       DISTINCT 
								a.ETLLoadID
								, a.ResourceAgencyNum
								, Map
								, A.[SubCategoryID]
								, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory_fr END AS [SubCategory]
								, A.[TOPCategoryID]
								, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
								, A.[PublicName] AS [Name]
								, A.[PhysicalAddress]
								, A.[PhysicalAddressIsPrivate]
								, CASE C.CityName  	WHEN 'TBD' THEN '' ELSE C.CityName END AS [City]
								, CASE P.[Province]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE P.[Province] END AS [Province]
								, REPLACE(ETL.TaxonomyTerm,'/',' ')  AS STerm
								, a.Latitude
								, a.Longitude
								, a.Phone
								, a.WebsiteAddress
				FROM            RamResource AS a 
									INNER JOIN      CityLocation AS c	ON a.PhysicalCityID = c.CityId 
									INNER JOIN      Province AS p		ON a.PhysicalProvinceID = p.ProvinceID  
									INNER JOIN      ETLLoad AS ETL		ON a.ETLLoadID = ETL.ETLLoadID  
									INNER JOIN      SubCategory AS SC	ON SC.SubCategoryID = a.SubCategoryID  
									INNER JOIN      TopCategory AS TC	ON TC.TopCategoryID = a.TOPCategoryID
									-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
									INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC		ON ATC.TopCategoryID = A.TOPCategoryID 

	WHERE [PhysicalProvinceID] = @ProvinceID  and a.LanguageOfRecord = @lang    AND SC.Active = 1 AND TC.Active = 1 
	ORDER BY         a.TOPCategoryID,  a.SubCategoryID, a.Map
	--a.PhysicalProvinceID, a.PhysicalCityID,
	END
ELSE  --  allow access specific provinces
	BEGIN
		SELECT       DISTINCT 
						a.ETLLoadID
						, a.ResourceAgencyNum
						, Map
						, A.[SubCategoryID]
						, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory_fr END AS [SubCategory]
						, A.[TOPCategoryID]
						, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
						, A.[PublicName] AS [Name]
						, A.[PhysicalAddress]
						, A.[PhysicalAddressIsPrivate]
						, CASE C.CityName  	WHEN 'TBD' THEN '' ELSE C.CityName END AS [City]
						, CASE P.[Province]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE P.[Province] END AS [Province]
						, REPLACE(ETL.TaxonomyTerm,'/',' ')  AS STerm
						, a.Latitude
						, a.Longitude
						, a.Phone
						, a.WebsiteAddress
		FROM            RamResource AS a 
							INNER JOIN      CityLocation AS c	ON a.PhysicalCityID = c.CityId 
							INNER JOIN      Province AS p		ON a.PhysicalProvinceID = p.ProvinceID  
							INNER JOIN      ETLLoad AS ETL		ON a.ETLLoadID = ETL.ETLLoadID  
							INNER JOIN      SubCategory AS SC	ON SC.SubCategoryID = a.SubCategoryID  
							INNER JOIN      TopCategory AS TC	ON TC.TopCategoryID = a.TOPCategoryID
							-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
							INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC		ON ATC.TopCategoryID = A.TOPCategoryID 
							-- Return only those resources whose PhysicalCityID is in the allowing PROVINCE list
							INNER JOIN		F_Get_Allow_Province (@token)  AS APID		ON APID.ProvinceID = A.PhysicalProvinceID 
							-- Return only those resources whose PhysicalCityID is in the allowing City list
							INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
		WHERE [PhysicalProvinceID] = @ProvinceID  and a.LanguageOfRecord = @lang    AND SC.Active = 1 AND TC.Active = 1 
		ORDER BY         a.TOPCategoryID,  a.SubCategoryID, a.Map
		--a.PhysicalProvinceID, a.PhysicalCityID,
	END
END