-- =============================================
-- Author:		William Chen
-- Create date: Nov.6, 2016
-- Description:	Get allowable domains
-- =============================================
CREATE PROCEDURE Proc_Get_Allow_Domain 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT  [ACLWeb] FROM [dbo].[ACLWeb] WHERE [ACLWebActivity] = 1
END
