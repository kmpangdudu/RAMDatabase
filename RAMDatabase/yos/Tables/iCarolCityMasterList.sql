CREATE TABLE [yos].[iCarolCityMasterList] (
    [iCarolCityID]     INT            IDENTITY (1, 1) NOT NULL,
    [ProvinceID]       INT            NULL,
    [RegionID]         INT            NULL,
    [iCarolCity]       NVARCHAR (255) NULL,
    [iCarolCityAlias]  NVARCHAR (50)  NULL,
    [iCarolCityFrench] NVARCHAR (50)  NULL,
    [changedDate]      DATETIME       NULL,
    [CreatedDate]      DATETIME       CONSTRAINT [DF_iCarolCity_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_iCarolCity] PRIMARY KEY CLUSTERED ([iCarolCityID] ASC)
);

