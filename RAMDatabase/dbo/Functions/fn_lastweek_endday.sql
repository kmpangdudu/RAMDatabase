-- =============================================
-- Author:		William	Chen
-- Create date: Aug.3, 2017
-- Description:	Get last week end day
-- =============================================
CREATE FUNCTION fn_lastweek_endday 
(
 
)
RETURNS DATE
AS
BEGIN
	-- Declare the return variable here
	DECLARE @lastweek_endday date 

	-- Add the T-SQL statements to compute the return value here
	SELECT @lastweek_endday =  DATEADD(day, 1 - DATEPART(dw, GETDATE()), CONVERT(date, GETDATE()))

	-- Return the result of the function
	RETURN @lastweek_endday

END
