-- =============================================
-- Author:		William Chen
-- Create date: Nov.16, 2016
-- Description:	<Insert or update table SubcategoryID_InterestTaxonomyID
--
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Insert_update_table_SubcategoryID_InterestTaxonomyID]
	-- Add the parameters for the stored procedure here
@taxonomyCode nvarchar(50) ,
@subcategoryid int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets FROM
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
SELECT @taxonomyCode = LTRIM(RTRIM(@taxonomyCode));

DECLARE @InterestTaxonomyID INT ;
-- check whether this taxonomy code has resource or not
SELECT 'Table ETLLOAD', ETLLOADID , ResourceAgencyNum,PublicName,[TaxonomyLevelName], TaxonomyCodes,LanguageOfRecord, [CustomRecordType]
		FROM etlload 
		WHERE ([CustomRecordType] LIKE '%RAM%'  ) AND ( taxonomyCodes like '%'+ @taxonomyCode+ '%'   );  

SELECT        @InterestTaxonomyID = InterestTaxonomyID FROM            InterestTaxonomy     
		WHERE  (  Active = 1 )   AND     (InterestTaxonomyCode = @taxonomyCode)  ;
-- see what InterestTaxonomyID is 
SELECT  'Table InterestTaxonomy',    InterestTaxonomyID,   Active,  changedDate,   createdDate FROM     InterestTaxonomy 
		WHERE        (InterestTaxonomyCode = @taxonomyCode)  ;

-- check; if SubcategoryID_InterestTaxonomyID pair exists then update or insert
IF NOT EXISTS	(
				SELECT SubcategoryID_InterestTaxonomyID  FROM [dbo].[SubcategoryID_InterestTaxonomyID] 
					WHERE  InterestTaxonomyID = @InterestTaxonomyID   AND  SubCategoryID = @subcategoryid 
				)
	BEGIN   ---   New Taxonomy Code
		INSERT INTO [dbo].[SubcategoryID_InterestTaxonomyID]  (SubCategoryID , InterestTaxonomyID ,  Active  , ChangedDate )  VALUES
		(@subcategoryid ,  @InterestTaxonomyID ,  1  ,  GETDATE())
	END
ELSE  -- OLD Taxonomy Code
	BEGIN
		update [dbo].[SubcategoryID_InterestTaxonomyID] set　Active = 1,　ChangedDate = GETDATE()
		WHERE InterestTaxonomyID = @InterestTaxonomyID   AND  SubCategoryID = @subcategoryid  AND Active = 0
	END  ;

-- Review review inserted or updated result
SELECT        a.SubcategoryID_InterestTaxonomyID, a.SubCategoryID, SubCategory.SubCategory, a.InterestTaxonomyID, b.InterestTaxonomyCode, a.Active, a.ChangedDate, a.CreatedDate
FROM            SubcategoryID_InterestTaxonomyID AS a INNER JOIN
                         InterestTaxonomy AS b ON a.InterestTaxonomyID = b.InterestTaxonomyID INNER JOIN
                         SubCategory ON a.SubCategoryID = SubCategory.SubCategoryID
WHERE        (a.SubCategoryID = @subcategoryid) AND (a.Active = 1)

END
