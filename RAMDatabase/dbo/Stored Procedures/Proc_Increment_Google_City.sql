-- =============================================
-- Author:		William Chen
-- Create date: March 4, 2017
-- Description:	Increment get Google City 
-- =============================================
CREATE PROCEDURE Proc_Increment_Google_City 
 @L NVARCHAR (255)

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

 

	  SELECT  googlelocationID as GoogleCityID, googlecity as GoogleCity, p.ProvinceAlias as province 
		FROM [GoogleLocation] as g join Province as p  on p.ProvinceID  = g.[GoogleProvinceID] 
			WHERE googlecity LIKE ''+ @L+'%'


END
