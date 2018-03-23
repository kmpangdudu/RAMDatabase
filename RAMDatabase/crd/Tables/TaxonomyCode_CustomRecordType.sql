CREATE TABLE [crd].[TaxonomyCode_CustomRecordType] (
    [TaxonomyCode_CustomRecordTypeID] INT            IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]                       INT            NULL,
    [TaxonomyCode]                    NVARCHAR (255) NULL,
    [CustomRecordType]                NVARCHAR (255) NULL,
    [EnteredOn]                       DATETIME       NULL,
    [UpdatedOn]                       DATETIME       NULL,
    [ChangedDate]                     DATETIME       NULL,
    [CreatedDate]                     DATETIME       CONSTRAINT [DF_TaxonomyCode_CustomRecordTypeI_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_TaxonomyCode_CustomRecordTypeI] PRIMARY KEY CLUSTERED ([TaxonomyCode_CustomRecordTypeID] ASC)
);

