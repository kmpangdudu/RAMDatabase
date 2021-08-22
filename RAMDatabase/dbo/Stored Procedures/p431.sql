-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Get_TopCategory
-- REVERSION: July 22, 2016 added parameter @token, changed logic
-- =============================================
create  PROCEDURE p431
 @lang nvarchar(50) ='en',
 @token nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @V INT
	SELECT Top(1) @v = TopcategoryID FROM F_Get_Allow_TopCategory (@token) 
 
	 IF @v=0  -- allows to access all TopCategory 
		begin
			SELECT TopCategoryID , 
					CASE @lang WHEN 'fr' THEN TopCategory_fr ELSE TopCategory END AS TopCategory 
					FROM [dbo].[TopCategory] WHERE Active = 1 
		end
	ELSE 
		begin
				SELECT TopCategoryID , 
				CASE @lang WHEN 'fr' THEN TopCategory_fr ELSE TopCategory END AS TopCategory 
				FROM [dbo].[TopCategory] WHERE Active = 1  
				AND TopCategoryID in (select * FROM F_Get_Allow_TopCategory (@token) )
		end




 
  
END