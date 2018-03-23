-- =============================================
-- Author:		William Chen
-- Create date: 2017-10-23
-- Description:	log data ware housing log
-- =============================================
CREATE PROCEDURE dbo.Proc_Datawarehousing

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @ETLLoad                        int = 0;
DECLARE @RAMResource_fr                 int = 0;
DECLARE @Coverage         int = 0;
DECLARE @CustomEligibilitybyAge      int = 0;
DECLARE @ETLLoadID_TaxonomyCode      int = 0;
DECLARE @InterestTaxonomyID_ETLLoadID   int = 0
DECLARE @KeyWords         int = 0;
DECLARE @WorkHour         int = 0;
DECLARE @ProgramRAW         int = 0;
DECLARE @RAMRAW          int = 0;
DECLARE @TaxonomyRAW        int = 0;
DECLARE @SuggestionWord        int = 0;
DECLARE @RamResource        int = 0;
DECLARE @mapped          int = 0;
DECLARE @Lists          int = 0;
DECLARE @Boths          int = 0;
DECLARE @shelter         int = 0;
DECLARE @publicname         int = 0;
DECLARE @LatLon          int = 0;
DECLARE @PhysicalAddress       int = 0;
DECLARE @AgencyDescription       int = 0;
DECLARE @DisabilitiesAccess       int = 0;
DECLARE @LanguagesOfferedList      int = 0;
DECLARE @CoverageArea                int = 0;
DECLARE @ICoverage                   int = 0;
DECLARE @English                     int = 0;
DECLARE @French                      int = 0;
DECLARE @Agency                      INT = 0;
DECLARE @Site                        INT = 0;
DECLARE @Program                     INT = 0;
DECLARE @ProgramAtSite               INT = 0;
select @ETLLoad=COUNT(etlloadid) from  [dbo].[ETLLoad];
Select @English =  COUNT(etlloadid) from  [dbo].[ETLLoad] WHERE LanguageOfRecord = 'en';
Select @French = @ETLLoad - @English ;
SELECT @Agency         = COUNT(etlloadid)   from  [dbo].[ETLLoad] WHERE TaxonomyLevelName = 'Agency'
SELECT @Site           = COUNT(etlloadid)   from  [dbo].[ETLLoad] WHERE TaxonomyLevelName = 'Site'
SELECT @Program        = COUNT(etlloadid)   from  [dbo].[ETLLoad] WHERE TaxonomyLevelName = 'Program'
SELECT @ProgramAtSite  = COUNT(etlloadid)   from  [dbo].[ETLLoad] WHERE TaxonomyLevelName = 'ProgramAtSite'
select @RAMResource_fr = count(etlloadid)   from [dbo].[RAMResource] where LanguageOfRecord = 'fr' AND  (RamResource.PhysicalCityID <> 0) AND (RamResource.PhysicalProvinceID <> 99) ;
select @Coverage=COUNT(etlloadid) from [dbo].[Coverage];
select @CustomEligibilitybyAge=COUNT(etlloadid) from [dbo].[CustomEligibilitybyAge];
select @ETLLoadID_TaxonomyCode=COUNT(etlloadid) from [dbo].[ETLLoadID_TaxonomyCode];
select @InterestTaxonomyID_ETLLoadID=COUNT(etlloadid) from [dbo].[InterestTaxonomyID_ETLLoadID];
select @KeyWords=COUNT(etlloadid) from [dbo].[KeyWords];
select @WorkHour=COUNT(etlloadid) from [dbo].[WorkHour];
select @ProgramRAW=COUNT(etlloadid) from [dbo].[ProgramRAW];
select @RAMRAW=COUNT(etlloadid) from [dbo].[RAMRAW];
select @TaxonomyRAW=COUNT(etlloadid) from [dbo].[TaxonomyRAW];
select @SuggestionWord=COUNT(SuggestionWordid) from [dbo].[SuggestionWord];
select @RamResource=COUNT(etlloadid) from  [dbo].[RamResource] WHERE (RamResource.PhysicalCityID <> 0) AND (RamResource.PhysicalProvinceID <> 99) ;
select @mapped=COUNT(etlloadid) from  [dbo].[RamResource] where Map ='mapped' AND  (RamResource.PhysicalCityID <> 0) AND (RamResource.PhysicalProvinceID <> 99) ;
select @Lists=COUNT(etlloadid) from  [dbo].[RamResource] where Map ='List' AND  (RamResource.PhysicalCityID <> 0) AND (RamResource.PhysicalProvinceID <> 99) ;
select @Boths=COUNT(etlloadid) from  [dbo].[RamResource] where Map ='Both' AND  (RamResource.PhysicalCityID <> 0) AND (RamResource.PhysicalProvinceID <> 99) ;
select @shelter=COUNT(etlloadid) from  [dbo].[RamResource] where Map ='shelter' AND  (RamResource.PhysicalCityID <> 0) AND (RamResource.PhysicalProvinceID <> 99) ;
select distinct @publicname=count(etlloadid) from  [dbo].[RamResource] where Len(publicname ) <2;
select distinct @LatLon=count(etlloadid) from  [dbo].[RamResource] where ( map='mapped' or map='both') and Latitude =0.0;
select distinct @PhysicalAddress=count(ETLLoadID)  from  [dbo].[RamResource] where (map != 'shelter') and len(PhysicalAddress) <2;
select distinct @AgencyDescription=count(etlloadid) from  [dbo].[RamResource] where Len(AgencyDescription ) <2;
select distinct @DisabilitiesAccess=count(etlloadid) from  [dbo].[RamResource] where Len(DisabilitiesAccess ) <2;
select distinct @LanguagesOfferedList=count(etlloadid) from  [dbo].[RamResource] where Len( LanguagesOfferedList ) <2;
select distinct @CoverageArea=count(etlloadid) from  [dbo].[RamResource] where Len( CoverageArea ) <2;
select distinct @ICoverage=count(etlloadid) from  [dbo].[RamResource] where Len( Coverage ) <2;

INSERT INTO updatelog (UpdatedDate, CommunityResource, CommunityResource_en , CommunityResource_fr,[Agency],[SITE],[PROGRAM],[ProgramAtSite] ,PCoverage, PCustomEligibilitybyAge, ETLLoadID_TaxonomyCode, InterestTaxonomyID_ETLLoadID, KeyWords, PWorkHour, 
       ProgramRAW, RAMRAW, TaxonomyRAW, SuggestionWords, RAMResource, RAMResource_fr, [Mapped], [Lists], [Boths], shelter, 
       IPublicName, ILatLong, IAddress, IAgencyDesc, IDisabilitiesAccess, ILanguagesOfferedList, ICoverageArea, ICoverage)
VALUES        (CONVERT(DATE,GETDATE()),@ETLLoad,@English,@French,@Agency,@SITE,@PROGRAM,@ProgramAtSite,@Coverage,@CustomEligibilitybyAge,@ETLLoadID_TaxonomyCode,@InterestTaxonomyID_ETLLoadID,@KeyWords,@WorkHour,
       @ProgramRAW,@RAMRAW,@TaxonomyRAW,@SuggestionWord,@RamResource,@RAMRESOURCE_FR,@mapped,@Lists,@Boths,@shelter,@publicname,@LatLon,@PhysicalAddress,@AgencyDescription,@DisabilitiesAccess,@LanguagesOfferedList,@CoverageArea,@ICoverage)
;

END
