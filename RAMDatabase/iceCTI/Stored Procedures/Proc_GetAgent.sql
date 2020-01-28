-- =============================================
-- Author:		William Chen
-- Create date: 2019-04-09
-- Description:	Get agent (counsellor) info from ice server
-- =============================================
CREATE PROCEDURE [iceCTI].[Proc_GetAgent]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
select [SwitchID],[AgentID],[AgentName],[AgentType] from [iceCTI].[Agent] 
where [AgentID] >1002 and [AgentID] <1400
order by [AgentID], AgentName

end