-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Insert_Update_Table_Subcategory]
	-- Add the parameters for the stored procedure here
@SubCategory NVARCHAR(255),
@SubCategoryDesc NVARCHAR (500) = '',
@SubCategory_fr NVARCHAR(500) = N'',
@SubCategoryDesc_fr NVARCHAR(500) = N'',
@Active bit = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
  IF EXISTS (SELECT SubCategoryid FROM [dbo].[SubCategory] WHERE SubCategory = @SubCategory )
	  BEGIN
		  UPDATE [dbo].[SubCategory] SET
		  Active = @Active,
		  ChangedDate = GETDATE()
		  WHERE SubCategory = @SubCategory
	  END
	ELSE
		BEGIN
			INSERT INTO [dbo].[SubCategory] 
				([SubCategory],[SubCategoryDesc],[SubCategory_fr],[SubCategoryDesc_fr],[Active],[ChangedDate])
			VALUES
				(@SubCategory,@SubCategoryDesc,@SubCategory_fr,@SubCategoryDesc_fr,  @Active  ,  getdate())
		END

END
