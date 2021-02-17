-- =============================================
-- Author:		William Chen
-- Create date: 2020-11-08
-- Description:	Search out subset of resources list located in Radius  and Start Lat/Long by key words 
--		Add parameter @token, it will get allowing access-TopCategory and access-city list , 
--		then return those resources in the radius and in the allowing Topcategory and allowing city list 
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Search_Sub_Resource_In_circular_by_kws]
@SearchWordS NVARCHAR(MAX) = N' ',
@StartLatitude NUMERIC(18,10) = 43.654490,
@StartLongitude NUMERIC(18,10) = -79.387419,
@Radius NUMERIC(18,10) = 5.00 ,
@lang NVARCHAR(50) = N'en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
==========================================================================
 first step, find out resource in circular area
==========================================================================
*/
SELECT		DISTINCT
						a.ETLLoadID, 
						a.ResourceAgencyNum,
						a.Map, 
						a.SubCategoryID, 
						a.TOPCategoryID, 
						a.PublicName AS Name, 
						a.PhysicalAddress, 
						A.PhysicalCityID,
                        CASE c.CityName WHEN 'TBD' THEN '' ELSE c.CityName END AS City, 
						CASE p.[ProvinceAlias] WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE p.[ProvinceAlias] END AS Province, 
						a.PhysicalPostalCode, 
						a.PhysicalAddressIsPrivate, 
						a.Latitude, 
						a.Longitude, 
						a.Phone, 
						a.WebsiteAddress,  
						a.LanguageOfRecord, 
						a.Coverage,
						a.IsHelpline
into #circular
FROM            RamResource AS a 
                    INNER JOIN     CityLocation AS c ON a.PhysicalCityID = c.CityId  
                    INNER JOIN     Province AS p ON a.PhysicalProvinceID = p.ProvinceID  
                    INNER JOIN     ETLLoad AS ETL ON a.ETLLoadID = ETL.ETLLoadID  
                    INNER JOIN     SubCategory AS SC ON SC.SubCategoryID = a.SubCategoryID  
                    INNER JOIN     TopCategory AS TC ON TC.TopCategoryID = a.TOPCategoryID 
				-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
					INNER JOIN  F_Get_Allow_TopCategory (@token) AS ATC 	ON ATC.TOPCategoryID = A.TOPCategoryID 
				-- Return only those resources whose PhysicalCityID is in the allowing City list
					INNER JOIN  F_Get_ALL_Allow_City (@token) AS ACID ON ACID.CityID = A.PhysicalCityID 
WHERE			[dbo].[fnCalcDistanceKM](@StartLatitude, @StartLongitude, a.Latitude, a.Longitude) < @Radius 
				AND a.PhysicalCityID != 0 AND SC.Active = 1  AND  TC.Active = 1
				AND @lang = a.LanguageOfRecord
ORDER BY        a.TOPCategoryID,  a.SubCategoryID, a.Map


/*
=====================================================================================================
second step: start freetext search
=====================================================================================================
*/

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ansi_warnings OFF;
--------------------------------------------------------------
-- Searched raw results put in this table variable 
--------------------------------------------------------------
	DECLARE @T_Result TABLE
	(
	etlloadid int ,
	PublicNames NVARCHAR(MAX)  ,
	AgencyDescription NVARCHAR(MAX)  ,
	PhysicalAddress NVARCHAR(MAX)  ,
	City NVARCHAR(MAX)  ,
	Province NVARCHAR(MAX)  ,
	STerm NVARCHAR(MAX)  ,
	LTerms NVARCHAR(MAX)  
	)

--------------------------------------------------------------
-- Allowing access TopCategory list put in table variable 
--------------------------------------------------------------
DECLARE @allow_TopCategory TABLE
(
ATID int
)





-------------------------------------------------------------
-- @PressLetter IS PERPARED FOR FREETEXT SEARCHINH
-------------------------------------------------------------
	DECLARE @PressLetter NVARCHAR(4000) ;
	SELECT @PressLetter = @SearchWordS ;


 --------------------------------------------------------------------------------------------------
 --- Create a table variable @T_KEYWORD. The @T_KEYWORD will be used to handle splited keywords
 --------------------------------------------------------------------------------------------------
DECLARE @T_KEYWORD TABLE
(
ID int IDENTITY(1,1) NOT NULL,
KeyWord NVARCHAR(255)  
)


 ---------------------------------- ---------------------------------- ----------------------------------
 -- DECLARE Key word group. Each @k1..@k11 will set a splited user's input
 ---------------------------------- ---------------------------------- ----------------------------------
 DECLARE @K1  NVARCHAR(255);
 DECLARE @K2  NVARCHAR(255);
 DECLARE @K3  NVARCHAR(255);
 DECLARE @K4  NVARCHAR(255);
 DECLARE @K5  NVARCHAR(255);
 DECLARE @K6  NVARCHAR(255);
 DECLARE @K7  NVARCHAR(255);
 DECLARE @K8  NVARCHAR(255);
 DECLARE @K9  NVARCHAR(255);
 DECLARE @K10 NVARCHAR(255);
 DECLARE @K11 NVARCHAR(255);


-----------------------------------------------------------------------------------------------------------
-- Augest 17, 2016 added to check users input keyword whether or not in double quotation 
-- If use input keywords is in double quotation mark, we will trade it as a whole phrase to be searched   
-----------------------------------------------------------------------------------------------------------
DECLARE @ToBeCheckedKWS NVARCHAR(4000);
SET  @ToBeCheckedKWS = [dbo].[F_Extract_Text_Between_Quotation] (@SearchWordS);

IF LEN(@ToBeCheckedKWS) > 0 -- user input keywords in a double quotation pair, will trade it as a whole keyword
	BEGIN
		SET  @SearchWordS = @ToBeCheckedKWS;
		SET  @PressLetter = @ToBeCheckedKWS;

		INSERT INTO  @T_KEYWORD  (KEYWORD) VALUES(@SearchWordS);

		--  constructing freetext search contain 
		SELECT @K1  =  CONCAT('FORMSOF (THESAURUS,"', KeyWord , '")','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  1 ;  
	END
ELSE  -- user input multiple keywords, will process those words into @k1--@k11
	BEGIN
		--------------------------------------------------------------------------
		---  replace unnecessary char
		--------------------------------------------------------------------------
		 SELECT @SearchWordS = RTRIM(LTRIM(@SearchWordS)) ;
		--- remove last ";" or "space"
		 Select @SearchWordS = SUBSTRING(@SearchWordS, 0, LEN(@SearchWordS)+1) ;
		 --- "," comma convert to ";"
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,',',';') ;
		  --- "." period convert to ";"					   
		 --SELECT @SearchWordS =  REPLACE(@SearchWordS,'.',';') ;
		   --- "：" colon convert to ";"					  
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,':',';') ;
		 --- "("  convert to ";"					   
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,'(',';') ;
		  --- ")"  convert to ";"					  
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,')',';') ;
		  --- "["  convert to ";"					   
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,'[',';') ;
		  --- "]"  convert to ";"					  
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,']',';') ;
		 --- "*" convert to ";"							  
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,'*',';') ;
		 --- "-" dash  convert to ";"					   
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,'-',';') ;
		  --- " " space convert to ";"					  
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,' ',';') ;
		   --- "/" convert to ";"						  
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,'/',';') ;
			--- "_" convert to ";"						   
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,'_',';') ;
			 --- "|" convert to ";"						   
		 SELECT @SearchWordS =  REPLACE(@SearchWordS,'|',';') ;
		 ------------------------------------------------------------------------

		-----------------------------------------------------------------------------------------
		-- Split Search keywords by semi colon ";" then insert into Table varibale @T_KEYWORD
		----------------------------------------------------------------------------------------
		  --数据分隔符
		 DECLARE @splitlen int;
		 SET @splitlen=LEN(';'+'a')-2;


 
		 WHILE CHARINDEX(';',@SearchWordS)>0
			 BEGIN

				IF (
					NOT EXISTS (SELECT KEYWORD FROM @T_KEYWORD WHERE KEYWORD =   LEFT(@SearchWordS,CHARINDEX(';',@SearchWordS)-1))
					AND LEN(LEFT(@SearchWordS,CHARINDEX(';',@SearchWordS)-1) ) > 0
				   )
					INSERT INTO  @T_KEYWORD  (KEYWORD) VALUES(LEFT(@SearchWordS,CHARINDEX(';',@SearchWordS)-1) )  ;
 
				SET @SearchWordS=RTRIM(LTRIM(STUFF(@SearchWordS,1,CHARINDEX(';',@SearchWordS)+@splitlen,'')));
 
			 END;

		 IF ( NOT EXISTS (SELECT KEYWORD FROM  @T_KEYWORD WHERE KEYWORD = @SearchWordS) 
				AND 
				LEN(@SearchWordS) > 0
			)
		 INSERT INTO  @T_KEYWORD  (KEYWORD) VALUES(@SearchWordS);

		  ----------------------------------------------------------------------------------------------------------
		 -- Extract splited search keywords from Table variable @T_KEYWORD, then constructing CONTAIN textsearch 
		 ----------------------------------------------------------------------------------------------------------
			SELECT @K1  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  1 ;  
			SELECT @K2  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  2 ;  
			SELECT @K3  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  3 ;  
			SELECT @K4  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  4 ;  
			SELECT @K5  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  5 ;  
			SELECT @K6  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  6 ;  
			SELECT @K7  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  7 ;  
			SELECT @K8  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  8 ;  
			SELECT @K9  =  CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID =  9 ;  
			SELECT @K10  = CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID = 10 ;  
			SELECT @K11  = CONCAT('FORMSOF (THESAURUS,', KeyWord , ')','  OR "' , KeyWord , '*"')     FROM  @T_KEYWORD  WHERE ID = 11 ; 



			-----------------------------------------------
			-- Feb.1, 2016, add freetext(*,@SearchWordS)
			-----------------------------------------------
 
			IF (@PressLetter IS NOT NULL) AND (@PressLetter != '') AND (@PressLetter != ' ')
					INSERT INTO @T_Result
						SELECT  DISTINCT etlloadid
						, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p> '+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames] 
						, [AgencyDescription]
						, [PhysicalAddress]
						, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
						, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]													 
						, taxonomyterm AS STerm
						, taxonomyterms AS LTerms
						FROM keywords 
						WHERE  FREETEXT(*, @PressLetter) ;

 END  -- END OF processing user inputed keywords into @k1--@k11


 
 	------------------------------------------------------------
	-- beginning fulltext CONTAIN search
	------------------------------------------------------------

BEGIN TRY
 
  
IF (@k11 IS NOT NULL) AND (@K11 != '')
	BEGIN
	 INSERT INTO @T_Result
			SELECT  DISTINCT etlloadid
			, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS PublicNames
			, [AgencyDescription] 
			, [PhysicalAddress]
			, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
			, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
			, taxonomyterm AS STerm
			, taxonomyterms AS LTerms
			FROM keywords 
			  --WHERE CONTAINS(([PublicName],[AgencyDescription],[PhysicalCity],[PhysicalProvince],[TaxonomyTerm],[TaxonomyTerms]), @Searching)
			  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) OR 
					CONTAINS(*, @K5) OR CONTAINS(*, @K6) OR CONTAINS(*, @K7) OR CONTAINS(*, @K8) OR 
					CONTAINS(*, @K9) OR CONTAINS(*, @K10) OR CONTAINS(*, @K11);
	END 
	ELSE IF (@k10 IS NOT NULL) AND (@K10 != '')
		BEGIN
		 INSERT INTO @T_Result
				SELECT  DISTINCT etlloadid
				, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
				, [AgencyDescription] 
				, [PhysicalAddress]
				, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
				, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
				, taxonomyterm AS STerm
				, taxonomyterms AS LTerms
				FROM keywords 
				  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) OR 
						CONTAINS(*, @K5) OR CONTAINS(*, @K6) OR CONTAINS(*, @K7) OR CONTAINS(*, @K8) OR 
						CONTAINS(*, @K9) OR CONTAINS(*, @K10) ;
		END 
		ELSE IF (@k9 IS NOT NULL) AND (@K9 != '')
			BEGIN
			 INSERT INTO @T_Result
					SELECT  DISTINCT etlloadid
					, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
					, [AgencyDescription]
					, [PhysicalAddress]
					, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
					, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]					 
					, taxonomyterm AS STerm
					, taxonomyterms AS LTerms
					FROM keywords 
					  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) OR 
							CONTAINS(*, @K5) OR CONTAINS(*, @K6) OR CONTAINS(*, @K7) OR CONTAINS(*, @K8) OR 
							CONTAINS(*, @K9)  ;
			END 		
			ELSE IF (@k8 IS NOT NULL) AND (@K8 != '')
				BEGIN
				 INSERT INTO @T_Result
						SELECT  DISTINCT etlloadid
						, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
						, [AgencyDescription] 
						, [PhysicalAddress]
						, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
						, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
						, taxonomyterm AS STerm
						, taxonomyterms AS LTerms
						FROM keywords 
						  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) OR 
								CONTAINS(*, @K5) OR CONTAINS(*, @K6) OR CONTAINS(*, @K7) OR CONTAINS(*, @K8)  ;
				END 
				ELSE IF (@k7 IS NOT NULL) AND (@K7 != '')
					BEGIN
					 INSERT INTO @T_Result
							SELECT  DISTINCT etlloadid
							, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
							, [AgencyDescription]
							, [PhysicalAddress]
							, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
							, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]							 
							, taxonomyterm AS STerm
							, taxonomyterms AS LTerms
							FROM keywords 
							  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) OR 
									CONTAINS(*, @K5) OR CONTAINS(*, @K6) OR CONTAINS(*, @K7) ;
					END 
					ELSE IF (@k6 IS NOT NULL) AND (@K6 != '')
						BEGIN
						 INSERT INTO @T_Result
								SELECT  DISTINCT etlloadid
								, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
								, [AgencyDescription] 
								, [PhysicalAddress]
								, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
								, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
								, taxonomyterm AS STerm
								, taxonomyterms AS LTerms
								FROM keywords 
								  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) OR 
										CONTAINS(*, @K5) OR CONTAINS(*, @K6) ;
						END 
						ELSE IF (@k5 IS NOT NULL) AND (@K5 != '')
							BEGIN
							 INSERT INTO @T_Result
									SELECT  DISTINCT etlloadid
									, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames] 
									, [AgencyDescription]
									, [PhysicalAddress]
									, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
									, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]									 
									, taxonomyterm AS STerm
									, taxonomyterms AS LTerms
									FROM keywords 
									  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) OR 
											CONTAINS(*, @K5) ;
							END
							ELSE IF (@k4 IS NOT NULL) AND (@K4 != '')
								BEGIN
								 INSERT INTO @T_Result
										SELECT  DISTINCT etlloadid
										, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]  
										, [AgencyDescription]
										, [PhysicalAddress]
										, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
										, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]										 
										, taxonomyterm AS STerm
										, taxonomyterms AS LTerms
										FROM keywords 
										  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) OR CONTAINS(*, @K4) ;
								END
								ELSE IF (@k3 IS NOT NULL) AND (@K3 != '')
									BEGIN
									 INSERT INTO @T_Result
											SELECT  DISTINCT etlloadid
											, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
											, [AgencyDescription]
											, [PhysicalAddress]
											, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
											, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]											 
											, taxonomyterm AS STerm
											, taxonomyterms AS LTerms
											FROM keywords 
											  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2) OR CONTAINS(*, @K3) ;
									END 
									ELSE IF (@k2 IS NOT NULL) AND (@K2 != '')
										BEGIN
										 INSERT INTO @T_Result
												SELECT  DISTINCT etlloadid
												, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
												, [AgencyDescription]
												, [PhysicalAddress]
												, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
												, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]												 
												, taxonomyterm AS STerm
												, taxonomyterms AS LTerms
												FROM keywords 
												  WHERE  CONTAINS(*, @K1) OR CONTAINS(*, @K2)  ;
										END
										ELSE IF (@k1 IS NOT NULL) AND (@K1 != '')
											BEGIN
											 INSERT INTO @T_Result
													SELECT  DISTINCT etlloadid
													, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p> '+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames] 
													, [AgencyDescription]
													, [PhysicalAddress]
													, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
													, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]													 
													, taxonomyterm AS STerm
													, taxonomyterms AS LTerms
													FROM keywords 
													  WHERE  CONTAINS(*, @K1) ;
											END
											ELSE
												BEGIN
												 INSERT INTO @T_Result
														SELECT  DISTINCT etlloadid
														, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000), '<p>' + publicname+'</p> '+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
														, [AgencyDescription]
														, [PhysicalAddress]
														, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
														, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]														 
														, taxonomyterm AS STerm
														, taxonomyterms AS LTerms
														FROM keywords 
														ORDER BY PublicNames  

												END;

    
END TRY
BEGIN CATCH
 INSERT INTO @T_Result
			SELECT  DISTINCT etlloadid
			, CASE physicalcity  	WHEN 'TBD' THEN publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + publicname+'</p>'+ physicalcity+', '+ physicalprovince)	 END  AS [PublicNames]
			, [AgencyDescription] 
			, [PhysicalAddress]
			, CASE physicalcity  	WHEN 'TBD' THEN '' ELSE physicalcity END AS [City]
			, CASE [PhysicalProvince]   WHEN 'OTHS' THEN '' ELSE [PhysicalProvince] END AS [Province]
			, taxonomyterm AS STerm
			, taxonomyterms AS LTerms
			FROM keywords 
;
END CATCH
;



--select 'FREETEXT',* from @T_Result
--------------------------------
-- default langauge is English
--------------------------------
			SELECT DISTINCT    
				  a.ETLLoadID
				, a.ResourceAgencyNum
				, a.Map
				, A.[SubCategoryID]
				, A.[TOPCategoryID]
				, A. [Name]
				, K.[PhysicalAddress]
				, CASE K.[City]  	WHEN 'TBD' THEN '' ELSE K.[City] END AS [City]
				, CASE K.[Province]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE K.[Province] END AS [Province]
				, a.PhysicalPostalCode
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				, a.Phone
				, a.WebsiteAddress
				, a.Coverage
				, a.IsHelpline
				
			FROM  #circular   AS a
				JOIN @T_Result AS K ON K.ETLLoadiD = A.ETLLoadID
				JOIN [dbo].[SubCategory] AS SC 		ON SC.[SubCategoryID] = A.SubCategoryID
				JOIN [dbo].[TopCategory] AS TC 		ON TC.TopCategoryID = A.TOPCategoryID
				-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
				JOIN  F_Get_Allow_TopCategory (@token) AS ATC 	ON ATC.TOPCategoryID = A.TOPCategoryID 
				-- Return only those resources whose PhysicalCityID is in the allowing City list
				JOIN  F_Get_ALL_Allow_City (@token) AS ACID ON ACID.CityID = A.PhysicalCityID 
			WHERE a.LanguageOfRecord = @lang   AND  
					SC.Active = 1   AND   TC.Active = 1
			ORDER BY    a.Map





	-----------------
	--  END OF THE SP
	-----------------
END