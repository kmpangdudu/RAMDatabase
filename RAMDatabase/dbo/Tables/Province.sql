CREATE TABLE [dbo].[Province] (
    [ProvinceID]     INT            NOT NULL,
    [Province]       NVARCHAR (255) NULL,
    [ProvinceAlias]  NVARCHAR (50)  NULL,
    [ProvinceFrench] NVARCHAR (255) NULL,
    [changedDate]    DATETIME       NULL,
    [CreatedDate]    DATETIME       CONSTRAINT [DF_Province_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Province] PRIMARY KEY CLUSTERED ([ProvinceID] ASC)
);

