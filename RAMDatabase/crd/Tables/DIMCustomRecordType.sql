CREATE TABLE [crd].[DIMCustomRecordType] (
    [DIMCustomRecordType_ID]          INT            IDENTITY (1, 1) NOT NULL,
    [DIMCustomRecordType_Name]        NVARCHAR (255) NULL,
    [DIMCustomRecordType_Active]      BIT            CONSTRAINT [DF_DIMCustomRecordType_DIMCustomRecordType_Active] DEFAULT ((1)) NULL,
    [DIMCustomRecordType_StartDate]   DATETIME       CONSTRAINT [DF_DIMCustomRecordType_DIMCustomRecordType_StartDate] DEFAULT (getdate()) NULL,
    [DIMCustomRecordType__EndDate]    DATETIME       CONSTRAINT [DF_DIMCustomRecordType_DIMCustomRecordType__EndDate] DEFAULT ('9999-12-31') NULL,
    [DIMCustomRecordType_ChangedDate] DATETIME       NULL,
    [DIMCustomRecordType_CreatedDate] DATETIME       CONSTRAINT [DF_DIMCustomRecordType_DIMCustomRecordType_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIMCustomRecordType] PRIMARY KEY CLUSTERED ([DIMCustomRecordType_ID] ASC)
);

