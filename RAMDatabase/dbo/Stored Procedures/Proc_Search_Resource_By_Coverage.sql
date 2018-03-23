-- =======================================================================================================================================
-- Author:		William Chen
-- Create date: Aug.29, 2016
-- Description:	Accounting to access to token, get resource by its coverage, and filter by language.  
-- REVERSION: On Feb24,2017
-- commented Cross Apply ..., replace by using "           like '' +'%'+@s+'%'+''         "
-- thus, the speed/performance improved a lot
--           on Feb.28, 2017
--           commented all of old codes, replaced new code by using clusting search style,  
-- On March 7, 2017, (1) changed 'LIKE' TO FREETEXT (SQL Server FreeText Search function), 
--					 (2) Commented Try catch content and last ELSE content
--					 (3) Added perfix (kws*)  supfix (*kws) and include (*kws*) by using LIKE '%KKEY WORDS%'
-- Reversion: Mar.30, 2017  ; using language filter
-- =======================================================================================================================================
CREATE PROCEDURE [dbo].[Proc_Search_Resource_By_Coverage] 
 	-- Add the parameters for the stored procedure here
@s NVARCHAR(255) = N' ',
@lang NVARCHAR(50) = 'en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET ansi_warnings OFF;
------------------------------------------------------------
-- Feb.28, 2017
-- declare a var @SearchWordS NVARCHAR(255) = N' ',
-- becausr old stored procedure is @s
------------------------------------------------------------
declare @SearchWordS NVARCHAR(255)  
select @SearchWordS = @s;


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
-- Feburary 28, 2017 added to check users input keyword whether or not in double quotation 
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
		SELECT @K1  =  CONCAT('FORMSOF (THESAURUS,"', KeyWord , '")','  OR "' , KeyWord , '*"' )     FROM  @T_KEYWORD  WHERE ID =  1 ;  


		-------------------------------------------------------------------
		-- Select double quotation content by using FULLTEXT's CONTAINS
		-------------------------------------------------------------------
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
			WHERE  CONTAINS(Coverage, @K1) ;



		------------------------------------------------------------
		-- Select double quotation content by using LIKE "%kws%'
		------------------------------------------------------------
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
			WHERE  Coverage		like	''	+	'%'	+ @K1	+'%'	+	''  ;
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
			SELECT @K1   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  1 ;  
			SELECT @K2   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  2 ;  
			SELECT @K3   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  3 ;  
			SELECT @K4   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  4 ;  
			SELECT @K5   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  5 ;  
			SELECT @K6   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  6 ;  
			SELECT @K7   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  7 ;  
			SELECT @K8   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  8 ;  
			SELECT @K9   =    KeyWord      FROM  @T_KEYWORD  WHERE ID =  9 ;  
			SELECT @K10  =    KeyWord      FROM  @T_KEYWORD  WHERE ID = 10 ;  
			SELECT @K11  =    KeyWord      FROM  @T_KEYWORD  WHERE ID = 11 ; 



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
						WHERE  FREETEXT(Coverage, @PressLetter) ;







-------------------------------------
-- select usine like '%keywords%'
-------------------------------------
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
			  WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') OR 
					 (Coverage like ''+'%'+@K5+'%'+'') OR  (Coverage like ''+'%'+@K6+'%'+'') OR  (Coverage like ''+'%'+@K7+'%'+'') OR  (Coverage like ''+'%'+@K8+'%'+'') OR 
					 (Coverage like ''+'%'+@K9+'%'+'') OR  (Coverage like ''+'%'+@K10+'%'+'') OR  (Coverage like ''+'%'+@K11+'%'+'');
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
				  WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') OR 
						 (Coverage like ''+'%'+@K5+'%'+'') OR  (Coverage like ''+'%'+@K6+'%'+'') OR  (Coverage like ''+'%'+@K7+'%'+'') OR  (Coverage like ''+'%'+@K8+'%'+'') OR 
						 (Coverage like ''+'%'+@K9+'%'+'') OR  (Coverage like ''+'%'+@K10+'%'+'')  ;
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
					  WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') OR 
							 (Coverage like ''+'%'+@K5+'%'+'') OR  (Coverage like ''+'%'+@K6+'%'+'') OR  (Coverage like ''+'%'+@K7+'%'+'') OR  (Coverage like ''+'%'+@K8+'%'+'') OR 
							 (Coverage like ''+'%'+@K9+'%'+'') ;
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
						  WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') OR 
								 (Coverage like ''+'%'+@K5+'%'+'') OR  (Coverage like ''+'%'+@K6+'%'+'') OR  (Coverage like ''+'%'+@K7+'%'+'') OR  (Coverage like ''+'%'+@K8+'%'+'') ;
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
							  WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') OR 
									 (Coverage like ''+'%'+@K5+'%'+'') OR  (Coverage like ''+'%'+@K6+'%'+'') OR  (Coverage like ''+'%'+@K7+'%'+'')  ;
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
								  WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') OR 
										 (Coverage like ''+'%'+@K5+'%'+'') OR  (Coverage like ''+'%'+@K6+'%'+'')  ;
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
									WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') OR 
											(Coverage like ''+'%'+@K5+'%'+'')  ;
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
										WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'') OR  (Coverage like ''+'%'+@K4+'%'+'') ;
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
											WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'') OR  (Coverage like ''+'%'+@K3+'%'+'')  ;
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
												WHERE (Coverage like ''+'%'+@K1+'%'+'') OR (Coverage like ''+'%'+@K2+'%'+'')  ;
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
													WHERE (Coverage like ''+'%'+@K1+'%'+'')  ;
											END
END TRY
BEGIN CATCH
 
END CATCH

 END  -- END OF processing user inputed keywords into @k1--@k11







--------------------------------
-- default langauge is English
--------------------------------
			SELECT DISTINCT    
				a.ETLLoadID
				, a.ResourceAgencyNum
				, Map
				, A.[SubCategoryID]
				, CASE @lang WHEN 'EN' THEN SC.SubCategory ELSE SC.SubCategory_fr END AS [SubCategory]
				, A.[TOPCategoryID]
				, CASE @lang WHEN 'EN' THEN TC.TopCategory ELSE TC.TopCategory_fr END AS [TopCategory]
				, A.[PublicName] AS [Name]
				--, CASE K.[City]  	WHEN 'TBD' THEN a.publicname  ELSE CONVERT(NVARCHAR(2000),  '<p>' + a.publicname+'</p>'+ K.[City]+', '+ K.[Province])	 END  AS PublicNames
				--, a.AgencyDescription
				, K.[PhysicalAddress]
				--, [PhysicalCityID]
				, CASE K.[City]  	WHEN 'TBD' THEN '' ELSE K.[City] END AS [City]
				--, [PhysicalProvinceID]
				, CASE K.[Province]   WHEN 'OTHS' THEN '' WHEN 'Others' THEN '' ELSE K.[Province] END AS [Province]
				--, a.PhysicalCountry   
				--, a.PhysicalPostalCode
				, REPLACE(K.STerm,'/',' ')  AS STerm
				--, REPLACE(K.LTerms,'/',' ')  AS LTerms
				, A.[PhysicalAddressIsPrivate]
				, a.Latitude
				, a.Longitude
				--, a.HoursOfOperation
				, a.Phone
				, a.WebsiteAddress
				--, a.Eligibility
				--, a.DisabilitiesAccess
				--, a.FeeStructureSource
				--, a.ApplicationProcess
				--, a.DocumentsRequired
				--, a.LanguagesOfferedList
				--, a.LanguageOfRecord
				--, a.WorkHours
				--, a.CustomEligibilitybyAge
				--, a.changedDate
				--, a.createdDate
 
			FROM  RamResource   AS a
					JOIN @T_Result AS K				ON K.ETLLoadiD = A.ETLLoadID
					JOIN [dbo].[SubCategory] AS SC	ON SC.[SubCategoryID] = A.SubCategoryID
					JOIN [dbo].[TopCategory] AS TC	ON TC.TopCategoryID = A.TOPCategoryID
					-- Return only those resources whose TopCategoryID is in the allowing TopCategory list
					JOIN		F_Get_Allow_TopCategory (@token) AS ATC ON ATC.TopCategoryID = A.TOPCategoryID 
					-- Return only those resources whose PhysicalCityID is in the allowing City list
					JOIN		F_Get_ALL_Allow_City  (@token)  AS ACID ON ACID.CityID = A.PhysicalCityID 
				--JOIN  @allow_TopCategory as ATC ON ATC.ATID = A.TOPCategoryID -- Return only those resources whose TopCategoryID is in the allowing TopCategory list
				--JOIN (SELECT * FROM  [dbo].[F_Get_ALL_Allow_City]  (@token) ) AS ACID ON ACID.CityID = A.PhysicalCityID -- Return only those resources whose PhysicalCityID is in the allowing City list
			WHERE   a.LanguageOfRecord = @lang   AND  
					SC.Active = 1   AND   TC.Active = 1
			
			ORDER BY        
				--a.PhysicalProvinceID, 
				--a.PhysicalCityID, 
				--a.TOPCategoryID,  
				--a.SubCategoryID, 
				a.Map






	-----------------
	--  END OF THE SP
	-----------------
END
