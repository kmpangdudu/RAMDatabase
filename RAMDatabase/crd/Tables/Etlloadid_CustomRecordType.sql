CREATE TABLE [crd].[Etlloadid_CustomRecordType] (
    [Etlloadid_CustomRecordType_ID] INT            IDENTITY (1, 1) NOT NULL,
    [Etlloadid]                     INT            NULL,
    [CustomRecordType]              NVARCHAR (255) NULL,
    [EnteredOn]                     DATETIME       NULL,
    [UpdatedOn]                     DATETIME       NULL,
    [ChangedDate]                   DATETIME       NULL,
    [CreatedDate]                   DATETIME       CONSTRAINT [DF_Etlloadid_CustomRecordType_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Etlloadid_CustomRecordType] PRIMARY KEY CLUSTERED ([Etlloadid_CustomRecordType_ID] ASC)
);

