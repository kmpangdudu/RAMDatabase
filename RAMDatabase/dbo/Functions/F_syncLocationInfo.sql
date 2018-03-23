-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[F_syncLocationInfo]
(
	-- Add the parameters for the function here
@id varchar(20)
)
RETURNS 
@result TABLE 
(etlloadid bigint 
,[ResourceAgencyNum] varchar(50)
,[PhysicalAddress1] varchar(2000)
,[PhysicalAddress2] varchar(2000)
,[PhysicalCityID] int
,[PhysicalCity] varchar(50)
,[PhysicalProvinceID] int
,[PhysicalStateProvince] varchar(50)
,[PhysicalPostalCode] varchar(50)
 ,latitude numeric(18,10) 
 ,longitude numeric(18,10) 
)
AS
BEGIN
declare @etlloadid bigint
declare @ResourceAgencyNum varchar(50)
declare @PhysicalAddress1 varchar(2000)
declare @PhysicalAddress2 varchar(2000)
declare @PhysicalCityID int
declare @PhysicalCity varchar(50)
declare @PhysicalProvinceID int
declare @PhysicalStateProvince varchar(50)
declare @PhysicalPostalCode varchar(50)
declare @latitude numeric(18,10) 
declare @longitude numeric(18,10) 
	select TOP(1)
		 @ResourceAgencyNum =  RTRIM(LTRIM(  ResourceAgencyNum   ))
		,@PhysicalAddress1 =RTRIM(LTRIM(ISNULL(PhysicalAddress1,'')))
		,@PhysicalAddress2 =RTRIM(LTRIM(ISNULL(PhysicalAddress2,'')))
		,@PhysicalCityID =PhysicalCityID
		,@PhysicalCity =RTRIM(LTRIM(  PhysicalCity))
		,@PhysicalProvinceID =PhysicalProvinceID
		,@PhysicalStateProvince =RTRIM(LTRIM(  PhysicalStateProvince))
		,@PhysicalPostalCode =RTRIM(LTRIM(  PhysicalPostalCode))
		,@latitude =latitude
		,@longitude =longitude
		from ramraw where ResourceAgencyNum = @id
		order by etlloadid



declare @L_etlloadid bigint
declare @L_ResourceAgencyNum varchar(50)
declare @L_PhysicalAddress1 varchar(2000)
declare @L_PhysicalAddress2 varchar(2000)
declare @L_PhysicalCityID int
declare @L_PhysicalCity varchar(50)
declare @L_PhysicalProvinceID int
declare @L_PhysicalStateProvince varchar(50)
declare @L_PhysicalPostalCode varchar(50)
declare @L_latitude numeric(18,10) 
declare @L_longitude numeric(18,10) 
	select TOP(1)
		 @L_etlloadid = etlloadid
		,@L_ResourceAgencyNum =   RTRIM(LTRIM(   ResourceAgencyNum   ))
		,@L_PhysicalAddress1 =RTRIM(LTRIM(ISNULL(PhysicalAddress1,'')))  
		,@L_PhysicalAddress2 =RTRIM(LTRIM(ISNULL(PhysicalAddress2,''))) 
		,@L_PhysicalCityID =PhysicalCityID
		,@L_PhysicalCity =RTRIM(LTRIM(  PhysicalCity))
		,@L_PhysicalProvinceID =PhysicalProvinceID
		,@L_PhysicalStateProvince =RTRIM(LTRIM(  PhysicalStateProvince))
		,@L_PhysicalPostalCode =RTRIM(LTRIM(  PhysicalPostalCode ))
		,@L_latitude =latitude
		,@L_longitude =longitude
		from ramraw where ResourceAgencyNum = @id
		order by etlloadid desc


declare @R_etlloadid bigint
declare @R_ResourceAgencyNum varchar(50)
declare @R_PhysicalAddress1 varchar(2000)
declare @R_PhysicalAddress2 varchar(2000)
declare @R_PhysicalCityID int
declare @R_PhysicalCity varchar(50)
declare @R_PhysicalProvinceID int
declare @R_PhysicalStateProvince varchar(50)
declare @R_PhysicalPostalCode varchar(50)
declare @R_latitude numeric(18,10) 
declare @R_longitude numeric(18,10) 


 
 select @R_PhysicalAddress1 = 
			case 
				when  @L_PhysicalAddress1 =  @PhysicalAddress1 then @PhysicalAddress1
				when  @PhysicalAddress1 is null and @L_PhysicalAddress1 is null then NULL
				when  @L_PhysicalAddress1 !=  @PhysicalAddress1 AND @PhysicalAddress1 is not null AND @L_PhysicalAddress1 is not null then 'Problem???'
				when  @L_PhysicalAddress1 is null  then   @PhysicalAddress1
				when  @PhysicalAddress1 is null  then  @L_PhysicalAddress1
			end

 select @R_PhysicalAddress2 = 
			case 
				when  @L_PhysicalAddress2 =  @PhysicalAddress2 then @PhysicalAddress2
				when  @PhysicalAddress2 is null and @L_PhysicalAddress2 is null then NULL
				when  @L_PhysicalAddress2 !=  @PhysicalAddress2 AND @PhysicalAddress2 is not null AND @L_PhysicalAddress2 is not null then 'Problem???'
				when  @L_PhysicalAddress2 is null  then   @PhysicalAddress2
				when  @PhysicalAddress2 is null  then  @L_PhysicalAddress2
			end

 select @R_PhysicalCityID = 
			case 
				when  @L_PhysicalCityID =  @PhysicalCityID then @PhysicalCityID
				when  @PhysicalCityID is null and @L_PhysicalCityID is null then NULL
				when  @L_PhysicalCityID !=  @PhysicalCityID AND @PhysicalCityID is not null AND @L_PhysicalCityID is not null then 0
				when  @L_PhysicalCityID is null  then   @PhysicalCityID
				when  @PhysicalCityID is null  then  @L_PhysicalCityID
			end

 select @R_PhysicalCity = 
			case 
				when  @L_PhysicalCity =  @PhysicalCity then @PhysicalCity
				when  @PhysicalCity is null and @L_PhysicalCity is null then NULL
				when  @L_PhysicalCity !=  @PhysicalCity AND @PhysicalCity is not null AND @L_PhysicalCity is not null then 'Problem???'
				when  @L_PhysicalCity is null  then   @PhysicalCity
				when  @PhysicalCity is null  then  @L_PhysicalCity
			end		 

 select @R_PhysicalProvinceID = 
			case 
				when  @L_PhysicalProvinceID =  @PhysicalProvinceID then @PhysicalProvinceID
				when  @PhysicalProvinceID is null and @L_PhysicalProvinceID is null then NULL
				when  @L_PhysicalProvinceID !=  @PhysicalProvinceID AND @PhysicalProvinceID is not null AND @L_PhysicalProvinceID is not null then 99
				when  @L_PhysicalProvinceID is null  then   @PhysicalProvinceID
				when  @PhysicalProvinceID is null  then  @L_PhysicalProvinceID
			end

 select @R_PhysicalStateProvince = 
			case 
				when  @L_PhysicalStateProvince =  @PhysicalStateProvince then @PhysicalStateProvince
				when  @PhysicalStateProvince is null and @L_PhysicalStateProvince is null then NULL
				when  @L_PhysicalStateProvince !=  @PhysicalStateProvince AND @PhysicalStateProvince is not null AND @L_PhysicalStateProvince is not null then 'Problem???'
				when  @L_PhysicalStateProvince is null  then   @PhysicalStateProvince
				when  @PhysicalStateProvince is null  then  @L_PhysicalStateProvince
			end

 select @R_PhysicalPostalCode = 
			case 
				when  @L_PhysicalPostalCode =  @PhysicalPostalCode then @PhysicalPostalCode
				when  @PhysicalPostalCode is null and @L_PhysicalPostalCode is null then NULL
				when  @L_PhysicalPostalCode !=  @PhysicalPostalCode AND @PhysicalPostalCode is not null AND @L_PhysicalPostalCode is not null then ''
				when  @L_PhysicalPostalCode is null  then   @PhysicalPostalCode
				when  @PhysicalPostalCode is null  then  @L_PhysicalPostalCode
			end

 select @R_latitude = 
			case 
				when  @L_latitude =  @latitude then @latitude
				when  @latitude =0.0  and  @L_latitude =0.0 then 0.0
				when  @L_latitude !=  @latitude AND @latitude =0.0 AND @L_latitude =0.0 then 0
				when  @L_latitude =0.0  then   @latitude
				when  @latitude =0.0  then  @L_latitude
			end


 select @R_longitude = 
			case 
				when  @L_longitude =  @longitude then @longitude
				when  @longitude =0.0 and @L_longitude= 0.0 then 0.0
				when  @L_longitude !=  @longitude AND @longitude !=0.0 AND @L_longitude !=0.0 then 0.0
				when  @L_longitude =0.0  then   @longitude
				when  @longitude =0.0  then  @L_longitude
			end




	insert into @result values(
								 @etlloadid
								,@id 
								,@R_PhysicalAddress1 
								,@R_PhysicalAddress2  
								,@R_PhysicalCityID  
								,@R_PhysicalCity  
								,@R_PhysicalProvinceID  
								,@R_PhysicalStateProvince  
								,@R_PhysicalPostalCode  
								,@R_latitude  
								,@R_longitude  
								)
								
	RETURN   
END
