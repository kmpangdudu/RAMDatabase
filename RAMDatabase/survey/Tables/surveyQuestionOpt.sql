CREATE TABLE [survey].[surveyQuestionOpt] (
    [surveyQuestionOptID]          INT             NOT NULL,
    [surveyQuestionID]             INT             NULL,
    [surveyQuestionOpt_en]         NVARCHAR (1000) NULL,
    [surveyQuestionOptDesc_en]     NVARCHAR (1000) NULL,
    [surveyQuestionOpt_fr]         NVARCHAR (1000) NULL,
    [surveyQuestionOptDesc_fr]     NVARCHAR (1000) NULL,
    [surveyQuestionOpt_Active]     BIT             CONSTRAINT [DF_surveyQuestionOpt_surveyQuestionOpt_Active] DEFAULT ((1)) NULL,
    [surveyQuestionOpt_CheangDate] DATETIME        NULL,
    [surveyQuestionOpt_CreateDate] DATETIME        CONSTRAINT [DF_surveyQuestionOpt_surveyQuestionOpt_CreateDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_surveyQuestionOpt] PRIMARY KEY CLUSTERED ([surveyQuestionOptID] ASC)
);

