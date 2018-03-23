CREATE TABLE [yos].[Classification_KHPCategory] (
    [ID]               INT      IDENTITY (1, 1) NOT NULL,
    [classificationID] INT      NOT NULL,
    [KHPCategoryID]    INT      NOT NULL,
    [ChangedDate]      DATETIME NULL,
    [CreatedDate]      DATETIME CONSTRAINT [DF_Classification_KHPCategory_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_Classification_KHPCategory] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_Classification_KHPCategory_Classification] FOREIGN KEY ([classificationID]) REFERENCES [dbo].[Classification] ([classificationID]),
    CONSTRAINT [FK_Classification_KHPCategory_KHPCategory] FOREIGN KEY ([KHPCategoryID]) REFERENCES [yos].[KHPCategory] ([KHPCategoryID])
);

