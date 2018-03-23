-- ==================================================================================================================================
-- Author:		William Chen
-- Create date: Oct.19, 2015
-- Description:	Constructing RAM Resource. This is for Biz-logic Version 2
-- revision: Feb.4, 2016:Changed Map field data type from "bit" or "int" to NVARCHAR(50);
--					add InterestTaxonomyDelivery to meger stetment; because table 'InterestTaxonomy' Chenged 
--			 Apr.10, Add (WHERE IT.Active = 1 AND SI.Active = 1 AND TS.Active = 1) to Merge statement using section
--			 Oct.25, 2016:Review Biz-Logic, and then changed:
--					1) adjusted PublicName's looking up chain to "Program" 1st, "Program@site" 2nd
--					2) commented pick up from "Site" and "Agency"
--           August 24, 2017 apply Biz-Logic Version 2.  Adding "Program@Site" to queue to constructe RAMResource
-- ===================================================================================================================================
CREATE PROCEDURE [dbo].[Proc_Construct_RAMResource]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	TRUNCATE TABLE RAMResource;


--;WITH RAM_CTE
--AS
--(
--SELECT        
 --ETLLoadID, 
 --ResourceAgencyNum, 
 --Map, 
 --ISNULL(PublicName,'') AS  PublicName,
 --ISNULL(AgencyDescription,'') AS AgencyDescription,
 --TaxonomyLevelNameID, 
 --ParentAgencyNum, 
 --ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') AS  PhysicalAddress,
 --ISNULL(PhysicalCityID,0) AS  PhysicalCityID,
 --ISNULL(PhysicalProvinceID,0) AS PhysicalProvinceID,
 --ISNULL(PhysicalPostalCode,'') AS PhysicalPostalCode, 
 --ISNULL([PhysicalCountry],'') AS [PhysicalCountry],
 --ISNULL(PhysicalAddressIsPrivate, 'No') AS [PhysicalAddressIsPrivate],
 --ISNULL(Latitude, 0.0) AS Latitude,
 --ISNULL(Longitude,0.0) AS Longitude, 
 --ISNULL(HoursOfOperation,'') AS HoursOfOperation, 
 ---- "Phone priority list": 1 - Toll Free --> 2 - Business Line --> 3 - After Hours Line --> 4 - Hotline --> 5 - Out of Area Line --> 6 - Custom Phone 1 --> 7 - Custom Phone 2 --> 8 - Custom Phone 3 --> 9 - Custom Phone 4 --> 10 - Custom Phone 5
 --ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),'') AS Phone, 
 --ISNULL(WebsiteAddress,'') AS WebsiteAddress, 
 --ISNULL(Eligibility,'') AS Eligibility,
 --ISNULL(DisabilitiesAccess,'') AS DisabilitiesAccess,
 --ISNULL(FeeStructureSource,'') AS FeeStructureSource,
 --ISNULL(ApplicationProcess,'') AS ApplicationProcess,
 --ISNULL(DocumentsRequired,'') AS DocumentsRequired,
 --ISNULL(LanguagesOfferedList,'') AS LanguagesOfferedList,
 --ISNULL(LanguageOfRecord,'') AS LanguageOfRecord,
 --ISNULL(WorkHours,'') AS WorkHours,
 --ISNULL(CustomEligibilitybyAge,'') AS CustomEligibilitybyAge,
 --ISNULL(CoverageArea,'') AS CoverageArea,
 --ISNULL(Coverage,'') AS Coverage,
 --ISNULL(NormalWaitTime,'') AS NormalWaitTime,
 --ConnectsToSiteNum, 
 --ConnectsToProgramNum,
 --getdate() AS changedDate,
 --createdDate  ,
-- R.*
--FROM            taxonomyraw 
--OUTER APPLY [dbo].[F_ram] (taxonomyraw.ETLLOADID) AS R
--)


;WITH RAM_CTE
AS 
( 
SELECT   T.[ETLLoadID],T.MAP AS [MAP], T.[ResourceAgencyNum],[ParentAgencyNum] ,[TaxonomyLevelNameID],[LanguageOfRecord]
,     R.*  FROM        taxonomyraw  AS T  OUTER APPLY [dbo].[F_ram] (T.ETLLOADID) AS R  
)
SELECT 
 [ETLLoadID]				 
,[ResourceAgencyNum]		 
,[Map]
-- if error,  send ResourceAgencyNums  to Kristen
,[PublicName]               =  CASE 
									WHEN LEN([PS_PublicName])	>	0		THEN [PS_publicname]	     -- Program@site
									WHEN LEN([p_PublicName])	>	0		THEN [p_PublicName]		     -- Program
									--WHEN LEN([s_PublicName]) >0 THEN [s_PublicName]    -- site
									--ELSE [a_publicname]                                -- Agency
									ELSE ''    -- Send ResourceAgencyNums for Program and Program@Site to Kristen to resolve error
								END
-- if error,  send ResourceAgencyNums to Kristen
,[AgencyDescription]        =  CASE 
									WHEN	LEN([ps_AgencyDescription])		>	0		THEN [ps_AgencyDescription] 
									WHEN	LEN([P_AgencyDescription])		>	0		THEN [P_AgencyDescription] 
									ELSE	''    -- Send ResourceAgencyNums for Program and Program@Site to Kristen to resolve error
								END
,[TaxonomyLevelNameID]      
,[ParentAgencyNum]            
,[PhysicalAddressIsPrivate] =	CASE
									WHEN	LEN([ps_PhysicalAddressIsPrivate])		>	0		THEN [ps_PhysicalAddressIsPrivate] 
									WHEN	LEN([P_PhysicalAddressIsPrivate])		>	0		THEN [P_PhysicalAddressIsPrivate] 
									ELSE	''    -- Send ResourceAgencyNums for Program and Program@Site to Kristen to resolve error
								END

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Nov.21, 2016 Changing Role by WC. Because too many no city records come, Try to ignore  "Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S""   
-- Try  [PhysicalCityID] and [PhysicalProvinceID],  [PhysicalCountry],   [PhysicalPostalCode],  [s_PhysicalCountry]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- begin try (begin testing)
--,[PhysicalAddress]          =  [s_PhysicalAddress]		-- Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S"
,[PhysicalAddress]          =  CASE 
									WHEN  LEN ( [S_PhysicalAddress] )	>	0		THEN		[S_PhysicalAddress]
									WHEN  LEN ( [Ps_PhysicalAddress] )	>	0		THEN		[Ps_PhysicalAddress]
									WHEN  LEN ( [p_PhysicalAddress] )	>	0		THEN		[p_PhysicalAddress]

									WHEN  LEN ( [a_PhysicalAddress] )	>	0		THEN		[a_PhysicalAddress]
									ELSE	''
								END


--,[PhysicalCityID]           =  [s_PhysicalCityID]		-- Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S"
,[PhysicalCityID]           =  CASE 
									WHEN	[s_PhysicalCityID]		!=	0		THEN		[s_PhysicalCityID]
									WHEN	[ps_PhysicalCityID]		!=	0		THEN		[ps_PhysicalCityID]
									WHEN	[P_PhysicalCityID]		!=	0		THEN		[P_PhysicalCityID]
									WHEN	[a_PhysicalCityID]		!=	0		THEN		[a_PhysicalCityID]
									ELSE	0
								END

--,[PhysicalProvinceID]       =  [s_PhysicalProvinceID]	-- Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S"
,[PhysicalProvinceID]       =  CASE
									WHEN	[s_PhysicalProvinceID]		!=	0		THEN		[s_PhysicalProvinceID]
									WHEN	[ps_PhysicalProvinceID]		!=	0		THEN		[ps_PhysicalProvinceID]
									WHEN	[P_PhysicalProvinceID]		!=	0		THEN		[P_PhysicalProvinceID]
									WHEN	[a_PhysicalProvinceID]		!=	0		THEN		[a_PhysicalProvinceID]
									ELSE	99
								END




--,[PhysicalCountry]          =  [s_PhysicalCountry]		-- Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S"
,[PhysicalCountry]          =  CASE
									WHEN	LEN ( [s_PhysicalCountry] )		>	0		THEN		[s_PhysicalCountry]
									WHEN	LEN ( [ps_PhysicalCountry] )	>	0		THEN		[ps_PhysicalCountry]
									WHEN	LEN ( [P_PhysicalCountry] )		>	0		THEN		[P_PhysicalCountry]
									WHEN	LEN ( [a_PhysicalCountry] )		>	0		THEN		[a_PhysicalCountry]
									ELSE	''
								END

--,[PhysicalPostalCode]       =  [s_PhysicalPostalCode]	-- Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S"
,[PhysicalPostalCode]       =  CASE
									WHEN	LEN ( [s_PhysicalPostalCode] )		>	0		THEN		[s_PhysicalPostalCode]
									WHEN	LEN ( [ps_PhysicalPostalCode] )		>	0		THEN		[ps_PhysicalPostalCode]
									WHEN	LEN ( [P_PhysicalPostalCode] )		>	0		THEN		[P_PhysicalPostalCode]

									WHEN	LEN ( [a_PhysicalPostalCode] )		>	0		THEN		[a_PhysicalPostalCode]
									ELSE	''
								END

,[Latitude]                 =  CASE		-- Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S"
									WHEN [s_Latitude]		!= 0.0		THEN  [s_Latitude]	
									WHEN [ps_Latitude]		!= 0.0		THEN  [ps_Latitude]         
									WHEN [P_Latitude]		!= 0.0		THEN  [P_Latitude]  

									WHEN [a_Latitude]		!= 0.0		THEN  [a_Latitude]
									ELSE 0.0    
							   END
,[Longitude]                =  CASE		-- Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S"
									WHEN [s_Longitude]		!= 0.0		THEN	[s_Longitude] 
									WHEN [ps_Longitude]		!= 0.0		THEN	[ps_Longitude]  
									WHEN [P_Longitude]		!= 0.0		THEN	[P_Longitude]  
 
									WHEN [a_Longitude]		!= 0.0		THEN	[a_Longitude]
									ELSE 0.0    
							   END



-- end try (end testing)

-- iCarol 
,[HoursOfOperation]         =  CASE		-- Biz-Logic: Look up Chain sequence, "P@S" -> "Program" -> "Site" -> "Agency"
									WHEN  LEN ([ps_HoursOfOperation])   > 0		THEN  [ps_HoursOfOperation]         
									WHEN  LEN ([P_HoursOfOperation])	> 0		THEN  [P_HoursOfOperation]  
									WHEN  LEN ([s_HoursOfOperation])    > 0		THEN  [s_HoursOfOperation]  
									WHEN  LEN ([a_HoursOfOperation])	> 0		THEN  [a_HoursOfOperation]
									ELSE  ''
							   END
,[Phone]                    =  CASE		-- Biz-Logic: Look up Chain sequence, "P@S" -> "Program" -> "Site" -> "Agency" plus "Phone priority list"
									WHEN  LEN ([ps_Phone])		> 0		THEN  [ps_Phone]         
									WHEN  LEN ([P_Phone])		> 0		THEN  [P_Phone]  
									WHEN  LEN ([s_Phone])		> 0		THEN  [s_Phone]  
									WHEN  LEN ([a_Phone])		> 0		THEN  [a_Phone]
									ELSE  ''    
							   END
,[WebsiteAddress]           =  CASE		-- Biz-Logic: Look up Chain sequence, "P@S" -> "Program" -> "Site" -> "Agency"  
									WHEN  LEN ([ps_WebsiteAddress])		> 0		THEN  [ps_WebsiteAddress]         
									WHEN  LEN ([P_WebsiteAddress])		> 0		THEN  [P_WebsiteAddress]  
									WHEN  LEN ([s_WebsiteAddress])		> 0		THEN  [s_WebsiteAddress]  
									WHEN  LEN ([a_WebsiteAddress])		> 0		THEN  [a_WebsiteAddress]
									ELSE  ''
							   END
,[Eligibility]              =  CASE		-- Biz-Logic: Look up Chain sequence, "Program" --> "P@S"  ; Never Agency or Site 
									WHEN  LEN ([P_Eligibility])		> 0    THEN  [P_Eligibility] 
									WHEN  LEN ([ps_Eligibility])    > 0    THEN  [ps_Eligibility]  

									WHEN  LEN ([s_Eligibility])     > 0    THEN  [s_Eligibility]  
									WHEN  LEN ([A_Eligibility])		> 0    THEN  [A_Eligibility] 
									ELSE  ''    
							   END
-- if error send Parent Agency ID to Kristen
,[DisabilitiesAccess]       =  CASE		-- Biz-Logic: Look up Chain sequence, "P@S" -> "Program" -> "Site" -> "Agency"  ;      then error and send Parent Agency ID to Kristen
									WHEN  LEN ([ps_DisabilitiesAccess])		> 0		THEN  [ps_DisabilitiesAccess]         
									WHEN  LEN ([P_DisabilitiesAccess])		> 0		THEN  [P_DisabilitiesAccess]  
									WHEN  LEN ([s_DisabilitiesAccess])		> 0		THEN  [s_DisabilitiesAccess]  
									WHEN  LEN ([a_DisabilitiesAccess])		> 0		THEN  [a_DisabilitiesAccess]
									ELSE  ''    
							   END
,[FeeStructureSource]       =  CASE		-- Biz-Logic: Look up Chain sequence,  "Program" -> "P@S"  ;   Never use Agency or Site       
									WHEN  LEN ([P_FeeStructureSource])		> 0    THEN  [P_FeeStructureSource]  
									WHEN  LEN ([ps_FeeStructureSource])		> 0    THEN  [ps_FeeStructureSource]  

									WHEN  LEN ([S_FeeStructureSource])		> 0    THEN  [S_FeeStructureSource] 
									WHEN  LEN ([A_FeeStructureSource])		> 0    THEN  [A_FeeStructureSource] 
									ELSE  ''    
							   END
,[ApplicationProcess]       =  CASE 	-- Biz-Logic: Look up Chain sequence,  "Program" -> "P@S"  ;   Never use Agency or Site
									WHEN  LEN ([P_ApplicationProcess])		> 0    THEN  [P_ApplicationProcess]        
									WHEN  LEN ([ps_ApplicationProcess])		> 0    THEN  [ps_ApplicationProcess]  
 
									WHEN  LEN ([s_ApplicationProcess])		> 0    THEN  [s_ApplicationProcess]  
									WHEN  LEN ([A_ApplicationProcess])		> 0    THEN  [A_ApplicationProcess] 
									ELSE  ''    
							   END
,[DocumentsRequired]        =  CASE -- Biz-Logic: Look up Chain sequence,  "Program" -> "P@S"  ;   Never use Agency or Site
									WHEN  LEN ([P_DocumentsRequired])		> 0    THEN  [P_DocumentsRequired]         
									WHEN  LEN ([ps_DocumentsRequired])		> 0    THEN  [ps_DocumentsRequired]  

									WHEN  LEN ([S_DocumentsRequired])		> 0    THEN  [S_DocumentsRequired]         
									WHEN  LEN ([A_DocumentsRequired])		> 0    THEN  [A_DocumentsRequired]  
									ELSE  ''    
							   END
-- if error send AgencyResourceNums to Kristen
,[LanguagesOfferedList]     =  CASE -- Biz-Logic: Look up Chain sequence,  "Program" -> "P@S"  ;   Never use Agency or Site;  if error send AgencyResourceNums to Kristen
									WHEN  LEN ([P_LanguagesOfferedList])	> 0    THEN  [P_LanguagesOfferedList]       
									WHEN  LEN ([ps_LanguagesOfferedList])	> 0    THEN  [ps_LanguagesOfferedList]  
  
									WHEN  LEN ([s_LanguagesOfferedList])	> 0    THEN  [s_LanguagesOfferedList]  
									WHEN  LEN ([A_LanguagesOfferedList])	> 0    THEN  [A_LanguagesOfferedList]    
									ELSE  ''    
							   END
,[LanguageOfRecord]			
--  iCarol: Hours      
,[WorkHours]                =  CASE		-- Biz-Logic: Look up Chain sequence, "P@S" -> "Program" -> "Site" -> "Agency"  ;
									WHEN  LEN ([ps_Hours])		> 0			THEN	[ps_Hours]         
									WHEN  LEN ([P_Hours])		> 0			THEN	[P_Hours]  
									WHEN  LEN ([s_Hours])		> 0			THEN	[s_Hours]  
									WHEN  LEN ([a_Hours])		> 0			THEN	[a_Hours]
									ELSE  ''    
							   END

,[CustomEligibilitybyAge]   =  CASE 	-- Biz-Logic: Look up Chain sequence, "Program" -> "P@S" ;
									WHEN  LEN ([P_CustomEligibilitybyAge])		> 0    THEN  [P_CustomEligibilitybyAge] 
									WHEN  LEN ([ps_CustomEligibilitybyAge])		> 0    THEN  [ps_CustomEligibilitybyAge]  
   
									WHEN  LEN ([s_CustomEligibilitybyAge])		> 0    THEN  [s_CustomEligibilitybyAge]  
									WHEN  LEN ([A_CustomEligibilitybyAge])		> 0    THEN  [A_CustomEligibilitybyAge]    
									ELSE  ''    
							   END
--then error and send AgencyResourceNUM to Kristen
,[CoverageArea]             =  CASE 	-- Biz-Logic: Look up Chain sequence, "P@S" -> "Program" -> "Site" -> "Agency"  ;  if error, then error and send AgencyResourceNUM to Kristen
									WHEN  LEN (ps_CoverageArea)		> 0		THEN	ps_CoverageArea          
							   		WHEN  LEN (P_CoverageArea)		> 0		THEN	P_CoverageArea  
									WHEN  LEN (s_CoverageArea)		> 0		THEN	s_CoverageArea 
									WHEN  LEN (a_CoverageArea)		> 0		THEN	a_CoverageArea 
							   	ELSE  ''    
							   END
-- if error, then error and send AgencyResourceNUM to Kristen 
,[Coverage]					=  CASE 	-- Biz-Logic: Look up Chain sequence, "P@S" -> "Program" -> "Site" -> "Agency"  ;  if error, then error and send AgencyResourceNUM to Kristen 
									WHEN	LEN (ps_Coverage)   > 0    THEN  [ps_Coverage]         
							   		WHEN	LEN (P_Coverage)	> 0    THEN  [P_Coverage]  
									WHEN	LEN (s_Coverage)    > 0    THEN  s_Coverage 
									WHEN	LEN (a_Coverage)    > 0    THEN  a_Coverage 
							   	ELSE  ''    
							   END

,[NormalWaitTime]			=  CASE		--  Biz-Logic: Look up Chain sequence, "Program" -> "P@S" ;    
									WHEN  LEN ([P_NormalWaitTime])	> 0    THEN  [P_NormalWaitTime]      
							   		WHEN  LEN (ps_NormalWaitTime)   > 0    THEN  ps_NormalWaitTime  

							   		WHEN  LEN (s_NormalWaitTime)   > 0    THEN  s_NormalWaitTime  
									WHEN  LEN ([A_NormalWaitTime])	> 0    THEN  [A_NormalWaitTime] 
							   	ELSE  ''    
							   END
				
,[changedDate]				=	CASE
							   		WHEN  LEN (ps_changedDate)   > 0    THEN  ps_changedDate  
									WHEN  LEN ([P_changedDate])	> 0    THEN  [P_changedDate] 
							   		WHEN  LEN (s_changedDate)   > 0    THEN  s_changedDate  
									WHEN  LEN ([A_changedDate])	> 0    THEN  [A_changedDate] 
								END
,[createdDate]				=	 GETDATE()

INTO #RAM_Resource_RAW
FROM RAM_CTE  
ORDER BY PS_ETLLoadID;



MERGE INTO RAMResource AS T
USING (SELECT distinct
nr.*
,SI.SubcategoryID
,TS.TopCategoryID
,IT.InterestTaxonomyDelivery
  FROM #RAM_Resource_RAW AS nr 
   join [dbo].[InterestTaxonomyID_ETLLoadID] AS IE on nr.ETLLoadID = IE.etlloadid
   join InterestTaxonomy AS IT on IE.interesttaxonomyid = IT.InterestTaxonomyID
   join [dbo].[SubcategoryID_InterestTaxonomyID] AS SI on si.InterestTaxonomyID = it.InterestTaxonomyID
   join [dbo].[TopCategoryID_SubCategoryID] AS TS on ts.SubCategoryID = SI.SubCategoryID 
   WHERE IT.Active = 1 AND SI.Active = 1 AND TS.Active = 1) AS S

On (T.ETLLoadID = S.ETLLoadID and S.subcategoryID = T.subcategoryID AND S.TopCategoryID = T.TopCategoryID)

WHEN NOT MATCHED BY TARGET THEN
INSERT (
    ETLLoadID  ,
	ResourceAgencyNum  ,
	Map    ,
	SubCategoryID ,
	TOPCategoryID ,
	PublicName ,
	AgencyDescription  ,
	TaxonomyLevelNameID ,
	ParentAgencyNum ,
	PhysicalAddress ,
	PhysicalCityID ,
	PhysicalProvinceID ,
	PhysicalCountry ,
	PhysicalPostalCode ,
	PhysicalAddressIsPrivate ,
	Latitude  ,
	Longitude  ,
	HoursOfOperation ,
	Phone ,
	WebsiteAddress ,
	Eligibility ,
	DisabilitiesAccess ,
	FeeStructureSource ,
	ApplicationProcess ,
	DocumentsRequired ,
	LanguagesOfferedList ,
	LanguageOfRecord ,
	WorkHours ,
	CustomEligibilitybyAge ,
	CoverageArea ,
	Coverage ,
	NormalWaitTime ,
	changedDate
)

VALUES
(
S.ETLLoadID, S.ResourceAgencyNum  

--CASE S.TopCategoryID
--			WHEN 1 THEN 1      ----  1: Web&Phone
--			WHEN 2 THEN 2      ----  2: Shelter resource
--			ELSE 9             ----  9: Map resource 
--END
, S.InterestTaxonomyDelivery
, S.SubCategoryID
, S.TopCategoryID
, RTRIM(LTRIM(ISNULL(S.PublicName,''))) 
, RTRIM(LTRIM(ISNULL(S.AgencyDescription,'')))
, S.TaxonomyLevelNameID 
, RTRIM(LTRIM(ISNULL(S.ParentAgencyNum,'')))
, RTRIM(LTRIM(ISNULL(S.PhysicalAddress ,'')))
, ISNULL(S.PhysicalCityID,0)
, ISNULL(S.PhysicalProvinceID,99)
, RTRIM(LTRIM(ISNULL(S.PhysicalCountry,'Canada')))
, RTRIM(LTRIM(ISNULL(S.PhysicalPostalCode,'')))
, RTRIM(LTRIM(ISNULL(S.PhysicalAddressIsPrivate,'')))
, ISNULL(S.Latitude,0.0)
, ISNULL(S.Longitude,0.0)
, RTRIM(LTRIM(ISNULL(S.HoursOfOperation,'')))
, RTRIM(LTRIM(ISNULL(S.Phone,'')))
, RTRIM(LTRIM(ISNULL(S.WebsiteAddress,'')))
, RTRIM(LTRIM(ISNULL(S.Eligibility,'')))
, RTRIM(LTRIM(ISNULL(S.DisabilitiesAccess,'')))
, RTRIM(LTRIM(ISNULL(S.FeeStructureSource,'')))
, RTRIM(LTRIM(ISNULL(S.ApplicationProcess,'')))
, RTRIM(LTRIM(ISNULL(S.DocumentsRequired,'')))
, RTRIM(LTRIM(ISNULL(S.LanguagesOfferedList,'')))
, RTRIM(LTRIM(ISNULL(S.LanguageOfRecord,'en')))
, RTRIM(LTRIM(ISNULL(S.WorkHours,'')))
, RTRIM(LTRIM(ISNULL(S.CustomEligibilitybyAge,'')))
, RTRIM(LTRIM(ISNULL(S.CoverageArea  ,'')))
, RTRIM(LTRIM(ISNULL(S.Coverage ,'')))
, RTRIM(LTRIM(ISNULL(S.NormalWaitTime ,'')))
, GETDATE()
);
END
