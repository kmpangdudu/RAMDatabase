-- ==========================================================================================
-- Author:		<Author,,Name>
-- Create date: 2017-10-06
-- Description:	Gerenate all taxonomy Code from community resource database
-- Kristen, IR team request
-- ==========================================================================================
CREATE PROCEDURE [crd].[Generate_TaxonomyCode] 

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
TRUNCATE TABLE [crd].[DIMTaxonomyCode] ;
insert into   [crd].[DIMTaxonomyCode] ([DIMTaxonomyCode_Name])
 select distinct ltrim(rtrim(f.TaxonomyCode))  as TaxonomyCode  
 from ETLLoad as p outer apply  [dbo].[F_taxonomyCode](p.etlloadid) as f where f.TaxonomyCode is not null
END
