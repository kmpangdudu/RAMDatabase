-- =============================================
-- Author:		william chen
-- Create date: 2017-07-04
-- Description:	log geoLocation update
-- =============================================
CREATE PROCEDURE [geo].[Proc_log_geolocation_updateing] 
	-- Add the parameters for the stored procedure here
@ipblocks INT,
@iplocation INT,
@canadianblocks INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [geo].[updatelog] (ipblocks,iplocation,canadianblocks) 
VALUES (@ipblocks,@iplocation, @canadianblocks)
END
