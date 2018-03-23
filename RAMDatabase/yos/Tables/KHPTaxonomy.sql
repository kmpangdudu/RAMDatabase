CREATE TABLE [yos].[KHPTaxonomy] (
    [KHPTaxonomyID]          INT             IDENTITY (1, 1) NOT NULL,
    [KHPCategoryID]          INT             NULL,
    [KHPTaxonomyCode]        NVARCHAR (50)   NULL,
    [KHPTaxonomyDesc]        NVARCHAR (2000) NULL,
    [KHPTaxonomyChangedDate] DATETIME        NULL,
    [KHPTaxonomyCreatedDate] DATETIME        CONSTRAINT [DF_KHPTaxonomy_KHPTaxonomyCreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_KHPTaxonomy] PRIMARY KEY CLUSTERED ([KHPTaxonomyID] ASC)
);

