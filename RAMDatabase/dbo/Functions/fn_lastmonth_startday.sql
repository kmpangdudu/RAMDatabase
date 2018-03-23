-- =============================================
-- Author:		William Chen	
-- Create date: Aug.3, 2017
-- Description:	get last month start day
-- =============================================
CREATE FUNCTION fn_lastmonth_startday
(
 
)
RETURNS date
AS
BEGIN
	-- Declare the return variable here
	DECLARE @lastmonth_startday DATE

	-- Add the T-SQL statements to compute the return value here
	SELECT @lastmonth_startday = DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) - 1, 0)

	-- Return the result of the function
	RETURN @lastmonth_startday

END
