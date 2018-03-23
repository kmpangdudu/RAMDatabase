CREATE TABLE [dbo].[ETLLoadID_TaxonomyCode] (
    [ETLLoadID_TaxonomyCode_ID] INT           IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]                 INT           NULL,
    [TaxonomyCode]              NVARCHAR (50) NULL,
    [ChangedDate]               DATETIME      NULL,
    [CreateDate]                DATETIME      CONSTRAINT [DF_ETLLoadID_TaxonomyCode_CreateDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ETLLoadID_TaxonomyCode] PRIMARY KEY CLUSTERED ([ETLLoadID_TaxonomyCode_ID] ASC),
    CONSTRAINT [FK_ETLLoadID_TaxonomyCode_ProgramRAW] FOREIGN KEY ([ETLLoadID]) REFERENCES [dbo].[ProgramRAW] ([ETLLoadID])
);

