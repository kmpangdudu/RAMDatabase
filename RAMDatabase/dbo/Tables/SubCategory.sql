CREATE TABLE [dbo].[SubCategory] (
    [SubCategoryID]      INT             IDENTITY (1, 1) NOT NULL,
    [SubCategory]        NVARCHAR (255)  NOT NULL,
    [SubCategoryDesc]    NVARCHAR (2000) NULL,
    [SubCategory_fr]     NVARCHAR (255)  NULL,
    [SubCategoryDesc_fr] NVARCHAR (2000) NULL,
    [Active]             BIT             CONSTRAINT [DF_SubCategory_Active] DEFAULT ((1)) NOT NULL,
    [changedDate]        DATETIME        NULL,
    [CreatedDate]        DATETIME        CONSTRAINT [DF_SubCategory_CreatedDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED ([SubCategoryID] ASC)
);

