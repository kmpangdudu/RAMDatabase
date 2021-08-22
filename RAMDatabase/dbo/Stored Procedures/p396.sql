-- =============================================
-- Author:		William Chen
-- Create date: 2021-06-13
-- Description:	Get all HELPLINE resources by langauge
-- =============================================
create PROCEDURE p396
@lang NVARCHAR(20) = 'all',
@token NVARCHAR (50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	If @lang = 'all' 
	Begin
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
								into #R
		FROM            RamResource AS a 
							INNER JOIN      CityLocation AS c ON a.PhysicalCityID = c.CityId  
							INNER JOIN      Province AS p ON a.PhysicalProvinceID = p.ProvinceID  
							INNER JOIN      ETLLoad AS ETL ON a.ETLLoadID = ETL.ETLLoadID  
							INNER JOIN      SubCategory AS SC ON SC.SubCategoryID = a.SubCategoryID  
							INNER JOIN      TopCategory AS TC ON TC.TopCategoryID = a.TOPCategoryID
				   			-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
							INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
							-- Return only those resources whose PhysicalCityID is in the allowing City list
							INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
		WHERE       IsHelpline = 1   AND SC.Active = 1 AND TC.Active = 1 

		Select 
							a.ETLLoadID, 
							a.ResourceAgencyNum,
							a.Map, 
							a.SubCategoryID, 
							a.TOPCategoryID, 
							a.[Name], 
							a.PhysicalAddress,  
							a.City, 
							a.Province, 
							a.PhysicalPostalCode,  
							a.PhysicalAddressIsPrivate, 
							a.Latitude, 
							a.Longitude, 
							a.Phone, 
							a.WebsiteAddress, 
							a.Coverage,
							a.IsHelpline
	
		from 
		(select  *, ROW_NUMBER() over (partition by etlloadid order by etlloadid) as rownumber  from #r ) as a  where rownumber =1
  
		
	End 
else 
	Begin  -- @lang != 'all' 
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
						into #R1
	FROM            RamResource AS a 
					INNER JOIN      CityLocation AS c ON a.PhysicalCityID = c.CityId  
					INNER JOIN      Province AS p ON a.PhysicalProvinceID = p.ProvinceID  
					INNER JOIN      ETLLoad AS ETL ON a.ETLLoadID = ETL.ETLLoadID  
					INNER JOIN      SubCategory AS SC ON SC.SubCategoryID = a.SubCategoryID  
					INNER JOIN      TopCategory AS TC ON TC.TopCategoryID = a.TOPCategoryID
				   	-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
					INNER JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
					-- Return only those resources whose PhysicalCityID is in the allowing City list
					INNER JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
	WHERE         a.LanguageOfRecord = @lang  AND  IsHelpline = 1   AND SC.Active = 1 AND TC.Active = 1  
	
	Select 
						a.ETLLoadID, 
						a.ResourceAgencyNum,
						a.Map, 
						a.SubCategoryID, 
						a.TOPCategoryID, 
						a.[Name], 
						a.PhysicalAddress,  
                        a.City, 
						a.Province, 
						a.PhysicalPostalCode,  
						a.PhysicalAddressIsPrivate, 
						a.Latitude, 
						a.Longitude, 
						a.Phone, 
						a.WebsiteAddress, 
						a.Coverage,
						a.IsHelpline
	
	from 
	(select  *, ROW_NUMBER() over (partition by etlloadid order by etlloadid) as rownumber  from #r1 ) as a  where rownumber =1
	End 





END