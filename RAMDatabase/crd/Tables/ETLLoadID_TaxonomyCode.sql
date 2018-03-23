CREATE TABLE [crd].[ETLLoadID_TaxonomyCode] (
    [ETLLoadID_TaxonomyCode_ID] INT           IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]                 INT           NULL,
    [TaxonomyCode]              NVARCHAR (50) NULL,
    [EnteredOn]                 DATETIME      NULL,
    [UpdatedOn]                 DATETIME      NULL,
    [ChangedDate]               DATETIME      NULL,
    [CreateDate]                DATETIME      CONSTRAINT [DF_ETLLoadID_TaxonomyCode_CreateDate_1] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ETLLoadID_TaxonomyCode_1] PRIMARY KEY CLUSTERED ([ETLLoadID_TaxonomyCode_ID] ASC)
);

