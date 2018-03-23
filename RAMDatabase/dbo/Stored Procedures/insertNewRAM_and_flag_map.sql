-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE insertNewRAM_and_flag_map 
	-- Add the parameters for the stored procedure here
 	@ETLLoadID bigint  ,
	@ResourceAgencyNum varchar(50) ,
	@PublicName varchar(2000) ,
	@AgencyDescription varchar(max) ,
	@TaxonomyLevelNameID int ,
	@ParentAgencyNum varchar(50) ,
	@PhysicalAddress varchar(2000) ,
	@PhysicalCityID int ,
	@PhysicalCity varchar(50) ,
	@region varchar(50) ,
	@PhysicalProvinceID int ,
	@PhysicalStateProvince varchar(50) ,
	@PhysicalPostalCode varchar(50) ,
	@PhysicalCountry varchar(50) ,
	@PhysicalAddressIsPrivate varchar(50) ,
	@Latitude numeric(18, 10) ,
	@Longitude numeric(18, 10) ,
	@HoursOfOperation varchar(2000) ,
	@Phone varchar(2000) ,
	@WebsiteAddress varchar(2000) ,
	@Eligibility varchar(2000) ,
	@DisabilitiesAccess varchar(2000) ,
	@FeeStructureSource varchar(2000) ,
	@ApplicationProcess varchar(2000) ,
	@DocumentsRequired varchar(2000) ,
	@LanguagesOfferedList varchar(2000) ,
	@ConnectsToSiteNum varchar(50) ,
	@ConnectsToProgramNum varchar(50) ,
	@LanguageOfRecord varchar(50) ,
	@WorkHours varchar(2000) ,
	@CustomEligibilitybyAge varchar(2000) ,
	@createdDate datetime  
AS	
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	if NOT exists ( select ETLLOADID from [NewRam] where ETLLOADID = @ETLLOADID)
		 
			insert into [dbo].[NewRam]   
						(
						ETLLoadID    ,
						ResourceAgencyNum  ,
						PublicName  ,
						AgencyDescription   ,
						TaxonomyLevelNameID   ,
						ParentAgencyNum  ,
						PhysicalAddress  ,
						PhysicalCityID   ,
						PhysicalCity  ,
						region  ,
						PhysicalProvinceID   ,
						PhysicalStateProvince  ,
						PhysicalPostalCode  ,
						PhysicalCountry  ,
						PhysicalAddressIsPrivate  ,
						Latitude   ,
						Longitude  ,
						HoursOfOperation  ,
						Phone  ,
						WebsiteAddress  ,
						Eligibility  ,
						DisabilitiesAccess  ,
						FeeStructureSource  ,
						ApplicationProcess  ,
						DocumentsRequired  ,
						LanguagesOfferedList  ,
						ConnectsToSiteNum  ,
						ConnectsToProgramNum  ,
						LanguageOfRecord  ,
						WorkHours  ,
						CustomEligibilitybyAge  ,
						changedDate  ,
						createdDate   
						)
					values (
						@ETLLoadID    ,
						@ResourceAgencyNum  ,
						@PublicName  ,
						@AgencyDescription   ,
						@TaxonomyLevelNameID   ,
						@ParentAgencyNum  ,
						@PhysicalAddress  ,
						@PhysicalCityID   ,
						@PhysicalCity  ,
						@region  ,
						@PhysicalProvinceID   ,
						@PhysicalStateProvince  ,
						@PhysicalPostalCode  ,
						@PhysicalCountry  ,
						@PhysicalAddressIsPrivate  ,
						@Latitude   ,
						@Longitude  ,
						@HoursOfOperation  ,
						@Phone  ,
						@WebsiteAddress  ,
						@Eligibility  ,
						@DisabilitiesAccess  ,
						@FeeStructureSource  ,
						@ApplicationProcess  ,
						@DocumentsRequired  ,
						@LanguagesOfferedList  ,
						@ConnectsToSiteNum  ,
						@ConnectsToProgramNum  ,
						@LanguageOfRecord  ,
						@WorkHours  ,
						@CustomEligibilitybyAge  ,
						 getdate()   ,
						@createdDate   )
		 
	else
		 
			update [dbo].[NewRam] SET
					 
						ResourceAgencyNum  =	@ResourceAgencyNum  ,
						PublicName  =	@PublicName  ,
						AgencyDescription   =	@AgencyDescription   ,
						TaxonomyLevelNameID   =	@TaxonomyLevelNameID   ,
						ParentAgencyNum  =	@ParentAgencyNum  ,
						PhysicalAddress  =	@PhysicalAddress  ,
						PhysicalCityID   =	@PhysicalCityID   ,
						PhysicalCity  =	@PhysicalCity  ,
						region  =	@region  ,
						PhysicalProvinceID   =	@PhysicalProvinceID   ,
						PhysicalStateProvince =	@PhysicalStateProvince  ,
						PhysicalPostalCode  =	@PhysicalPostalCode  ,
						PhysicalCountry  =	@PhysicalCountry  ,
						PhysicalAddressIsPrivate	=@PhysicalAddressIsPrivate  ,
						Latitude   =	@Latitude   ,
						Longitude  =	@Longitude  ,
						HoursOfOperation  =	@HoursOfOperation  ,
						Phone  =	@Phone  ,
						WebsiteAddress  =	@WebsiteAddress  ,
						Eligibility  =	@Eligibility  ,
						DisabilitiesAccess  =	@DisabilitiesAccess  ,
						FeeStructureSource  =	@FeeStructureSource  ,
						ApplicationProcess  =	@ApplicationProcess  ,
						DocumentsRequired  =	@DocumentsRequired  ,
						LanguagesOfferedList  =	@LanguagesOfferedList  ,
						ConnectsToSiteNum  =	@ConnectsToSiteNum  ,
						ConnectsToProgramNum  =	@ConnectsToProgramNum  ,
						LanguageOfRecord  =	@LanguageOfRecord  ,
						WorkHours =	@WorkHours  ,
						CustomEligibilitybyAge =	@CustomEligibilitybyAge  ,
						changedDate 	= getdate()   ,
						createdDate = 	@createdDate    
				where ETLLoadID=@ETLLoadID  ;


				IF ( @PhysicalAddress IS NULL)
					update [dbo].[NewRam] SET  MAP = 0 where ETLLoadID=@ETLLoadID
				ELSE
					IF ( @PhysicalAddressIsPrivate like '%y%')
							update [dbo].[NewRam] SET  MAP = 0 where ETLLoadID=@ETLLoadID
					ELSE
						IF NOT EXISTS ( select   etlloadid  from RAMRAW where parentagencynum = @ParentAgencyNum and RAMRAW.taxonomylevelnameid in (2,4) )
							update [dbo].[NewRam] SET  MAP = 0 where ETLLoadID=@ETLLoadID
						ELSE
							update [dbo].[NewRam] SET  MAP = 1 where ETLLoadID=@ETLLoadID
		 


				
		 



END
