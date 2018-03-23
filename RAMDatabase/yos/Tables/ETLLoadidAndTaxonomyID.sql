CREATE TABLE [yos].[ETLLoadidAndTaxonomyID] (
    [id]            BIGINT   IDENTITY (1, 1) NOT NULL,
    [etlloadid]     BIGINT   NULL,
    [KHPTaxonomyID] INT      NULL,
    [createdDate]   DATETIME CONSTRAINT [DF_ETLLoadidAndTaxonomyID_createdDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ETLLoadidAndTaxonomyID] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [IX_ETLLoadidAndTaxonomyID] UNIQUE NONCLUSTERED ([etlloadid] ASC, [KHPTaxonomyID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ETLLoadidAndTaxonomyID_ETLLOADID]
    ON [yos].[ETLLoadidAndTaxonomyID]([etlloadid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ETLLoadidAndTaxonomyID_KHPTaxonomyID]
    ON [yos].[ETLLoadidAndTaxonomyID]([KHPTaxonomyID] ASC);

