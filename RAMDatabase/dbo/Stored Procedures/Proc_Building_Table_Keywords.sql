-- ==========================================================================================
-- Author:		William Chen
-- Create date: Aug.18, 2016
-- Description:	Building table "[RAM].[dbo].[keywords]"
--	there are some of important columns in the table of KEYWORDS
-- Reversion: Nov.17, 2016
--			Add new columen [Eligibility]
-- ==========================================================================================
CREATE PROCEDURE [dbo].[Proc_Building_Table_Keywords]
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		INSERT INTO keywords ([ETLLoadiD]
					, [PublicName]
					, [AgencyDescription]
					, [PhysicalAddress] 
					, [PhysicalCity] 
					, [PhysicalProvince]
					, [TaxonomyTerm]
					, [TaxonomyTerms]
					, [TopCategory]
					, [TopCategory_fr]
					, [SubCategory]
					, [SubCategory_fr]
					, [Coverage]
					, [Eligibility])
		SELECT   DISTINCT  
					r.etlloadid 
					, r.publicname  
					, r.[AgencyDescription] 
					, r.PhysicalAddress 
					, c.[CityName]  
					, p.ProvinceAlias 
					, e.TaxonomyTerm 
					, e.TaxonomyTerms 
					, TC.TopCategory
					, TC.TopCategory_fr
					, SC.SubCategory
					, SC.SubCategory_fr
					, R.[Coverage]
					, e.Eligibility
			FROM [dbo].[RamResource] R 
					JOIN [dbo].[TopCategory] AS TC ON R.TOPCategoryID = TC.TopCategoryID
					JOIN [dbo].[SubCategory] AS SC ON R.SubCategoryID = SC.SubCategoryID
					JOIN [dbo].[CityLocation] AS c ON r.PhysicalCityID = c.CityId 
					JOIN [dbo].[Province] AS p ON r.PhysicalProvinceID = p.ProvinceID
					JOIN [dbo].[ETLLoad] AS e ON r.ETLLoadID = e.ETLLoadID 
			WHERE TC.Active =1 AND SC.Active =1
			ORDER by r.publicname
		;



		UPDATE keywords SET
				publicname = REPLACE(publicname,'/',' ')
				,[AgencyDescription] = REPLACE([AgencyDescription],'/',' ')
				,[TaxonomyTerm] = REPLACE([TaxonomyTerm],'/',' ')
				,[TaxonomyTerms] = REPLACE([TaxonomyTerms],'/',' ')
				,[TopCategory] = REPLACE ([TopCategory],'&',' ')
				,[TopCategory_fr] = REPLACE ([TopCategory_fr],'&',' ')
				,[SubCategory] = REPLACE([SubCategory],'&',' ')
				,[SubCategory_fr] = REPLACE([SubCategory_fr],'&',' ')
		;
END
