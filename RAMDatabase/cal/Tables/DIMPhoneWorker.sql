CREATE TABLE [cal].[DIMPhoneWorker] (
    [DIMPhoneWorker_ID]          BIGINT         IDENTITY (1, 1) NOT NULL,
    [DIMPhoneWorker_Num]         BIGINT         NULL,
    [DIMPhoneWorker_Name]        NVARCHAR (255) NULL,
    [DIMPhoneWorker_active]      BIT            CONSTRAINT [DF_DIMPhoneWorker_active] DEFAULT ((1)) NULL,
    [DIMPhoneWorker_startdate]   DATETIME       CONSTRAINT [DF_DIMPhoneWorker_startdate] DEFAULT (getdate()) NULL,
    [DIMPhoneWorker_enddate]     DATETIME       CONSTRAINT [DF_DIMPhoneWorker_enddate] DEFAULT ('9999-12-31') NULL,
    [DIMPhoneWorker_changeddate] DATETIME       NULL,
    [DIMPhoneWorker_createddate] DATETIME       CONSTRAINT [DF_DIMPhoneWorker_createddate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIMPhoneWorker] PRIMARY KEY CLUSTERED ([DIMPhoneWorker_ID] ASC)
);

