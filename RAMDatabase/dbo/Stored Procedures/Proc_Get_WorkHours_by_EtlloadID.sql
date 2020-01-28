-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Proc_Get_WorkHours_by_EtlloadID]
	-- Add the parameters for the stored procedure here
@ETLLOADID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT
       [ETLLoadID]
      ,[WorkHour]
  FROM [dbo].[WorkHour] WHERE [ETLLoadID] = @ETLLOADID
END
