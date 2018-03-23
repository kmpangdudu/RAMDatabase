-- =============================================
-- Author:		William Chen
-- Create date: March 4, 2017
-- Description:	get Google City BY province id 
-- =============================================
CREATE PROCEDURE Proc_Get_Google_City_By_ProvinceID
	-- Add the parameters for the stored procedure here
@PID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
  SELECT googlelocationID as GoogleCityID, googlecity as GoogleCity, p.ProvinceAlias as province 
		FROM [GoogleLocation] as g join Province as p  on p.ProvinceID  = g.[GoogleProvinceID] 
		WHERE G.[GoogleProvinceID] = @PID
END
