CREATE TABLE [dbo].[Combine_Categories] (
    [CombinID]    INT            IDENTITY (1, 1) NOT NULL,
    [CategoryID]  NVARCHAR (50)  NULL,
    [Category]    NVARCHAR (255) NULL,
    [Category_fr] NVARCHAR (255) NULL,
    [CreatedDate] DATETIME       CONSTRAINT [DF_Combine_Categories_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Combin_Categories] PRIMARY KEY CLUSTERED ([CombinID] ASC)
);

