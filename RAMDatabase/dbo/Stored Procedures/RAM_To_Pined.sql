-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RAM_To_Pined] 
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT      RAMRAW.ETLLoadID, RAMRAW.ResourceAgencyNum, TaxonomyLevelName.TaxonomyLevelName, 
			COALESCE (RAMRAW.PublicName, RAMRAW.AlternateName, RAMRAW.ParentAgency, RAMRAW.OfficialName) AS Name, 
			COALESCE (RAMRAW.PhysicalAddress1, RAMRAW.PhysicalAddress2,RAMRAW.OtherAddress1, RAMRAW.OtherAddress2) as 	PhysicalAddress,	 
			COALESCE (RAMRAW.PhysicalCity,RAMRAW.OtherCity ) as 	PhysicalCity,		 
			COALESCE (RAMRAW.PhysicalStateProvince,RAMRAW.OtherStateProvince) as  PhysicalStateProvince,	  
			COALESCE (RAMRAW.PhysicalCountry,RAMRAW.OtherCountry) as PhysicalCountry,
			COALESCE (RAMRAW.PhysicalPostalCode, RAMRAW.OtherPostalCode ) as PhysicalPostalCode,
                        RAMRAW.Latitude, RAMRAW.Longitude, RAMRAW.HoursOfOperation,
			   
			ISNULL(COALESCE(RAMRAW.Phone1Name, RAMRAW.Phone2Name,RAMRAW.Phone3Name,RAMRAW.Phone4Name,RAMRAW.Phone5Name),'') + ' '+  
			COALESCE (RAMRAW.Phone1Number, RAMRAW.Phone2Number,RAMRAW.Phone3Number,RAMRAW.Phone4Number,RAMRAW.Phone5Number,RAMRAW.PhoneNumberHotLine,RAMRAW.PhoneNumberBusinessLine)  as Phone1,  
			
			ISNULL(RAMRAW.Phone2Name,'')+' '+ ISNULL(RAMRAW.Phone2Number,'') as Phone2,
                         RAMRAW.PhoneTollFree, 

                         RAMRAW.WebsiteAddress,  
                         RAMRAW.LanguageOfRecord,
                          RAMRAW.WorkHours,
                         RAMRAW.CustomEligibilitybyAge,
                         RAMRAW.CustomBilingualService
FROM            RAMRAW INNER JOIN
                         TaxonomyLevelName ON RAMRAW.TaxonomyLevelNameID = TaxonomyLevelName.TaxonomyLevelNameID
WHERE        (RAMRAW.Latitude IS NOT NULL) AND (RAMRAW.Longitude IS NOT NULL)


ORDER BY RAMRAW.Latitude, RAMRAW.Longitude



END
