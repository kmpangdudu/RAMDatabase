CREATE TABLE [dbo].[SuggestionWord] (
    [SuggestionWordID] INT            IDENTITY (1, 1) NOT NULL,
    [SuggestionWord]   NVARCHAR (500) NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_SuggestionWord_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_SuggestionWord] PRIMARY KEY CLUSTERED ([SuggestionWordID] ASC)
);

