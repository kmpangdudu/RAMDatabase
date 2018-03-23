CREATE TABLE [dbo].[Coverage] (
    [ID]           INT             IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]    INT             NULL,
    [Coverage]     NVARCHAR (500)  NULL,
    [CoverageDesc] NVARCHAR (1000) NULL,
    [ChangedDate]  DATETIME        NULL,
    [CreateDate]   DATETIME        CONSTRAINT [DF_Coverage_CreateDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Coverage] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Coverage_TaxonomyRAW] FOREIGN KEY ([ETLLoadID]) REFERENCES [dbo].[TaxonomyRAW] ([ETLLoadID])
);

