-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[F_GEOCode] 
(
	-- Add the parameters for the function here
@Address NVARCHAR(80) = NULL,
@City NVARCHAR(40) = NULL ,
@State NVARCHAR(40) = NULL ,
@Country NVARCHAR(40) = NULL ,
@PostalCode NVARCHAR(20) = NULL ,
@County NVARCHAR(40) = NULL ,
@GPSLatitude numeric(9,6) = NULL ,
@GPSLongitude numeric(9,6) = NULL ,
@MapURL NVARCHAR(1024) = NULL 

)
RETURNS 
@GEOinfo TABLE 
(
	-- Add the column definitions for the TABLE variable here
	GPSAddress NVARCHAR(80) ,
	GPSCity NVARCHAR(40)  ,
	GPSState NVARCHAR(40)  ,
	GPSCountry NVARCHAR(40)  ,
	GPSPostalCode NVARCHAR(20)  ,
	GPSCounty NVARCHAR(40)  ,
	GPSLatitude numeric(9,6)  ,
	GPSLongitude numeric(9,6)  ,
	GPSMapURL NVARCHAR(1024)   
	--,GPSXML VARCHAR(2048)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set


DECLARE @URL NVARCHAR(4000)
 SET @URL = 'http://maps.google.com/maps/api/geocode/xml?sensor=false&address=' +
 CASE WHEN @Address IS NOT NULL THEN @Address ELSE '' END +
 CASE WHEN @City IS NOT NULL THEN ', ' + @City ELSE '' END +
 CASE WHEN @State IS NOT NULL THEN ', ' + @State ELSE '' END +
 CASE WHEN @Country IS NOT NULL THEN ', ' + @Country ELSE '' END +
 CASE WHEN @PostalCode IS NOT NULL THEN ', ' + @PostalCode ELSE '' END +
 CASE WHEN @County IS NOT NULL THEN ', ' + @County ELSE '' END +
 CASE WHEN @GPSLatitude IS NOT NULL THEN ', ' + CAST(@GPSLatitude as NVARCHAR(20)) ELSE '' END  +
 CASE WHEN @GPSLongitude IS NOT NULL THEN ', ' + CAST(@GPSLongitude as NVARCHAR(20)) ELSE '' END  
 SET @URL = REPLACE(@URL, ' ', '+')
 

 DECLARE @Response nvarchar(4000)
 DECLARE @XML xml
 DECLARE @Obj int 
 DECLARE @Result int 
 DECLARE @HTTPStatus int 
 DECLARE @ErrorMsg NVARCHAR(4000)

EXEC @Result = sp_OACreate 'MSXML2.ServerXMLHttp', @Obj OUT 

 --BEGIN TRY
 EXEC @Result = sp_OAMethod @Obj, 'open', NULL, 'GET', @URL, false
 EXEC @Result = sp_OAMethod @Obj, 'setRequestHeader', NULL, 'Content-Type', 'application/x-www-form-urlencoded'
 EXEC @Result = sp_OAMethod @Obj, send, NULL, ''
 EXEC @Result = sp_OAGetProperty @Obj, 'status', @HTTPStatus OUT 
 EXEC @Result = sp_OAGetProperty @Obj, 'responseXML.xml', @Response OUT 
 --END TRY
 --BEGIN CATCH
 --SET @ErrorMsg = ERROR_MESSAGE()
 --END CATCH

 EXEC @Result = sp_OADestroy @Obj

IF (@ErrorMsg IS NOT NULL) OR (@HTTPStatus <> 200) BEGIN
 SET @ErrorMsg = 'Error in spGeocode: ' + ISNULL(@ErrorMsg, 'HTTP result is: ' + CAST(@HTTPStatus AS NVARCHAR(10)))
	--RAISERROR(@ErrorMsg, 16, 1, @HTTPStatus)
     
	RETURN 
 END

SET @XML = CAST(@Response AS XML)

 SET @GPSLatitude = @XML.value('(/GeocodeResponse/result/geometry/location/lat) [1]', 'numeric(9,6)')
 SET @GPSLongitude = @XML.value('(/GeocodeResponse/result/geometry/location/lng) [1]', 'numeric(9,6)')

SET @City = @XML.value('(/GeocodeResponse/result/address_component[type="locality"]/long_name) [1]', 'NVARCHAR(40)') 
 SET @State = @XML.value('(/GeocodeResponse/result/address_component[type="administrative_area_level_1"]/short_name) [1]', 'NVARCHAR(40)') 
 SET @PostalCode = @XML.value('(/GeocodeResponse/result/address_component[type="postal_code"]/long_name) [1]', 'NVARCHAR(20)') 
 SET @Country = @XML.value('(/GeocodeResponse/result/address_component[type="country"]/short_name) [1]', 'NVARCHAR(40)') 
 SET @County = @XML.value('(/GeocodeResponse/result/address_component[type="administrative_area_level_2"]/short_name) [1]', 'NVARCHAR(40)') 

 SET @Address = 
 ISNULL(@XML.value('(/GeocodeResponse/result/address_component[type="street_number"]/long_name) [1]', 'NVARCHAR(40)'), '???') + ' ' +
 ISNULL(@XML.value('(/GeocodeResponse/result/address_component[type="route"]/long_name) [1]', 'NVARCHAR(40)'), '???') 
 SET @MapURL = 'http://maps.google.com/maps?f=q&hl=en&q=' + CAST(@GPSLatitude AS NVARCHAR(20)) + '+' + CAST(@GPSLongitude AS NVARCHAR(20))


 Insert into @GEOinfo
  (
	GPSAddress   ,
	GPSCity     ,
	GPSState     ,
	GPSCountry    ,
	GPSPostalCode    ,
	GPSCounty    ,
	GPSLatitude    ,
	GPSLongitude    ,
	GPSMapURL   
	 
 )
 VALUES
 (
 @Address,
 @City,
 @State,
 @Country,
 @PostalCode,
 @County,
 @GPSLatitude,
 @GPSLongitude,
 @MapURL 
  
 )


	RETURN 
END
