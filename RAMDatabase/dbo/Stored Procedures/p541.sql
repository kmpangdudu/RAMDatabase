-- =============================================
-- Author:		William Chen
-- Create date: Dec.1, 2015
-- Description:	Get TopCategory by ID
-- Reversion: July 22, 2016
--			add paremeter @token; and filte by access control list 
-- =============================================
create PROCEDURE p541
	-- Add the parameters for the stored procedure here
@TID int,
@LANG NVARCHAR(20) = 'en',
@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @v INT

	SELECT TOP(1) @v = TopcategoryID FROM F_Get_Allow_TopCategory (@token) 

    IF @V = 0
			BEGIN 
				SELECT TopCategoryID,
				CASE @LANG WHEN 'FR' THEN TopCategory_fr ELSE TopCategory END AS TopCategory
				FROM TopCategory WHERE TopCategoryID = @TID AND Active = 1
			END
		ELSE
			BEGIN
				SELECT TopCategoryID,
				CASE @LANG WHEN 'FR' THEN TopCategory_fr ELSE TopCategory END AS TopCategory
				FROM TopCategory WHERE TopCategoryID = @TID 
				AND Active = 1 
				AND TopCategoryID IN (SELECT * FROM F_Get_Allow_TopCategory (@token) )
			END
END