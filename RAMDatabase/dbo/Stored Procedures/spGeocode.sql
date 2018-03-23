-- =============================================
-- Author:		William Chen 
-- Create date: Nov.21, 2015
-- Description:	input any of @Address,@City,@State,@Country,@PostalCode,@County,@GPSLatitude, @GPSLongitude
--    then get all of reminding
--  输入 一个信息，返回其他的信息 
-- 例如：  输入@Address， 返回 @City,@State,@Country,@PostalCode,@County,@GPSLatitude, @GPSLongitude
-- 不支持 VARCHAR（MAX），NVARCHAR（MAX），必须写成VARCHAR（8000），NVARCHAR（4000）
-- =============================================
CREATE PROCEDURE [dbo].[spGeocode]
@Address NVARCHAR(80) = NULL OUTPUT,
@City NVARCHAR(40) = NULL OUTPUT,
@State NVARCHAR(40) = NULL OUTPUT,
@Country NVARCHAR(40) = NULL OUTPUT,
@PostalCode NVARCHAR(20) = NULL OUTPUT,
@County NVARCHAR(40) = NULL OUTPUT,
@GPSLatitude NUMERIC(9,6) = NULL OUTPUT,
@GPSLongitude NUMERIC(9,6) = NULL OUTPUT,
@MapURL NVARCHAR(1024) = NULL OUTPUT

AS
BEGIN
 SET NOCOUNT ON

DECLARE @URL NVARCHAR(4000)
 SET @URL = 'http://maps.google.com/maps/api/geocode/xml?sensor=false&address='  

DECLARE @PARA NVARCHAR(4000) 
 SELECT @PARA = 
 CASE WHEN @Address IS NOT NULL THEN @Address ELSE '' END +
 CASE WHEN @City IS NOT NULL THEN ' ' + @City ELSE '' END +
 CASE WHEN @State IS NOT NULL THEN ' ' + @State ELSE '' END +
 CASE WHEN @Country IS NOT NULL THEN ' ' + @Country ELSE '' END  +
 CASE WHEN @PostalCode IS NOT NULL THEN ' ' + @PostalCode ELSE '' END +
 CASE WHEN @County IS NOT NULL THEN ' ' + @County ELSE '' END  +
 CASE WHEN @GPSLatitude IS NOT NULL THEN ' ' + Convert(NVARCHAR(50),@GPSLatitude) ELSE '' END  +
 CASE WHEN @GPSLongitude IS NOT NULL THEN ' ' + Convert(NVARCHAR(50),@GPSLongitude) ELSE '' END  
 
 SELECT @PARA = LTRIM(RTRIM(@PARA));
 SELECT @URL = @URL + @PARA;
 SET @URL = REPLACE(@URL, ' ', '+')
 print @URL
 DECLARE @Response NVARCHAR(4000)
 DECLARE @XML xml
 DECLARE @Obj int 
 DECLARE @Result int 
 DECLARE @HTTPStatus int 
 DECLARE @ErrorMsg NVARCHAR(4000)

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
 SET @ErrorMsg = 'Error in spGeocode: ' + ISNULL(@ErrorMsg, 'HTTP result is: ' + CAST(@HTTPStatus AS NVARCHAR(10)))
 RAISERROR(@ErrorMsg, 16, 1, @HTTPStatus)
 RETURN 
 END

SET @XML = CAST(@Response AS XML)

 SET @GPSLatitude = @XML.value('(/GeocodeResponse/result/geometry/location/lat) [1]', 'NUMERIC(9,6)')
 SET @GPSLongitude = @XML.value('(/GeocodeResponse/result/geometry/location/lng) [1]', 'NUMERIC(9,6)')

SET @City = @XML.value('(/GeocodeResponse/result/address_component[type="locality"]/long_name) [1]', 'NVARCHAR(40)') 
 SET @State = @XML.value('(/GeocodeResponse/result/address_component[type="administrative_area_level_1"]/short_name) [1]', 'NVARCHAR(40)') 
 SET @PostalCode = @XML.value('(/GeocodeResponse/result/address_component[type="postal_code"]/long_name) [1]', 'NVARCHAR(20)') 
 SET @Country = @XML.value('(/GeocodeResponse/result/address_component[type="country"]/short_name) [1]', 'NVARCHAR(40)') 
 SET @County = @XML.value('(/GeocodeResponse/result/address_component[type="administrative_area_level_2"]/short_name) [1]', 'NVARCHAR(40)') 

 SET @Address = 
 ISNULL(@XML.value('(/GeocodeResponse/result/address_component[type="street_number"]/long_name) [1]', 'NVARCHAR(40)'), '???') + ' ' +
 ISNULL(@XML.value('(/GeocodeResponse/result/address_component[type="route"]/long_name) [1]', 'NVARCHAR(40)'), '???') 
 SET @MapURL = 'http://maps.google.com/maps?f=q&hl=en&q=' + CAST(@GPSLatitude AS NVARCHAR(20)) + '+' + CAST(@GPSLongitude AS NVARCHAR(20))


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
