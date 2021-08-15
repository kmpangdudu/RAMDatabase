-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE buildIndex
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

ALTER INDEX ALL ON KeyWords  REBUILD;
ALTER INDEX ALL ON InterestTaxonomyID_ETLLoadID  REBUILD;
ALTER INDEX ALL ON ACLIP  REBUILD;
ALTER INDEX ALL ON updatelog  REBUILD;
ALTER INDEX ALL ON CityLocation  REBUILD;
ALTER INDEX ALL ON apilog  REBUILD;
ALTER INDEX ALL ON InterestTaxonomy  REBUILD;
ALTER INDEX ALL ON CityLocation  REBUILD;
ALTER INDEX ALL ON RAMRAW  REBUILD;
ALTER INDEX ALL ON updatelog  REBUILD;
ALTER INDEX ALL ON ETLLoad  REBUILD;
ALTER INDEX ALL ON SubCategory  REBUILD;
ALTER INDEX ALL ON ETLLoadID_TaxonomyCode  REBUILD;
ALTER INDEX ALL ON RamResource  REBUILD;
ALTER INDEX ALL ON ETLLoadID_TaxonomyCode  REBUILD;
ALTER INDEX ALL ON Combine_Categories  REBUILD;
ALTER INDEX ALL ON ProgramRAW  REBUILD;
ALTER INDEX ALL ON TaxonomyRAW  REBUILD;
ALTER INDEX ALL ON Province  REBUILD;
ALTER INDEX ALL ON TopCategory  REBUILD;
ALTER INDEX ALL ON Stopwords  REBUILD;
ALTER INDEX ALL ON SubcategoryID_InterestTaxonomyID  REBUILD;
ALTER INDEX ALL ON TopCategoryID_SubCategoryID  REBUILD;
END