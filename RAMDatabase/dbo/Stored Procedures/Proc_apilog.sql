-- ===========================================================================================================
-- Author:		William Chen
-- Create date: July 19, 2017
-- Description:	Log 
-- Reversion: November 11, 2017, set @CSIP ans @CSHOST to '127.0.0.1' when it they come from localhost
-- ===========================================================================================================
CREATE PROCEDURE [dbo].[Proc_apilog] 
@dbschema nvarchar(50) = N'dbo',
@csmethod nvarchar(50) = N'GET',
@format nvarchar(50),
@para nvarchar(50),
@lang nvarchar(4) = N'en',
@token nvarchar(50) = N'',
@cscontent nvarchar(50) = NULL ,
@csendpoint nvarchar(50) = NULL ,
@keywords nvarchar(4000) = NULL,
@csip nvarchar(50),
@csstatus nvarchar(50),
@cscode int,
@cshost nvarchar(50),
@csurl nvarchar(1000),
@csuseragent nvarchar(1000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @aclid int = -1;
	DECLARE @aclName NVARCHAR(255);
	SELECT @aclid = [ACLID] FROM [dbo].AccessControlList WHERE [ACLToken]=@token;
	
	IF (@aclid = -1) AND (@csmethod = 'POST')  select @aclname = 'KHP' ;

	SELECT  @aclName = case 
						when [ACLName] = 'BlancLabs' then 'KHP'
						else [aclName] 
						end     
	FROM [dbo].AccessControlList WHERE [ACLToken]=@token;

	-- location info
	DECLARE @IPNUM BIGINT = 0;
	DECLARE @COUNTRY NVARCHAR(50) ='';
	DECLARE @REGION NVARCHAR(50) ='';
	DECLARE @CITY NVARCHAR(255) =''
	DECLARE @LATITUDE NUMERIC (18,10) = 0.0
	DECLARE @LONGITUDE NUMERIC (18,10) = 0.0
	
	-- sel localhost or ::1 to 127.0.0.1
	SELECT @CSIP = CASE 
					WHEN @CSIP = '::1' THEN '127.0.0.1'
					WHEN @CSIP = 'localhost' THEN '127.0.0.1'
					ELSE @csip
				   END;
	SELECT @cshost = CASE 
					WHEN @cshost = '::1' THEN '127.0.0.1'
					WHEN @cshost = 'localhost' THEN '127.0.0.1'
					ELSE @cshost
				   END;


	-- When user's ip (csip) cannot convert to bigint then SET it TO 0 (Zero) 
	BEGIN TRY
		SELECT @IPNUM = [dbo].[fn_Ipv4_to_int] (@csip);
	END TRY
	BEGIN CATCH
		SELECT @IPNUM = 0
	END CATCH

	select top(1)	@COUNTRY = l.country,
					@REGION = l.region,
					@CITY = l.city,
					@LATITUDE = l.latitude, 
					@LONGITUDE = l.longitude
	from geo.cityblocks as b join geo.citylocation as l on b.locid = l.locid
	where b.startipnum<= @ipnum and @ipnum <=b.endipnum



	-- Insert log record
INSERT INTO apilog
             (dbschema, csmethod, [format],[para],[lang], aclid, aclname, cscontent, csendpoint, keywords, 
			 [csip], [cscountry], [csregion], [cscity], [latitude], [longitude],
			 [csstatus], [cscode], cshost, csurl, csuseragent)
VALUES        (@dbschema,@csmethod,@format,@para,@lang,@aclid,@aclname,@cscontent,@csendpoint,@keywords,
				@csip, @COUNTRY, @REGION, @CITY, @LATITUDE, @LONGITUDE,
				@csstatus,@cscode,@cshost,@csurl, @csuseragent)


END