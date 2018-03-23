CREATE TABLE [dbo].[TaxonomyLevelName] (
    [TaxonomyLevelNameID]          INT             NOT NULL,
    [TaxonomyLevelName]            NVARCHAR (50)   NULL,
    [TaxonomyLevelNameDesc]        NVARCHAR (2000) NULL,
    [TaxonomyLevelNameChangedDate] DATETIME        NULL,
    [TaxonomyLevelNameCreateDate]  DATETIME        NULL,
    CONSTRAINT [PK_TaxonomyLevelName] PRIMARY KEY CLUSTERED ([TaxonomyLevelNameID] ASC)
);

