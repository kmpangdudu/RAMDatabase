--
-- 2020-01-23 changing:
-- 第一要点：引入TaxonomyLevelName作为一个判定选Program (P) 还是Program at Site (PS) 的信息来构建最后RAMResource列的条件
-- 当iCarol原记录是 TaxonomyLevelName = 3 ，即 Program ; 用 program --> program at site --> site --> Agency 的顺序来构建RAMResource
-- 当iCarol原记录是 TaxonomyLevelName = 4 ，即 Program at site ; 用 program at site--> program --> site --> Agency 的顺序来构建RAMResource
-- 这样就解决了记录信息相同，但是又可能不是同一条记录的情况 
-- 
-- 2020-01-23 adding new stuff
-- 第二要点：在存储过程最后，加上一段逻辑： 
-- 如果RAMResource记录是标识为 “BOTH” ； 就从表RAMResource 中删除那些，相同[ResourceAgencyNum]号，又配和标注为“mapped”或“LIST” 的那些记录
-- 这样就解决了同一个记录出现在 map = BOTH ; 又再次出现再 Map= Mapped 或 Map = List 的情况

-- 以上修改的存储过程，要替换掉 SSIS 中的Execute SQL Task （ Exe_SQL_Build_SP_Construct_RAMResource ）

CREATE PROCEDURE [dbo].[Proc_Construct_RAMResource]
AS
BEGIN
 -- SET NOCOUNT ON added to prevent extra result sets from
 -- interfering with SELECT statements.
 SET NOCOUNT ON;

 TRUNCATE TABLE RAMResource;

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
,[PublicName]=  
	CASE when [TaxonomyLevelNameID] =3 then 
			CASE 
				WHEN LEN([p_PublicName]) > 0  THEN [p_PublicName]
				WHEN LEN([PS_PublicName]) > 0  THEN [PS_publicname]
				ELSE ''
			END
		when [TaxonomyLevelNameID] =4 then 
			CASE 
				WHEN LEN([PS_PublicName]) > 0  THEN [PS_publicname]
				WHEN LEN([p_PublicName]) > 0  THEN [p_PublicName]

				ELSE ''
			END
	end 
,[AgencyDescription]=  
	case 
		when [TaxonomyLevelNameID] =3 then 
				CASE 
					WHEN LEN([P_AgencyDescription])  > 0  THEN [P_AgencyDescription] 
					WHEN LEN([ps_AgencyDescription])  > 0  THEN [ps_AgencyDescription] 
					ELSE ''
				END
		when [TaxonomyLevelNameID] =4 then 
			CASE 
				WHEN LEN([ps_AgencyDescription])  > 0  THEN [ps_AgencyDescription] 
				WHEN LEN([P_AgencyDescription])  > 0  THEN [P_AgencyDescription] 
				ELSE ''
			END
	end
,[TaxonomyLevelNameID]      
,[ParentAgencyNum]            
,[PhysicalAddressIsPrivate] = 
	CASE 
		when [TaxonomyLevelNameID] = 3 then 
			CASE
				WHEN LEN([P_PhysicalAddressIsPrivate])  > 0  THEN [P_PhysicalAddressIsPrivate] 
				WHEN LEN([ps_PhysicalAddressIsPrivate])  > 0  THEN [ps_PhysicalAddressIsPrivate] 
				ELSE ''
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE
				WHEN LEN([ps_PhysicalAddressIsPrivate])  > 0  THEN [ps_PhysicalAddressIsPrivate] 
				WHEN LEN([P_PhysicalAddressIsPrivate])  > 0  THEN [P_PhysicalAddressIsPrivate] 
				ELSE ''
			END
	END

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Nov.21, 2016 Changing Role by WC. Because too many no city records come, Try to ignore  "Biz-Logic: Physical Address1 use "Site" only; Never use "Agency", "Program" or "P@S""   
-- Try  [PhysicalCityID] and [PhysicalProvinceID],  [PhysicalCountry],   [PhysicalPostalCode],  [s_PhysicalCountry]
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- begin try (begin testing)
,[PhysicalAddress]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE 
				WHEN  LEN ( [p_PhysicalAddress] ) > 0  THEN  [p_PhysicalAddress]
				WHEN  LEN ( [Ps_PhysicalAddress] ) > 0  THEN  [Ps_PhysicalAddress]
				WHEN  LEN ( [S_PhysicalAddress] ) > 0  THEN  [S_PhysicalAddress]
				WHEN  LEN ( [a_PhysicalAddress] ) > 0  THEN  [a_PhysicalAddress]
				ELSE ''
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE 
				WHEN  LEN ( [Ps_PhysicalAddress] ) > 0  THEN  [Ps_PhysicalAddress]
				WHEN  LEN ( [p_PhysicalAddress] ) > 0  THEN  [p_PhysicalAddress]
				WHEN  LEN ( [S_PhysicalAddress] ) > 0  THEN  [S_PhysicalAddress]
				WHEN  LEN ( [a_PhysicalAddress] ) > 0  THEN  [a_PhysicalAddress]
				ELSE ''
			END
	end 
,[PhysicalCityID]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE 
				WHEN [P_PhysicalCityID]  != 0  THEN  [P_PhysicalCityID]
				WHEN [ps_PhysicalCityID]  != 0  THEN  [ps_PhysicalCityID]
				WHEN [s_PhysicalCityID]  != 0  THEN  [s_PhysicalCityID]
				WHEN [a_PhysicalCityID]  != 0  THEN  [a_PhysicalCityID]
				ELSE 0
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE 
				WHEN [ps_PhysicalCityID]  != 0  THEN  [ps_PhysicalCityID]
				WHEN [P_PhysicalCityID]  != 0  THEN  [P_PhysicalCityID]
				WHEN [s_PhysicalCityID]  != 0  THEN  [s_PhysicalCityID]
				WHEN [a_PhysicalCityID]  != 0  THEN  [a_PhysicalCityID]
				ELSE 0
			END
	end 
,[PhysicalProvinceID]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE
				WHEN [P_PhysicalProvinceID]  != 0  THEN  [P_PhysicalProvinceID]
				WHEN [ps_PhysicalProvinceID]  != 0  THEN  [ps_PhysicalProvinceID]
				WHEN [s_PhysicalProvinceID]  != 0  THEN  [s_PhysicalProvinceID]
				WHEN [a_PhysicalProvinceID]  != 0  THEN  [a_PhysicalProvinceID]
				ELSE 99
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE
				WHEN [ps_PhysicalProvinceID]  != 0  THEN  [ps_PhysicalProvinceID]
				WHEN [P_PhysicalProvinceID]  != 0  THEN  [P_PhysicalProvinceID]
				WHEN [s_PhysicalProvinceID]  != 0  THEN  [s_PhysicalProvinceID]
				WHEN [a_PhysicalProvinceID]  != 0  THEN  [a_PhysicalProvinceID]
				ELSE 99
			END
	end
,[PhysicalCountry]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE
				WHEN LEN ( [P_PhysicalCountry] )  > 0  THEN  [P_PhysicalCountry]
				WHEN LEN ( [ps_PhysicalCountry] ) > 0  THEN  [ps_PhysicalCountry]
				WHEN LEN ( [s_PhysicalCountry] )  > 0  THEN  [s_PhysicalCountry]
				WHEN LEN ( [a_PhysicalCountry] )  > 0  THEN  [a_PhysicalCountry]
				ELSE ''
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE
				WHEN LEN ( [s_PhysicalCountry] )  > 0  THEN  [s_PhysicalCountry]
				WHEN LEN ( [ps_PhysicalCountry] ) > 0  THEN  [ps_PhysicalCountry]
				WHEN LEN ( [P_PhysicalCountry] )  > 0  THEN  [P_PhysicalCountry]
				WHEN LEN ( [a_PhysicalCountry] )  > 0  THEN  [a_PhysicalCountry]
				ELSE ''
			END
	end
,[PhysicalPostalCode]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE
				WHEN LEN ( [P_PhysicalPostalCode] )  > 0  THEN  [P_PhysicalPostalCode]
				WHEN LEN ( [ps_PhysicalPostalCode] )  > 0  THEN  [ps_PhysicalPostalCode]
				WHEN LEN ( [s_PhysicalPostalCode] )  > 0  THEN  [s_PhysicalPostalCode]
				WHEN LEN ( [a_PhysicalPostalCode] )  > 0  THEN  [a_PhysicalPostalCode]
				ELSE ''
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE
				WHEN LEN ( [ps_PhysicalPostalCode] )  > 0  THEN  [ps_PhysicalPostalCode]
				WHEN LEN ( [P_PhysicalPostalCode] )  > 0  THEN  [P_PhysicalPostalCode]
				WHEN LEN ( [s_PhysicalPostalCode] )  > 0  THEN  [s_PhysicalPostalCode]
				WHEN LEN ( [a_PhysicalPostalCode] )  > 0  THEN  [a_PhysicalPostalCode]
				ELSE ''
			END
	end
,[Latitude]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE
				WHEN [P_Latitude]  != 0.0  THEN  [P_Latitude]  
				WHEN [ps_Latitude]  != 0.0  THEN  [ps_Latitude]   
				WHEN [s_Latitude]  != 0.0  THEN  [s_Latitude] 							       
				WHEN [a_Latitude]  != 0.0  THEN  [a_Latitude]
				ELSE 0.0    
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE
				WHEN [ps_Latitude]  != 0.0  THEN  [ps_Latitude]         
				WHEN [P_Latitude]  != 0.0  THEN  [P_Latitude]  
				WHEN [s_Latitude]  != 0.0  THEN  [s_Latitude] 
				WHEN [a_Latitude]  != 0.0  THEN  [a_Latitude]
				ELSE 0.0    
			END
	end

,[Longitude]                = 
	case 
		when  [TaxonomyLevelNameID] = 3 then 
			CASE
					WHEN [P_Longitude]  != 0.0  THEN [P_Longitude]  
					WHEN [ps_Longitude]  != 0.0  THEN [ps_Longitude]  
					WHEN [s_Longitude]  != 0.0  THEN [s_Longitude] 
					WHEN [a_Longitude]  != 0.0  THEN [a_Longitude]
					ELSE 0.0    
			END
		when  [TaxonomyLevelNameID] = 4 then 
			CASE
					WHEN [ps_Longitude]  != 0.0  THEN [ps_Longitude]  
					WHEN [P_Longitude]  != 0.0  THEN [P_Longitude]  
					WHEN [s_Longitude]  != 0.0  THEN [s_Longitude] 
					WHEN [a_Longitude]  != 0.0  THEN [a_Longitude]
					ELSE 0.0    
			END
	end 
-- end try (end testing)

-- iCarol 
,[HoursOfOperation]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE
					WHEN  LEN ([P_HoursOfOperation]) > 0  THEN  [P_HoursOfOperation]  
					WHEN  LEN ([ps_HoursOfOperation])   > 0  THEN  [ps_HoursOfOperation]         
					WHEN  LEN ([s_HoursOfOperation])    > 0  THEN  [s_HoursOfOperation]  
					WHEN  LEN ([a_HoursOfOperation]) > 0  THEN  [a_HoursOfOperation]
					ELSE  ''
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE
					WHEN  LEN ([ps_HoursOfOperation])   > 0  THEN  [ps_HoursOfOperation]         
					WHEN  LEN ([P_HoursOfOperation]) > 0  THEN  [P_HoursOfOperation]  
					WHEN  LEN ([s_HoursOfOperation])    > 0  THEN  [s_HoursOfOperation]  
					WHEN  LEN ([a_HoursOfOperation]) > 0  THEN  [a_HoursOfOperation]
					ELSE  ''
			END
	end
,[Phone]=  
	case 
		when [TaxonomyLevelNameID] = 3 then 
			CASE 
					WHEN  LEN ([P_Phone])  > 0  THEN  [P_Phone]  			 
					WHEN  LEN ([ps_Phone])  > 0  THEN  [ps_Phone]         
					WHEN  LEN ([s_Phone])  > 0  THEN  [s_Phone]  
					WHEN  LEN ([a_Phone])  > 0  THEN  [a_Phone]
					ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then 
			CASE 
					WHEN  LEN ([ps_Phone])  > 0  THEN  [ps_Phone]         
					WHEN  LEN ([P_Phone])  > 0  THEN  [P_Phone]  
					WHEN  LEN ([s_Phone])  > 0  THEN  [s_Phone]  
					WHEN  LEN ([a_Phone])  > 0  THEN  [a_Phone]
					ELSE  ''    
			END
	end
,[WebsiteAddress]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE 
					WHEN  LEN ([P_WebsiteAddress])  > 0  THEN  [P_WebsiteAddress]  
					WHEN  LEN ([ps_WebsiteAddress])  > 0  THEN  [ps_WebsiteAddress]         
					WHEN  LEN ([s_WebsiteAddress])  > 0  THEN  [s_WebsiteAddress]  
					WHEN  LEN ([a_WebsiteAddress])  > 0  THEN  [a_WebsiteAddress]
					ELSE  ''
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE 
					WHEN  LEN ([ps_WebsiteAddress])  > 0  THEN  [ps_WebsiteAddress]         
					WHEN  LEN ([P_WebsiteAddress])  > 0  THEN  [P_WebsiteAddress]  
					WHEN  LEN ([s_WebsiteAddress])  > 0  THEN  [s_WebsiteAddress]  
					WHEN  LEN ([a_WebsiteAddress])  > 0  THEN  [a_WebsiteAddress]
					ELSE  ''
			END
	end

,[Eligibility]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
				CASE 
					WHEN  LEN ([P_Eligibility])  > 0    THEN  [P_Eligibility] 
					WHEN  LEN ([ps_Eligibility])    > 0    THEN  [ps_Eligibility]  
					WHEN  LEN ([s_Eligibility])     > 0    THEN  [s_Eligibility]  
					WHEN  LEN ([A_Eligibility])  > 0    THEN  [A_Eligibility] 
					ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE 
				WHEN  LEN ([ps_Eligibility])    > 0    THEN  [ps_Eligibility]  
				WHEN  LEN ([P_Eligibility])  > 0    THEN  [P_Eligibility] 
				WHEN  LEN ([s_Eligibility])     > 0    THEN  [s_Eligibility]  
				WHEN  LEN ([A_Eligibility])  > 0    THEN  [A_Eligibility] 
				ELSE  ''    
			END
	end 
,[DisabilitiesAccess]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE
					WHEN  LEN ([P_DisabilitiesAccess])  > 0  THEN  [P_DisabilitiesAccess] 
					WHEN  LEN ([ps_DisabilitiesAccess])  > 0  THEN  [ps_DisabilitiesAccess]          
					WHEN  LEN ([s_DisabilitiesAccess])  > 0  THEN  [s_DisabilitiesAccess]  
					WHEN  LEN ([a_DisabilitiesAccess])  > 0  THEN  [a_DisabilitiesAccess]
					ELSE  ''    
				END
		when [TaxonomyLevelNameID] = 4 then
			CASE 
					WHEN  LEN ([ps_DisabilitiesAccess])  > 0  THEN  [ps_DisabilitiesAccess]         
					WHEN  LEN ([P_DisabilitiesAccess])  > 0  THEN  [P_DisabilitiesAccess]  
					WHEN  LEN ([s_DisabilitiesAccess])  > 0  THEN  [s_DisabilitiesAccess]  
					WHEN  LEN ([a_DisabilitiesAccess])  > 0  THEN  [a_DisabilitiesAccess]
					ELSE  ''    
				END
	end
,[FeeStructureSource]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE  
					WHEN  LEN ([P_FeeStructureSource])  > 0    THEN  [P_FeeStructureSource]  
					WHEN  LEN ([ps_FeeStructureSource])  > 0    THEN  [ps_FeeStructureSource]  
					WHEN  LEN ([S_FeeStructureSource])  > 0    THEN  [S_FeeStructureSource] 
					WHEN  LEN ([A_FeeStructureSource])  > 0    THEN  [A_FeeStructureSource] 
					ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE    
					WHEN  LEN ([ps_FeeStructureSource])  > 0    THEN  [ps_FeeStructureSource]  
					WHEN  LEN ([P_FeeStructureSource])  > 0    THEN  [P_FeeStructureSource]  
					WHEN  LEN ([S_FeeStructureSource])  > 0    THEN  [S_FeeStructureSource] 
					WHEN  LEN ([A_FeeStructureSource])  > 0    THEN  [A_FeeStructureSource] 
					ELSE  ''    
			END
	end
,[ApplicationProcess]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE
				WHEN  LEN ([P_ApplicationProcess])  > 0    THEN  [P_ApplicationProcess]        
				WHEN  LEN ([ps_ApplicationProcess])  > 0    THEN  [ps_ApplicationProcess]  
				WHEN  LEN ([s_ApplicationProcess])  > 0    THEN  [s_ApplicationProcess]  
				WHEN  LEN ([A_ApplicationProcess])  > 0    THEN  [A_ApplicationProcess] 
				ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE
				WHEN  LEN ([ps_ApplicationProcess])  > 0    THEN  [ps_ApplicationProcess]           
				WHEN  LEN ([P_ApplicationProcess])  > 0    THEN  [P_ApplicationProcess]        
				WHEN  LEN ([s_ApplicationProcess])  > 0    THEN  [s_ApplicationProcess]  
				WHEN  LEN ([A_ApplicationProcess])  > 0    THEN  [A_ApplicationProcess] 
				ELSE  ''    
			END
	end
,[DocumentsRequired]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE
					WHEN  LEN ([P_DocumentsRequired])  > 0    THEN  [P_DocumentsRequired]         
					WHEN  LEN ([ps_DocumentsRequired])  > 0    THEN  [ps_DocumentsRequired]  
					WHEN  LEN ([S_DocumentsRequired])  > 0    THEN  [S_DocumentsRequired]         
					WHEN  LEN ([A_DocumentsRequired])  > 0    THEN  [A_DocumentsRequired]  
					ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE
					WHEN  LEN ([ps_DocumentsRequired])  > 0    THEN  [ps_DocumentsRequired]          
					WHEN  LEN ([P_DocumentsRequired])  > 0    THEN  [P_DocumentsRequired]         
					WHEN  LEN ([S_DocumentsRequired])  > 0    THEN  [S_DocumentsRequired]         
					WHEN  LEN ([A_DocumentsRequired])  > 0    THEN  [A_DocumentsRequired]  
					ELSE  ''    
			END
	end
,[LanguagesOfferedList]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE
				WHEN  LEN ([P_LanguagesOfferedList]) > 0    THEN  [P_LanguagesOfferedList]       
				WHEN  LEN ([ps_LanguagesOfferedList]) > 0    THEN  [ps_LanguagesOfferedList]  
				WHEN  LEN ([s_LanguagesOfferedList]) > 0    THEN  [s_LanguagesOfferedList]  
				WHEN  LEN ([A_LanguagesOfferedList]) > 0    THEN  [A_LanguagesOfferedList]    
				ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE
				WHEN  LEN ([ps_LanguagesOfferedList]) > 0    THEN  [ps_LanguagesOfferedList]  		
				WHEN  LEN ([P_LanguagesOfferedList]) > 0    THEN  [P_LanguagesOfferedList]       
				WHEN  LEN ([s_LanguagesOfferedList]) > 0    THEN  [s_LanguagesOfferedList]  
				WHEN  LEN ([A_LanguagesOfferedList]) > 0    THEN  [A_LanguagesOfferedList]    
				ELSE  ''    
			END
	end
,[LanguageOfRecord]  
--  iCarol: Hours      
,[WorkHours]=  
	case
		when [TaxonomyLevelNameID] = 3 then
			CASE
				WHEN  LEN ([P_Hours])  > 0   THEN [P_Hours]  
				WHEN  LEN ([ps_Hours])  > 0   THEN [ps_Hours]         
				WHEN  LEN ([s_Hours])  > 0   THEN [s_Hours]  
				WHEN  LEN ([a_Hours])  > 0   THEN [a_Hours]
				ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE
				WHEN  LEN ([ps_Hours])  > 0   THEN [ps_Hours]         
				WHEN  LEN ([P_Hours])  > 0   THEN [P_Hours]  
				WHEN  LEN ([s_Hours])  > 0   THEN [s_Hours]  
				WHEN  LEN ([a_Hours])  > 0   THEN [a_Hours]
				ELSE  ''    
			END
	end
,[CustomEligibilitybyAge]=  
	case 
		when  [TaxonomyLevelNameID] = 3 then
			CASE
				WHEN  LEN ([P_CustomEligibilitybyAge])  > 0    THEN  [P_CustomEligibilitybyAge] 
				WHEN  LEN ([ps_CustomEligibilitybyAge])  > 0    THEN  [ps_CustomEligibilitybyAge]  
				WHEN  LEN ([s_CustomEligibilitybyAge])  > 0    THEN  [s_CustomEligibilitybyAge]  
				WHEN  LEN ([A_CustomEligibilitybyAge])  > 0    THEN  [A_CustomEligibilitybyAge]    
				ELSE  ''    
			END
		when  [TaxonomyLevelNameID] = 4 then
			CASE
				WHEN  LEN ([ps_CustomEligibilitybyAge])  > 0    THEN  [ps_CustomEligibilitybyAge]  
				WHEN  LEN ([P_CustomEligibilitybyAge])  > 0    THEN  [P_CustomEligibilitybyAge] 
				WHEN  LEN ([s_CustomEligibilitybyAge])  > 0    THEN  [s_CustomEligibilitybyAge]  
				WHEN  LEN ([A_CustomEligibilitybyAge])  > 0    THEN  [A_CustomEligibilitybyAge]    
				ELSE  ''    
			END
	end
,[CoverageArea]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE
				WHEN  LEN (P_CoverageArea)  > 0  THEN P_CoverageArea      
				WHEN  LEN (ps_CoverageArea)  > 0  THEN ps_CoverageArea          
				WHEN  LEN (s_CoverageArea)  > 0  THEN s_CoverageArea 
				WHEN  LEN (a_CoverageArea)  > 0  THEN a_CoverageArea 
				ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE
				WHEN  LEN (ps_CoverageArea)  > 0  THEN ps_CoverageArea          
				WHEN  LEN (P_CoverageArea)  > 0  THEN P_CoverageArea  
				WHEN  LEN (s_CoverageArea)  > 0  THEN s_CoverageArea 
				WHEN  LEN (a_CoverageArea)  > 0  THEN a_CoverageArea 
				ELSE  ''    
			END
	end
,[Coverage]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE
				WHEN LEN (P_Coverage) > 0    THEN  [P_Coverage]  		
				WHEN LEN (ps_Coverage)   > 0    THEN  [ps_Coverage]         
				WHEN LEN (s_Coverage)    > 0    THEN  s_Coverage 
				WHEN LEN (a_Coverage)    > 0    THEN  a_Coverage 
				ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE
				WHEN LEN (ps_Coverage)   > 0    THEN  [ps_Coverage]         
				WHEN LEN (P_Coverage) > 0    THEN  [P_Coverage]  
				WHEN LEN (s_Coverage)    > 0    THEN  s_Coverage 
				WHEN LEN (a_Coverage)    > 0    THEN  a_Coverage 
				ELSE  ''    
			END
	end
,[NormalWaitTime]=  
	case 
		when [TaxonomyLevelNameID] = 3 then
			CASE   
				WHEN  LEN ([P_NormalWaitTime]) > 0    THEN  [P_NormalWaitTime]      
				WHEN  LEN (ps_NormalWaitTime)   > 0    THEN  ps_NormalWaitTime  
				WHEN  LEN (s_NormalWaitTime)   > 0    THEN  s_NormalWaitTime  
				WHEN  LEN ([A_NormalWaitTime]) > 0    THEN  [A_NormalWaitTime] 
				ELSE  ''    
			END
		when [TaxonomyLevelNameID] = 4 then
			CASE  
				WHEN  LEN (ps_NormalWaitTime)   > 0    THEN  ps_NormalWaitTime  
				WHEN  LEN ([P_NormalWaitTime]) > 0    THEN  [P_NormalWaitTime]      
				WHEN  LEN (s_NormalWaitTime)   > 0    THEN  s_NormalWaitTime  
				WHEN  LEN ([A_NormalWaitTime]) > 0    THEN  [A_NormalWaitTime] 
				ELSE  ''    
			END
	end
,[changedDate]    = 
	case 
		when  [TaxonomyLevelNameID] = 3 then
			CASE
				WHEN  LEN ([P_changedDate]) > 0    THEN  [P_changedDate] 
				WHEN  LEN (ps_changedDate)   > 0    THEN  ps_changedDate  
				WHEN  LEN (s_changedDate)   > 0    THEN  s_changedDate  
				WHEN  LEN ([A_changedDate]) > 0    THEN  [A_changedDate] 
			END
		when  [TaxonomyLevelNameID] = 4 then
			CASE
				WHEN  LEN (ps_changedDate)   > 0    THEN  ps_changedDate  
				WHEN  LEN ([P_changedDate]) > 0    THEN  [P_changedDate] 
				WHEN  LEN (s_changedDate)   > 0    THEN  s_changedDate  
				WHEN  LEN ([A_changedDate]) > 0    THEN  [A_changedDate] 
			END
	end
,[createdDate]    =  GETDATE()

INTO #RAM_Resource_RAW
FROM RAM_CTE  
ORDER BY PS_ETLLoadID;


-- 2020-01-22  majoy changing , comment  map column
MERGE INTO RAMResource AS T
USING (SELECT distinct
--  nr.*
 nr.[ETLLoadID]				
,nr.[ResourceAgencyNum]		
                              -- ,nr.[Map]
,nr.[PublicName]               
,nr.[AgencyDescription]        				
,nr.[TaxonomyLevelNameID]      
,nr.[ParentAgencyNum]          
,nr.[PhysicalAddressIsPrivate]      
,nr.[PhysicalAddress]                
,nr.[PhysicalCityID]             
,nr.[PhysicalProvinceID]             
,nr.[PhysicalCountry]             
,nr.[PhysicalPostalCode]       
,nr.[Latitude]                 				
,nr.[Longitude]                
,nr.[HoursOfOperation]         					
,nr.[Phone]                    			
,nr.[WebsiteAddress]           				
,nr.[Eligibility]              
,nr.[DisabilitiesAccess]       	
,nr.[FeeStructureSource]       	
,nr.[ApplicationProcess]       	
,nr.[DocumentsRequired]        
,nr.[LanguagesOfferedList]     	
,nr.[LanguageOfRecord]			 
,nr.[WorkHours]                
,nr.[CustomEligibilitybyAge]   
,nr.[CoverageArea]             
,nr.[Coverage]					
,nr.[NormalWaitTime]			
,nr.[changedDate]							
---  above columns from  #RAM_Resource_RAW AS nr 
,SI.SubcategoryID
,TS.TopCategoryID
                       ,IT.InterestTaxonomyDelivery

  FROM #RAM_Resource_RAW AS nr 
   join [dbo].[InterestTaxonomyID_ETLLoadID] AS IE on nr.ETLLoadID = IE.etlloadid
   join InterestTaxonomy AS IT on IE.interesttaxonomyid = IT.InterestTaxonomyID
   join [dbo].[SubcategoryID_InterestTaxonomyID] AS SI on si.InterestTaxonomyID = it.InterestTaxonomyID
   join [dbo].[TopCategoryID_SubCategoryID] AS TS on ts.SubCategoryID = SI.SubCategoryID 
   WHERE IT.Active = 1 AND SI.Active = 1 AND TS.Active = 1
   
 ) AS S

On (T.ETLLoadID = S.ETLLoadID and S.subcategoryID = T.subcategoryID AND S.TopCategoryID = T.TopCategoryID AND s.[LanguageOfRecord] = t.[LanguageOfRecord])

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
--   WHEN 1 THEN 1      ----  1: Web&Phone
--   WHEN 2 THEN 2      ----  2: Shelter resource
--   ELSE 9             ----  9: Map resource 
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


--remove list and mapped records from RAMResource , if the record was flagged "BOTH" 
MERGE INTO RAMResource AS T
using (select  resourceagencynum  from RamResource where map= 'BOTH' ) as S
on (T.resourceagencynum = S.resourceagencynum   and T.map <> 'BOTH')
WHEN   MATCHED THEN 
Delete;

END
