CREATE TABLE [yos].[KHPETLLoadID_InterestTaxonomyCode_CategoryID] (
    [id]                      INT           IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]               INT           NULL,
    [KHPInterestTaxonomyCode] NVARCHAR (50) NULL,
    [KHPCategoryID]           INT           NULL,
    [changedDate]             DATETIME      NULL,
    [CreateDate]              DATETIME      CONSTRAINT [DF_KHPETLLoadID_InterestTaxonomyCode_CategoryID_CreateDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_KHPETLLoadID_InterestTaxonomyCode_CategoryID] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [FK_KHPETLLoadID_InterestTaxonomyCode_CategoryID_KHPCategory] FOREIGN KEY ([KHPCategoryID]) REFERENCES [yos].[KHPCategory] ([KHPCategoryID])
);

