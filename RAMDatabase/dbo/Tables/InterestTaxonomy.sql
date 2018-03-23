CREATE TABLE [dbo].[InterestTaxonomy] (
    [InterestTaxonomyID]       INT             NOT NULL,
    [InterestTaxonomyDelivery] NVARCHAR (50)   CONSTRAINT [DF_InterestTaxonomy_InterestTaxonomyDelivery] DEFAULT (N'List') NULL,
    [InterestTaxonomyCode]     NVARCHAR (50)   NOT NULL,
    [InterestTaxonomyTerms]    NVARCHAR (500)  NULL,
    [InterestTaxonomyDesc]     NVARCHAR (1000) NULL,
    [Active]                   BIT             CONSTRAINT [DF_InterestTaxonomy_Active] DEFAULT ((1)) NOT NULL,
    [Phase]                    INT             CONSTRAINT [DF_InterestTaxonomy_Phase] DEFAULT ((1)) NOT NULL,
    [changedDate]              DATETIME        NULL,
    [createdDate]              DATETIME        CONSTRAINT [DF_InterestTaxonomy_createdDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_InterestTaxonomy] PRIMARY KEY CLUSTERED ([InterestTaxonomyID] ASC),
    CONSTRAINT [IX_InterestTaxonomy] UNIQUE NONCLUSTERED ([InterestTaxonomyCode] ASC)
);

