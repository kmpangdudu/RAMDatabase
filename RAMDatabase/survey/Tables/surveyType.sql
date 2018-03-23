CREATE TABLE [survey].[surveyType] (
    [surveyType_ID]          INT             IDENTITY (1, 1) NOT NULL,
    [surveyType]             NVARCHAR (255)  NULL,
    [surveryType_fr]         NCHAR (255)     NULL,
    [surveyDesc]             NVARCHAR (1000) NULL,
    [surveryDesc_fr]         NVARCHAR (1000) NULL,
    [surveyType_Active]      BIT             CONSTRAINT [DF_surveyType_surveyType_Active] DEFAULT ((1)) NULL,
    [surveyType_ChangedDate] DATETIME        NULL,
    [surveyType_CreatedDate] DATETIME        CONSTRAINT [DF_surveyType_surveyType_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_surveyType] PRIMARY KEY CLUSTERED ([surveyType_ID] ASC)
);

