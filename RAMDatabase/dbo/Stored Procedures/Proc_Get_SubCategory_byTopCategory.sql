
-- ==================================================================
-- Author:		William Chen
-- Create date: Nov.10, 2015
-- Description:	Get subcategory by using TopCategory
-- Reversion: July 23, 2016
--            Added Paremeter @token, access token.
--            added access control based on permission table
-- ==================================================================
CREATE PROCEDURE [dbo].[Proc_Get_SubCategory_byTopCategory]
	-- Add the parameters for the stored procedure here
@TID INT = 0,
@lang NVARCHAR (50) = 'en' ,
@token NVARCHAR (50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @v int
	SELECT TOP(1) @v = TopcategoryID FROM F_Get_Allow_TopCategory (@token) 

    IF @v = 0
		BEGIN  --  ALLOW TO ACCESS ALL TOPCATEGORY
				IF (@TID = 0) -- get all subcategory 
					BEGIN
						IF (@lang = 'fr')
							SELECT S.SubCategoryID,  S.SubCategory_fr AS SubCategory , [SubCategoryDesc_fr] AS [SubCategoryDesc] FROM SubCategory   AS S
							WHERE S.Active =1  
						ELSE
							SELECT S.SubCategoryID, S.SubCategory AS SubCategory , [SubCategoryDesc] AS [SubCategoryDesc]  FROM SubCategory   AS S
							WHERE S.Active =1  
						;
					END
				ELSE  -- get subCategory under specific TopCategory ID
					BEGIN
						IF (@lang = 'fr')
							SELECT S.SubCategoryID,  S.SubCategory_fr AS SubCategory , [SubCategoryDesc_fr] AS [SubCategoryDesc] FROM SubCategory   AS S
									JOIN   (SELECT [TopCategoryID], SubCategoryID FROM [TopCategoryID_SubCategoryID]  WHERE [TopCategoryID] = @TID  AND [TopCategoryID_SubCategoryID].Active = 1) AS TS 
											ON S.SubCategoryID = TS.SubCategoryID
							WHERE S.Active =1   
						ELSE
							SELECT S.SubCategoryID, S.SubCategory AS SubCategory , [SubCategoryDesc] AS [SubCategoryDesc] FROM SubCategory   AS S
									JOIN   (SELECT [TopCategoryID], SubCategoryID FROM [TopCategoryID_SubCategoryID]  WHERE [TopCategoryID] = @TID AND [TopCategoryID_SubCategoryID].Active = 1) AS TS 
											ON S.SubCategoryID = TS.SubCategoryID
							WHERE S.Active =1   
						;
					END
		END
	ELSE  --  ALLOW TO ACCESS specific TOPCATEGORY based on Access Control List
		BEGIN
				IF (@TID = 0)  -- get all allow subcategory 
					BEGIN
						IF (@lang = 'fr')
							SELECT S.SubCategoryID,  S.SubCategory_fr AS SubCategory , [SubCategoryDesc_fr] AS [SubCategoryDesc] FROM SubCategory   AS S
							RIGHT JOIN [TopCategoryID_SubCategoryID] as TS0 on TS0.SubCategoryID = S.SubCategoryID 
							WHERE TS0.TopCategoryID in  ( SELECT * FROM F_Get_Allow_TopCategory (@token) )  AND S.Active =  1  AND TS0.Active = 1 
						ELSE
							SELECT S.SubCategoryID, S.SubCategory AS SubCategory , [SubCategoryDesc] AS [SubCategoryDesc]  FROM SubCategory   AS S
							RIGHT JOIN [TopCategoryID_SubCategoryID] as TS0 on TS0.SubCategoryID = S.SubCategoryID 
							WHERE TS0.TopCategoryID in  ( SELECT * FROM F_Get_Allow_TopCategory (@token) )  AND S.Active =  1  AND TS0.Active = 1 
						;
					END
				ELSE  -- get subCategory under specific TopCategory ID
					BEGIN
						IF (@lang = 'fr')
							SELECT S.SubCategoryID,  S.SubCategory_fr AS SubCategory , [SubCategoryDesc_fr] AS [SubCategoryDesc] FROM SubCategory   AS S
									JOIN   (SELECT [TopCategoryID], SubCategoryID FROM [TopCategoryID_SubCategoryID]  
									        WHERE [TopCategoryID] = @TID  AND [TopCategoryID_SubCategoryID].Active = 1) AS TS 
											ON S.SubCategoryID = TS.SubCategoryID
							WHERE S.Active =1      AND   TS.TopCategoryID  IN (SELECT * FROM F_Get_Allow_TopCategory (@token))
						ELSE
							SELECT S.SubCategoryID, S.SubCategory AS SubCategory , [SubCategoryDesc] AS [SubCategoryDesc] FROM SubCategory   AS S
									JOIN   (SELECT [TopCategoryID], SubCategoryID FROM [TopCategoryID_SubCategoryID]  
									        WHERE [TopCategoryID] = @TID AND [TopCategoryID_SubCategoryID].Active = 1) AS TS 
											ON S.SubCategoryID = TS.SubCategoryID
							WHERE S.Active =1      AND   TS.TopCategoryID  IN (SELECT * FROM F_Get_Allow_TopCategory (@token))
						;
					END
		END


END

