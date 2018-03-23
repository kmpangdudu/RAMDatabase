CREATE TABLE [dbo].[KeyWords] (
    [KeywordID]         INT             IDENTITY (1, 1) NOT NULL,
    [ETLLoadiD]         INT             NULL,
    [PublicName]        NVARCHAR (2000) NULL,
    [AgencyDescription] NVARCHAR (MAX)  NULL,
    [PhysicalAddress]   NVARCHAR (2000) NULL,
    [PhysicalCity]      NVARCHAR (500)  NULL,
    [PhysicalProvince]  NVARCHAR (50)   NULL,
    [TaxonomyTerm]      NVARCHAR (2000) NULL,
    [TaxonomyTerms]     NVARCHAR (2000) NULL,
    [TopCategory]       NVARCHAR (500)  NULL,
    [TopCategory_fr]    NVARCHAR (500)  NULL,
    [SubCategory]       NVARCHAR (500)  NULL,
    [SubCategory_fr]    NVARCHAR (500)  NULL,
    [Coverage]          NVARCHAR (MAX)  NULL,
    [Eligibility]       NVARCHAR (2000) NULL,
    [CreatedDate]       DATETIME        CONSTRAINT [DF_KeyWords_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_KeyWords_1] PRIMARY KEY CLUSTERED ([KeywordID] ASC)
);

