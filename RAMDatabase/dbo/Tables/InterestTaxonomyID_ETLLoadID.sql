CREATE TABLE [dbo].[InterestTaxonomyID_ETLLoadID] (
    [ETLLoadID_InterestTaxonomyID] INT      IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]                    INT      NOT NULL,
    [InterestTaxonomyID]           INT      NOT NULL,
    [ChangedDate]                  DATETIME NULL,
    [CreatedDate]                  DATETIME CONSTRAINT [DF_InterestTaxonomyID_ETLLoadID_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_InterestTaxonomyID_ETLLoadID] PRIMARY KEY CLUSTERED ([ETLLoadID_InterestTaxonomyID] ASC),
    CONSTRAINT [FK_InterestTaxonomyID_ETLLoadID_InterestTaxonomy] FOREIGN KEY ([InterestTaxonomyID]) REFERENCES [dbo].[InterestTaxonomy] ([InterestTaxonomyID]),
    CONSTRAINT [FK_InterestTaxonomyID_ETLLoadID_TaxonomyRAW] FOREIGN KEY ([ETLLoadID]) REFERENCES [dbo].[TaxonomyRAW] ([ETLLoadID]),
    CONSTRAINT [IX_InterestTaxonomyID_ETLLoadID] UNIQUE NONCLUSTERED ([ETLLoadID] ASC, [InterestTaxonomyID] ASC)
);

