-- ============================================================================
-- Author:		William Chen
-- Create date: July 21, 2016
-- Description:	According to access token to get the KHP authorised City list
--              if the list is NULL, means did not authorise, 
--              if the CityID = -1; means allow access all of Province.
-- ============================================================================
CREATE FUNCTION [dbo].[F_Get_ALL_Allow_City]
(
	-- Add the parameters for the function here
 @token nvarchar(50)
)
RETURNS 
@AllowCityIDList TABLE 
(
	-- Add the column definitions for the TABLE variable here
CityID int
)
AS
BEGIN
	DECLARE @ACLID INT
	-- Find out client number ACLID
	SELECT @ACLID = ACLID FROM AccessControlList WHERE @TOKEN = ACLToken;  

	IF @aclid IS NULL 
		RETURN   -- DID NOT FIND THIS CLIENT, RETURN NULL
	 ELSE
		BEGIN
			DECLARE @AllowProvinceIDList TABLE (ProvinceID int)
			-- Find out allowing access province list
			INSERT INTO @AllowProvinceIDList SELECT DISTINCT PROVINCEID FROM Permission WHERE ACLID = @ACLID ORDER BY PROVINCEID
		END

	DECLARE @V INT
	SELECT TOP (1)  @V = PROVINCEID FROM  @AllowProvinceIDList  -- Find out the mimimum ProvinceID 
	IF @V = 0 
		BEGIN   -- means allow access all of provinces
			INSERT INTO @AllowCityIDList
					SELECT [CityId] AS [CityID] FROM [dbo].[CityLocation] ORDER BY [CityId]
			RETURN   -- Return all Cityid
		END
	ELSE       -- means all access specific provinces
		BEGIN
			INSERT INTO @AllowCityIDList
					SELECT ACID.cid  FROM @AllowProvinceIDList AS APID CROSS APPLY  [dbo].[F_GetAllowCity_By_Province] (APID.ProvinceID, @token) AS ACID
					ORDER BY ACID.cid
		END
	RETURN 
END
