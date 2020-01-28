-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Insert_Update_Table_TopCategory] 
	-- Add the parameters for the stored procedure here
@TopCategory NVARCHAR(255),
@TopCategoryDesc NVARCHAR(500) = N'',
@TopCategory_fr NVARCHAR(255) = N'',
@TopCategoryDesc_fr NVARCHAR(500) = N'',
@Active bit = 1
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
  IF EXISTS (SELECT TopCategoryid FROM [dbo].[TopCategory] WHERE TopCategory = @TopCategory )
	  BEGIN
		  UPDATE [dbo].[TopCategory] SET
		  Active = @Active,
		  ChangedDate = GETDATE()
		  WHERE TopCategory = @TopCategory
	  END
	ELSE
		BEGIN
			INSERT INTO [dbo].[TopCategory] 
				([TopCategory],[TopCategoryDesc],[TopCategory_fr],[TopCategoryDesc_fr],[Active],[ChangedDate])
			VALUES
				(@TopCategory,@TopCategoryDesc,@TopCategory_fr,@TopCategoryDesc_fr,  @Active  ,  getdate())
		END

END
