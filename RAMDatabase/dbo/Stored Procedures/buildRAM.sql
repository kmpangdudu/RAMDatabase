-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[buildRAM] 
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

TRUNCATE TABLE NewRam;




 WITH RAM_CTE
AS
(
SELECT        
ETLLoadID, 
ResourceAgencyNum, 
Map, 
ISNULL(PublicName,'') as  PublicName,
ISNULL(AgencyDescription,'') as AgencyDescription,
TaxonomyLevelNameID, 
 ParentAgencyNum, 
 ISNULL(PhysicalAddress1,'')+' '+ISNULL(PhysicalAddress2,'') as  PhysicalAddress,
 ISNULL(PhysicalCityID,0) as  PhysicalCityID,
 ISNULL(PhysicalProvinceID,0) as PhysicalProvinceID,
 ISNULL(PhysicalPostalCode,'') as PhysicalPostalCode, 
 ISNULL([PhysicalCountry],'') as [PhysicalCountry],
 ISNULL(PhysicalAddressIsPrivate, 'No') as [PhysicalAddressIsPrivate],
 ISNULL(Latitude, 0.0) as Latitude,
 ISNULL(Longitude,0.0) as Longitude, 
 ISNULL(HoursOfOperation,'') as HoursOfOperation, 
 ISNULL(COALESCE (PhoneTollFree,PhoneNumberBusinessLine,PhoneNumberAfterHours,PhoneNumberHotline,PhoneNumberOutOfArea, Phone1Number, Phone2Number, Phone3Number,Phone4Number, Phone5Number),'') as Phone, 
 ISNULL(WebsiteAddress,'') as WebsiteAddress, 
 ISNULL(Eligibility,'') as Eligibility,
 ISNULL(DisabilitiesAccess,'') as DisabilitiesAccess,
 ISNULL(FeeStructureSource,'') as FeeStructureSource,
 ISNULL(ApplicationProcess,'') as ApplicationProcess,
 ISNULL(DocumentsRequired,'') as DocumentsRequired,
 ISNULL(LanguagesOfferedList,'') as LanguagesOfferedList,
 ISNULL(LanguageOfRecord,'') as LanguageOfRecord,
 ISNULL(WorkHours,'') as WorkHours,
 ISNULL(CustomEligibilitybyAge,'') as CustomEligibilitybyAge,
ConnectsToSiteNum, 
ConnectsToProgramNum,
getdate() as changedDate,
createdDate  ,
R.*
FROM            taxonomyraw 
OUTER APPLY [dbo].[F_ram] (taxonomyraw.ETLLOADID) as R
)




INSERT INTO NewRAM
select 
 [ETLLoadID]
,[ResourceAgencyNum]
,[Map]
,[PublicName]               =  CASE  
									WHEN LEN([ps_PublicName]) >0 THEN [ps_PublicName]
									WHEN LEN([PublicName]) >0 THEN [publicname]  
									WHEN LEN([s_PublicName]) >0 THEN [s_PublicName] 
									ELSE [a_publicname]
								END

,[AgencyDescription]        =  CASE 
									WHEN LEN([AgencyDescription])>0 THEN [AgencyDescription] 
									WHEN LEN([ps_AgencyDescription])>0 THEN [ps_AgencyDescription] 
									ELSE '' 
								END
,[TaxonomyLevelNameID]       
,[ParentAgencyNum]           
,[PhysicalAddress]          =  [s_PhysicalAddress]
,[PhysicalCityID]           =  [s_PhysicalCityID]
,[PhysicalProvinceID]       =  [s_PhysicalProvinceID]
,[PhysicalCountry]          =  [s_PhysicalCountry]
,[PhysicalPostalCode]       =  [s_PhysicalPostalCode]
,[PhysicalAddressIsPrivate] 
,[Latitude]                 =  CASE 
									WHEN [s_Latitude]    !=0.0    THEN  [s_Latitude] 
									WHEN [ps_Latitude]    != 0.0    THEN  [ps_Latitude]         
									WHEN [Latitude]    !=0.0    THEN  [Latitude]  
									ELSE [a_Latitude]    
							   END
,[Longitude]                =  CASE WHEN [s_Longitude]    != 0.0    THEN  [s_Longitude]         
									WHEN [ps_Longitude]    !=0.0    THEN  [ps_Longitude]  
									WHEN [Longitude]    !=0.0    THEN  [Longitude]  
									ELSE [a_Longitude]    
							   END
,[HoursOfOperation]         =  CASE WHEN  LEN ([ps_HoursOfOperation])    >0    THEN  [ps_HoursOfOperation]         
									WHEN  LEN ([HoursOfOperation])    >0    THEN  [HoursOfOperation]  
									WHEN  LEN ([s_HoursOfOperation])    >0    THEN  [s_HoursOfOperation]  
									ELSE  [a_HoursOfOperation]  
							   END
,[Phone]                    =  CASE WHEN  LEN ([ps_Phone])    >0    THEN  [ps_Phone]         
									WHEN  LEN ([Phone])    >0    THEN  [Phone]  
									WHEN  LEN ([s_Phone])    >0    THEN  [s_Phone]  
									ELSE  [a_Phone]    
							   END
,[WebsiteAddress]           =  CASE WHEN  LEN ([ps_WebsiteAddress])    >0    THEN  [ps_WebsiteAddress]         
									WHEN  LEN ([WebsiteAddress])    >0    THEN  [WebsiteAddress]  
									WHEN  LEN ([s_WebsiteAddress])    >0    THEN  [s_WebsiteAddress]  
									ELSE  [a_WebsiteAddress]    
							   END
,[Eligibility]              =  CASE WHEN  LEN ([Eligibility])    >0    THEN  [Eligibility]         
									WHEN  LEN ([ps_Eligibility])    >0    THEN  [ps_Eligibility]  
									ELSE  ''    
							   END
,[DisabilitiesAccess]       =  CASE WHEN  LEN ([ps_DisabilitiesAccess])    >0    THEN  [ps_DisabilitiesAccess]         
									WHEN  LEN ([DisabilitiesAccess])    >0    THEN  [DisabilitiesAccess]  
									WHEN  LEN ([s_DisabilitiesAccess])    >0    THEN  [s_DisabilitiesAccess]  
									ELSE  [a_DisabilitiesAccess]    
							   END
,[FeeStructureSource]       =  CASE WHEN  LEN ([FeeStructureSource])    >0    THEN  [FeeStructureSource]         
									WHEN  LEN ([ps_FeeStructureSource])    >0    THEN  [ps_FeeStructureSource]  
									ELSE  ''    
							   END
,[ApplicationProcess]       =  CASE WHEN  LEN ([ApplicationProcess])    >0    THEN  [ApplicationProcess]         
									WHEN  LEN ([ps_ApplicationProcess])    >0    THEN  [ps_ApplicationProcess]  
									ELSE  ''    
							   END
,[DocumentsRequired]        =  CASE WHEN  LEN ([DocumentsRequired])    >0    THEN  [DocumentsRequired]         
									WHEN  LEN ([ps_DocumentsRequired])    >0    THEN  [ps_DocumentsRequired]  
									ELSE  ''    
							   END
,[LanguagesOfferedList]     =  CASE WHEN  LEN ([LanguagesOfferedList])    >0    THEN  [LanguagesOfferedList]         
									WHEN  LEN ([ps_LanguagesOfferedList])    >0    THEN  [ps_LanguagesOfferedList]  
									ELSE  ''    
							   END
,[LanguageOfRecord]         
,[WorkHours]                =  CASE WHEN  LEN ([ps_Hours])    >0    THEN  [ps_Hours]         
									WHEN  LEN ([WorkHours])    >0    THEN  [WorkHours]  
									WHEN  LEN ([s_Hours])    >0    THEN  [s_Hours]  
									ELSE  [a_Hours]    
							   END
,[CustomEligibilitybyAge]   =  CASE WHEN  LEN ([CustomEligibilitybyAge])    >0    THEN  [CustomEligibilitybyAge]         
									WHEN  LEN ([ps_CustomEligibilitybyAge])    >0    THEN  [ps_CustomEligibilitybyAge]  
									ELSE  ''    
							   END
,[changedDate] 
,[createdDate]               

from RAM_CTE  
ORDER BY ETLLoadID;


--update [dbo].[NewRam] SET  MAP = 0 
--where   LEN(PhysicalAddress) <1 or 
--PhysicalAddressIsPrivate like '%y%' or 
--EXISTS (select r.* from TaxonomyRAW as t  outer apply [dbo].[relatedPS] (t.ETLLOADID,t.parentagencynum) AS r  where r.etlloadid is not null)

--update [dbo].[NewRam] SET  MAP = 0 
--where    PhysicalAddress IS NULL    or 
--            LEN(RTRIM(LTRIM (PhysicalAddress))) <1    or 
--			PhysicalAddressIsPrivate like '%y%' ;



END
