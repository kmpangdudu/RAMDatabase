CREATE TABLE [yos].[iCarolRegion] (
    [RegionID]    INT           IDENTITY (1, 1) NOT NULL,
    [ProvinceID]  INT           NULL,
    [Region]      NVARCHAR (50) NULL,
    [Alias]       NVARCHAR (50) NULL,
    [Fr_Region]   NVARCHAR (50) NULL,
    [Fr_Alias]    NVARCHAR (50) NULL,
    [ChangedDate] DATETIME      NULL,
    [CreatedDate] DATETIME      CONSTRAINT [DF_iCarolRegion_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_iCarolRegion] PRIMARY KEY CLUSTERED ([RegionID] ASC)
);

