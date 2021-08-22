-- =============================================
-- Author:		William Chen
-- Create date: <Create Date,,>
-- Description:	Get City list by province
-- Reversion: Augest 4, 2016
--	add parameter @token 
-- =============================================
create PROCEDURE p111
	-- Add the parameters for the stored procedure here
	@pid int,
	@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
SELECT        CityId, CityName as city, province.ProvinceAlias as province
FROM            CityLocation  join province on CityLocation.ProvinceID = province.ProvinceID
WHERE province.[ProvinceID] = @pid and CityName !='TBD' 
		AND CityId IN (SELECT * FROM F_Get_ALL_Allow_City(@token))
ORDER BY CityLocation.ProvinceID, CityName  
END