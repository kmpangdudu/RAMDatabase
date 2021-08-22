-- =============================================
-- Author:		William Chen
-- Create date: March.14, 2017
-- Description:	Get all Blocked IP addresses
-- =============================================
create PROCEDURE p296

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT		[BlockIP]	FROM	[dbo].[BlockList]		WHERE	[BlockIPActivity]	=	1;
END