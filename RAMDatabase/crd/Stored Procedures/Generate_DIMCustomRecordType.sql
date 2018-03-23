-- ===================================================================
-- Author:		William Chen
-- Create date: 2017-10-25
-- Description:	Generate Dimension Table DIMCustomRecordType
-- ===================================================================
CREATE Procedure [CRD].[Generate_DIMCustomRecordType] 
	-- Add the parameters for the stored procedure here

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

TRUNCATE TABLE [crd].[DIMCustomRecordType] ;
insert into    [crd].[DIMCustomRecordType] ([DIMCustomRecordType_Name])
 select distinct ltrim(rtrim(f.CustomRecordType))  as CustomRecordType  
 from ETLLoad as p outer apply  [crd].[F_CustomRecordType](p.etlloadid) as f where f.CustomRecordType is not null

END
