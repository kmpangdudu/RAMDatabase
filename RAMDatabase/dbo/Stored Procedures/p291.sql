-- =============================================
-- Author:		William Chen
-- Create date: Nov.6, 2016
-- Description:	Get all allowable IP addresses
-- =============================================
create PROCEDURE p291

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT ACLIP FROM [ACLIP] WHERE ACLIPActivity = 1;
END