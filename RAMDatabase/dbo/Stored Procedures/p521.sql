-- ==============================================================================================================
-- Author:		William Chen
-- Create date: Feb.23, 2016
-- Description:	Get_All_Resource_In_Radius_boundary_Box
-- Reversion: Aug.11, 2016
-- Added Parameter @token, check access control list, get allowing TopCategory List and allowing City list
-- Searching and returning those allowing resources locatied in boundary-box  
-- Revision: On March 30, 2017, add language filter  
-- ==============================================================================================================
create PROCEDURE p521
@Lat NUMERIC(18,10) = 43.654490,
@Long NUMERIC(18,10) = -79.387419,
@Radius NUMERIC(18,10) = 5.0,
@lang Nvarchar(50) = N'en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DECLARE @Distance NUMERIC(18,10) = @Radius * 1609.344  ;
	DECLARE @Earth_Radius INT = 6371000;


	DECLARE @NorthLat NUMERIC(18,10) = @Lat + DEGREES(@distance / @Earth_Radius)
   ,@SouthLat NUMERIC(18,10) = @Lat - DEGREES(@distance / @Earth_Radius)
   ,@EastLong NUMERIC(18,10) = @Long + DEGREES(@distance / @Earth_Radius / COS(RADIANS(@Lat)))
   ,@WestLong NUMERIC(18,10) = @Long - DEGREES(@distance / @Earth_Radius / COS(RADIANS(@Lat)));
    -- Insert statements for procedure here
SELECT       DISTINCT 
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, a.SubCategoryID
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
                    INNER JOIN       CityLocation AS c ON a.PhysicalCityID = c.CityId  
                    INNER JOIN       Province AS p ON a.PhysicalProvinceID = p.ProvinceID  
                    INNER JOIN       ETLLoad AS ETL ON a.ETLLoadID = ETL.ETLLoadID  
                    INNER JOIN       SubCategory AS SC ON SC.SubCategoryID = a.SubCategoryID  
                    INNER JOIN       TopCategory AS TC ON TC.TopCategoryID = a.TOPCategoryID 
					INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID -- Return only those resources whose TopCategoryID is in the allowing TopCategory list
					INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID -- Return only those resources whose PhysicalCityID is in the allowing City list

WHERE (
            A.Latitude >= @SouthLat
            AND A.Latitude <= @NorthLat )
        AND (
              A.Longitude >= @WestLong
              AND A.Longitude <= @EastLong )
		AND a.PhysicalCityID != 0   AND SC.Active = 1 AND TC.Active = 1 
		AND @lang = a.LanguageOfRecord
ORDER BY       a.TOPCategoryID,  a.SubCategoryID, a.Map 
              --a.PhysicalProvinceID, a.PhysicalCityID, 
END