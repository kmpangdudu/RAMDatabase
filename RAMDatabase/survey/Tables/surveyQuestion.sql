CREATE TABLE [survey].[surveyQuestion] (
    [surveyQuestion_ID]          INT             IDENTITY (1, 1) NOT NULL,
    [surveyTypeID]               INT             NULL,
    [surveyQuestion]             NVARCHAR (1000) NULL,
    [surveyQuestion_fr]          NCHAR (10)      NULL,
    [surveyQuestion_Desc]        NCHAR (10)      NULL,
    [surveyQuestion_Desc_fr]     NCHAR (10)      NULL,
    [surveyQuestion_active]      BIT             CONSTRAINT [DF_surveyQuestion_surveyQuestion_active] DEFAULT ((1)) NULL,
    [surveyQuestion_starton]     DATETIME        CONSTRAINT [DF_surveyQuestion_surveyQuestion_starton] DEFAULT (getdate()) NULL,
    [surveyQuestion_endon]       DATETIME        CONSTRAINT [DF_surveyQuestion_surveyQuestion_endon] DEFAULT ('9999-12-31') NULL,
    [surveyQuestion_changedDate] DATETIME        NULL,
    [surveyQuestion_CreatedDate] DATETIME        CONSTRAINT [DF_surveyQuestion_surveyQuestion_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_surveyQuestion] PRIMARY KEY CLUSTERED ([surveyQuestion_ID] ASC),
    CONSTRAINT [FK_surveyQuestion_surveyType] FOREIGN KEY ([surveyTypeID]) REFERENCES [survey].[surveyType] ([surveyType_ID])
);

