CREATE TABLE [survey].[surveyanswer] (
    [surveyAnswer_ID]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [surveyQuestion_ID]        INT             NULL,
    [chatID]                   BIGINT          NULL,
    [surveyAnswer]             NVARCHAR (MAX)  NULL,
    [language]                 NVARCHAR (50)   CONSTRAINT [DF_surveyanswer_language] DEFAULT ('en') NULL,
    [surveyAnswer_Device]      NVARCHAR (1000) NULL,
    [surveyAnswer_CreatedDate] DATETIME        CONSTRAINT [DF_surveyanswer_surveyAnswer_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_surveyanswer] PRIMARY KEY CLUSTERED ([surveyAnswer_ID] ASC),
    CONSTRAINT [FK_surveyanswer_surveyQuestion] FOREIGN KEY ([surveyQuestion_ID]) REFERENCES [survey].[surveyQuestion] ([surveyQuestion_ID])
);

