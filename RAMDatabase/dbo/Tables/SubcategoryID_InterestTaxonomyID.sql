CREATE TABLE [dbo].[SubcategoryID_InterestTaxonomyID] (
    [SubcategoryID_InterestTaxonomyID] INT      IDENTITY (1, 1) NOT NULL,
    [SubCategoryID]                    INT      NOT NULL,
    [InterestTaxonomyID]               INT      NOT NULL,
    [Active]                           BIT      NULL,
    [ChangedDate]                      DATETIME NULL,
    [CreatedDate]                      DATETIME CONSTRAINT [DF_SubcategoryID_TaxonomyID_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SubcategoryID_TaxonomyID] PRIMARY KEY CLUSTERED ([SubcategoryID_InterestTaxonomyID] ASC),
    CONSTRAINT [FK_SubcategoryID_TaxonomyID_InterestTaxonomy] FOREIGN KEY ([InterestTaxonomyID]) REFERENCES [dbo].[InterestTaxonomy] ([InterestTaxonomyID]),
    CONSTRAINT [FK_SubcategoryID_TaxonomyID_SubCategory] FOREIGN KEY ([SubCategoryID]) REFERENCES [dbo].[SubCategory] ([SubCategoryID]),
    CONSTRAINT [IX_SubcategoryID_TaxonomyID] UNIQUE NONCLUSTERED ([SubCategoryID] ASC, [InterestTaxonomyID] ASC)
);

