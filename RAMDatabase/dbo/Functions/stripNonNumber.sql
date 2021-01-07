-- =============================================
-- Author:		William Chen
-- Create date: 2021-01-05
-- Description:	format phone number. Remove any characters from phone number
--  Example, 1-866-123-3456 --> 1866123456
--           (416)123-456 -- 416123456
-- =============================================
CREATE FUNCTION [dbo].[stripNonNumber]
(
	-- Add the parameters for the function here
	@Temp varchar(255)
)
RETURNS varchar(255)
AS
BEGIN
	-- Declare the return variable here
	if patindex('%[e,x]%',@Temp) > 0
	  select @Temp = substring (@Temp,  1,  patindex('%[e,x]%',  @Temp)-1)

	Declare @keepValues as varchar(50) = '%[^0-9]%'
	while patindex(@keepValues, @Temp) > 0
	set @Temp = RTRIM(LTRIM(Stuff(@Temp,  Patindex(@keepValues, @Temp), 1,'')))
 
	if LEN(@Temp) > 11
		set @Temp = substring(@Temp, 1, 11)
		
	-- Return the result of the function
	RETURN @Temp

END