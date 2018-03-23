CREATE TABLE [yos].[Region] (
    [RegionID]     INT            IDENTITY (1, 1) NOT NULL,
    [Region]       NVARCHAR (255) NULL,
    [RegionAlias]  NVARCHAR (50)  NULL,
    [RegionFrench] NVARCHAR (50)  NULL,
    [changedDate]  DATETIME       NULL,
    [CreatedDate]  DATETIME       CONSTRAINT [DF_Region_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY CLUSTERED ([RegionID] ASC)
);

