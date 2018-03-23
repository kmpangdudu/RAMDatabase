CREATE TABLE [yos].[ETLLoadIDAndKHPCategoryID] (
    [id]            INT      IDENTITY (1, 1) NOT NULL,
    [etlloadid]     BIGINT   NULL,
    [KHPCategoryID] INT      NULL,
    [CreatedDate]   DATETIME CONSTRAINT [DF_ETLLoadIDAndKHPCategoryID_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ETLLoadIDAndKHPCategoryID] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [IX_ETLLoadIDAndKHPCategoryID] UNIQUE NONCLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ETLLoadIDAndKHPCategoryID_etlloadid]
    ON [yos].[ETLLoadIDAndKHPCategoryID]([etlloadid] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ETLLoadIDAndKHPCategoryID_KHPCategoryID (ASC)]
    ON [yos].[ETLLoadIDAndKHPCategoryID]([KHPCategoryID] ASC);

