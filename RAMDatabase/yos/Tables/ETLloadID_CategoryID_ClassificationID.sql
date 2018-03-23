CREATE TABLE [yos].[ETLloadID_CategoryID_ClassificationID] (
    [id]               INT      IDENTITY (1, 1) NOT NULL,
    [ETLloadID]        INT      NULL,
    [KHPcategoryID]    INT      NULL,
    [ClassificationID] INT      NULL,
    [KHPTaxonomyID]    INT      NULL,
    [changeddate]      DATETIME NULL,
    [createddate]      DATETIME CONSTRAINT [DF_ETLloadID_CategoryID_ClassificationID_createddate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ETLloadID_CategoryID_ClassificationID] PRIMARY KEY CLUSTERED ([id] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_ETLloadID_CategoryID_ClassificationID_ETLloadID (ASC)]
    ON [yos].[ETLloadID_CategoryID_ClassificationID]([ETLloadID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ETLloadID_CategoryID_ClassificationID_KHPcategoryID (ASC)]
    ON [yos].[ETLloadID_CategoryID_ClassificationID]([KHPcategoryID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ETLloadID_CategoryID_ClassificationID_ClassificationID (ASC)]
    ON [yos].[ETLloadID_CategoryID_ClassificationID]([ClassificationID] ASC);

