-- =============================================
-- Author:		William Chen
-- Create date: July 21, 2016
-- Description:	According to access token to get the KHP authorised Province list
--              if the list is NULL, means did not authorise, 
--              if the ProvinceID = 0; means allow access all of Province.
-- =============================================
CREATE FUNCTION [dbo].[F_Get_Allow_Province]
(
	-- Add the parameters for the function here
 @token nvarchar(50)
)
RETURNS 
@AllowProvinceIDList TABLE 
(
	-- Add the column definitions for the TABLE variable here
ProvinceID int
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	INSERT INTO @AllowProvinceIDList
	SELECT DISTINCT p.ProvinceID   FROM [dbo].[Permission] as p 
				join [dbo].[AccessControlList] as acl  on p.aclid= acl.aclid  
		WHERE acl.acltoken = @token
		ORDER BY p.ProvinceID
	
	RETURN 
END
