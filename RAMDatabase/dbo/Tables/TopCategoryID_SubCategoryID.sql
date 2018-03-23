CREATE TABLE [dbo].[TopCategoryID_SubCategoryID] (
    [TopCategoryID_SubCategoryID] INT      IDENTITY (1, 1) NOT NULL,
    [TopCategoryID]               INT      NOT NULL,
    [SubCategoryID]               INT      NOT NULL,
    [Active]                      BIT      NULL,
    [ChangedDate]                 DATETIME NULL,
    [CreatedDate]                 DATETIME CONSTRAINT [DF_TopCategoryID_SubCategoryID_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_TopCategoryID_SubCategoryID] PRIMARY KEY CLUSTERED ([TopCategoryID_SubCategoryID] ASC),
    CONSTRAINT [FK_TopCategoryID_SubCategoryID_SubCategory] FOREIGN KEY ([SubCategoryID]) REFERENCES [dbo].[SubCategory] ([SubCategoryID]),
    CONSTRAINT [FK_TopCategoryID_SubCategoryID_TopCategory] FOREIGN KEY ([TopCategoryID]) REFERENCES [dbo].[TopCategory] ([TopCategoryID]),
    CONSTRAINT [IX_TopCategoryID_SubCategoryID] UNIQUE NONCLUSTERED ([SubCategoryID] ASC, [TopCategoryID] ASC)
);

