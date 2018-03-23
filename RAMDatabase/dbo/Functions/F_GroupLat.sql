-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
Create FUNCTION [dbo].[F_GroupLat] 
(	
@lat numeric (18,10)
)
RETURNS TABLE 
AS
RETURN 
(
	-- Add the SELECT statement with parameter references here
select ROW_NUMBER() over (order by  latitude) as rownumber, Etlloadid, latitude,Longitude  from map where Latitude = @lat
)
