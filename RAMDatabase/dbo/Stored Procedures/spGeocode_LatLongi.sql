-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[spGeocode_LatLongi]
@Address varchar(80) = NULL OUTPUT,
@City varchar(40) = NULL OUTPUT,
@State varchar(40) = NULL OUTPUT,
@Country varchar(40) = NULL OUTPUT,
@PostalCode varchar(20) = NULL OUTPUT,

@County varchar(40) = NULL OUTPUT,

@GPSLatitude numeric(9,6) OUTPUT,
@GPSLongitude numeric(9,6)  OUTPUT,
@MapURL varchar(1024) = NULL OUTPUT

AS
BEGIN
 SET NOCOUNT ON

DECLARE @URL varchar(MAX)
 SET @URL = 'http://maps.google.com/maps/api/geocode/xml?sensor=false&address=' + convert(varchar(50),@GPSLatitude ) +','+ convert(varchar(50),@GPSLongitude)
 
 print @URL

 DECLARE @Response varchar(8000)
 DECLARE @XML xml
 DECLARE @Obj int 
 DECLARE @Result int 
 DECLARE @HTTPStatus int 
 DECLARE @ErrorMsg varchar(MAX)

EXEC @Result = sp_OACreate 'MSXML2.ServerXMLHttp', @Obj OUT 

 BEGIN TRY
 EXEC @Result = sp_OAMethod @Obj, 'open', NULL, 'GET', @URL, false
 EXEC @Result = sp_OAMethod @Obj, 'setRequestHeader', NULL, 'Content-Type', 'application/x-www-form-urlencoded'
 EXEC @Result = sp_OAMethod @Obj, send, NULL, ''
 EXEC @Result = sp_OAGetProperty @Obj, 'status', @HTTPStatus OUT 
 EXEC @Result = sp_OAGetProperty @Obj, 'responseXML.xml', @Response OUT 
 END TRY
 BEGIN CATCH
 SET @ErrorMsg = ERROR_MESSAGE()
 END CATCH

 EXEC @Result = sp_OADestroy @Obj

IF (@ErrorMsg IS NOT NULL) OR (@HTTPStatus <> 200) BEGIN
 SET @ErrorMsg = 'Error in spGeocode: ' + ISNULL(@ErrorMsg, 'HTTP result is: ' + CAST(@HTTPStatus AS varchar(10)))
 RAISERROR(@ErrorMsg, 16, 1, @HTTPStatus)
 RETURN 
 END

SET @XML = CAST(@Response AS XML)

 SET @GPSLatitude = @XML.value('(/GeocodeResponse/result/geometry/location/lat) [1]', 'numeric(9,6)')
 SET @GPSLongitude = @XML.value('(/GeocodeResponse/result/geometry/location/lng) [1]', 'numeric(9,6)')

SET @City = @XML.value('(/GeocodeResponse/result/address_component[type="locality"]/long_name) [1]', 'varchar(40)') 
 SET @State = @XML.value('(/GeocodeResponse/result/address_component[type="administrative_area_level_1"]/short_name) [1]', 'varchar(40)') 
 SET @PostalCode = @XML.value('(/GeocodeResponse/result/address_component[type="postal_code"]/long_name) [1]', 'varchar(20)') 
 SET @Country = @XML.value('(/GeocodeResponse/result/address_component[type="country"]/short_name) [1]', 'varchar(40)') 
 SET @County = @XML.value('(/GeocodeResponse/result/address_component[type="administrative_area_level_2"]/short_name) [1]', 'varchar(40)') 

 SET @Address = 
 ISNULL(@XML.value('(/GeocodeResponse/result/address_component[type="street_number"]/long_name) [1]', 'varchar(40)'), '???') + ' ' +
 ISNULL(@XML.value('(/GeocodeResponse/result/address_component[type="route"]/long_name) [1]', 'varchar(40)'), '???') 
 SET @MapURL = 'http://maps.google.com/maps?f=q&hl=en&q=' + CAST(@GPSLatitude AS varchar(20)) + '+' + CAST(@GPSLongitude AS varchar(20))


 SELECT 
 @GPSLatitude AS GPSLatitude,
 @GPSLongitude AS GPSLongitude,
 @City AS City,
 @State AS [State],
 @PostalCode AS PostalCode,
 @Address AS [Address],
 @County AS County,
 @MapURL AS MapURL,
 @XML AS XMLResults

END
