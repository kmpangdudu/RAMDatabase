-- =============================================
-- Author:		william Chen
-- Create date: 2019-04-09
-- Description:	get agent status by status code
-- =============================================
CREATE PROCEDURE [iceCTI].[Proc_GetAgentStatus] 
@statusecode int = 25
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	  select [StatusWeight] as [Weight], statusAlias as [status] from [iceCTI].[AgentStatus]
			where StatusCode = @statusecode
END