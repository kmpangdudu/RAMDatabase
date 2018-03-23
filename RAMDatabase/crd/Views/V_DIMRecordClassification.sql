
create view [crd].[V_DIMRecordClassification]
AS
SELECT        TaxonomyLevelNameID as [DIMRecordClassification_ID], 
CASE  
when TaxonomyLevelName = 'Program At Site' then 'ProgramAtSite'
else TaxonomyLevelName
end as RecordClassification
FROM            TaxonomyLevelName
where  TaxonomyLevelNameID <10
