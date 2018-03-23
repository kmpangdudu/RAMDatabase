CREATE TABLE [yos].[KHPCategory] (
    [KHPCategoryID]          INT             NOT NULL,
    [KHPCategory]            NVARCHAR (2000) NULL,
    [KHPCategoryDesc]        NVARCHAR (2000) NULL,
    [HumanServiceTaxonomyID] INT             NULL,
    [KHPCategoryFr]          NVARCHAR (2000) NULL,
    [ImageSrc]               NVARCHAR (255)  NULL,
    [Active]                 BIT             NULL,
    [changedDate]            DATETIME        NULL,
    [createdDate]            DATETIME        CONSTRAINT [DF_Category_createdDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([KHPCategoryID] ASC)
);

