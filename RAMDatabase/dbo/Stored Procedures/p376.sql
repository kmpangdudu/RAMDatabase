-- =============================================
-- Author:		William Chen
-- Create date: <Create Date,,>
-- Description:	Get SubCategory by SID
-- Reversion: July 22, 2016
-- Add Paremeter @token
-- =============================================
create PROCEDURE p376
 @SID INT,
 @lang NVARCHAR (50) ='en',
 @token NVARCHAR (50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @v int
	SELECT TOP(1) @v = TopcategoryID FROM F_Get_Allow_TopCategory (@token) 
 
	IF @v = 0 -- Allow access all topcategory
			BEGIN
				SELECT S.SubCategoryID , 
				CASE @LANG WHEN 'fr' THEN S.SubCategory_fr  ELSE S.SubCategory END AS SubCategory ,
				CASE @LANG WHEN 'fr' THEN S.[SubCategoryDesc_fr] ELSE  S.[SubCategoryDesc] END AS [SubCategoryDesc] 
				FROM [dbo].[SubCategory] AS S WHERE S.SubCategoryID = @SID and S.Active = 1  
			END
		ELSE
			BEGIN
				SELECT S.SubCategoryID , 
				CASE @LANG WHEN 'fr' THEN S.SubCategory_fr  ELSE S.SubCategory END AS SubCategory ,
				CASE @LANG WHEN 'fr' THEN S.[SubCategoryDesc_fr] ELSE  S.[SubCategoryDesc] END AS [SubCategoryDesc] 
				FROM [dbo].[SubCategory] AS S JOIN [TopCategoryID_SubCategoryID] as ts on s.SubCategoryID = ts.SubCategoryID
				WHERE S.SubCategoryID = @SID 
				AND TS.TopCategoryID IN (SELECT * FROM F_Get_Allow_TopCategory (@token) )
				AND S.Active = 1 
			END

END