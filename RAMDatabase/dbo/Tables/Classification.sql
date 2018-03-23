CREATE TABLE [dbo].[Classification] (
    [classificationID] INT            NOT NULL,
    [classification]   NVARCHAR (50)  NOT NULL,
    [Desc]             NVARCHAR (255) NULL,
    [Active]           BIT            CONSTRAINT [DF_Classification_Active] DEFAULT ((1)) NOT NULL,
    [type]             NVARCHAR (50)  NULL,
    [ChangedDate]      DATETIME       NULL,
    [createdate]       DATETIME       CONSTRAINT [DF_classification_createdate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_classification] PRIMARY KEY CLUSTERED ([classificationID] ASC)
);

