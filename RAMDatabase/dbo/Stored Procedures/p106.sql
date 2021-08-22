-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- Reversion: July 24, 2016
-- Based on access control list, authorized user allowing to list out cities
-- When CityId List  =  null, means does not allow 
-- =============================================
create PROCEDURE p106
	-- Add the parameters for the stored procedure here
	@token NVARCHAR(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @V INT

    -- Insert statements for procedure here
SELECT        CityId, CityName as city,   p.ProvinceAlias as Province
FROM            CityLocation as c  JOIN Province as p on  c.ProvinceID = p.ProvinceID
WHERE Cityname != 'TBD' AND CityID IN (select * from F_Get_ALL_Allow_City(@token))
ORDER BY c.ProvinceID, Cityname 
END