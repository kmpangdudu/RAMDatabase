CREATE TABLE [yos].[KHPCategoryID_KHPInterestTaxonomyCode] (
    [CategoryIDKHPTaxonomyCodeID] INT            NOT NULL,
    [CategoryID]                  INT            NULL,
    [KHPInterestTaxonomyCode]     NVARCHAR (50)  NULL,
    [Desc]                        NVARCHAR (255) NULL,
    [Active]                      BIT            NULL,
    [Phase]                       NVARCHAR (50)  NULL,
    [changedDate]                 DATETIME       NULL,
    [createddate]                 DATETIME       CONSTRAINT [DF_KHPCategoryID_TaxonomyCode_createddate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_KHPCategoryID_TaxonomyCode] PRIMARY KEY CLUSTERED ([CategoryIDKHPTaxonomyCodeID] ASC),
    CONSTRAINT [FK_KHPCategoryID_KHPInterestTaxonomyCode_KHPCategory] FOREIGN KEY ([CategoryID]) REFERENCES [yos].[KHPCategory] ([KHPCategoryID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_KHPCategoryID_TaxonomyCode]
    ON [yos].[KHPCategoryID_KHPInterestTaxonomyCode]([CategoryID] ASC, [KHPInterestTaxonomyCode] ASC);

