CREATE TABLE [dbo].[Stopwords] (
    [id]          INT           IDENTITY (1, 1) NOT NULL,
    [stopword]    NVARCHAR (50) NULL,
    [language]    NVARCHAR (50) CONSTRAINT [DF_Stopwords_language] DEFAULT (N'Neutral') NULL,
    [lcid]        INT           CONSTRAINT [DF_Stopwords_lcid] DEFAULT ((0)) NULL,
    [changedDate] DATETIME      NULL,
    [createDate]  DATETIME      CONSTRAINT [DF_Stopwords_createDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Stopwords] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [CHK_language_lcid] CHECK ([language]='Neutral' AND [lcid]=(0) OR [language]='English' AND [lcid]=(1033) OR [language]='French' AND [lcid]=(1036)),
    CONSTRAINT [IX_Stopwords] UNIQUE NONCLUSTERED ([id] ASC)
);

