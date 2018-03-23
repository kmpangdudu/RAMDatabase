CREATE TABLE [dbo].[TopCategory] (
    [TopCategoryID]      INT             IDENTITY (1, 1) NOT NULL,
    [TopCategory]        NVARCHAR (255)  NOT NULL,
    [TopCategoryAlias]   NVARCHAR (255)  NULL,
    [TopCategoryDesc]    NVARCHAR (2000) NULL,
    [TopCategory_fr]     NVARCHAR (255)  NULL,
    [TopCategoryDesc_fr] NVARCHAR (2000) NULL,
    [Active]             BIT             CONSTRAINT [DF_TopCategory_Active] DEFAULT ((1)) NOT NULL,
    [ChangedDate]        DATETIME        NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_TopCategory_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_TopCategory] PRIMARY KEY CLUSTERED ([TopCategoryID] ASC),
    CONSTRAINT [IX_TopCategory] UNIQUE NONCLUSTERED ([TopCategory] ASC)
);

