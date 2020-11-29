-- =============================================
-- Author:		WilliamChen
-- Create date: 2020-11-30
-- Description:	For Log using, give a ETLLoadID, constructure a keywors for APIlog'keywords field
-- APILog's keywords format : TID/Language/ResourceAgencyNum/Map/SID
-- =============================================
CREATE PROCEDURE Proc_Construct_APIlogKeywords_by_ETLLoadid 
	-- Add the parameters for the stored procedure here
	@ETLLoadID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	SELECT   Convert(varchar,TOPCategoryID) 
	+ '/' + LanguageOfRecord 
	+ '/' + ResourceAgencyNum 
	+ '/' + Map 
	+ '/' + convert(varchar, Subcategoryid) as [keywords]
	from RamResource where ETLLoadID = @ETLLoadID
END