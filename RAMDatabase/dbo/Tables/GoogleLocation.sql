CREATE TABLE [dbo].[GoogleLocation] (
    [GoogleLocationID] INT              IDENTITY (1, 1) NOT NULL,
    [GoogleCity]       NVARCHAR (255)   NULL,
    [GoogleProvince]   NVARCHAR (255)   NULL,
    [GoogleProvinceID] INT              NULL,
    [GoogleLatitude]   NUMERIC (18, 10) CONSTRAINT [DF_GoogleLocation_GoogleLatitude] DEFAULT ((0.0)) NULL,
    [GoogleLongitude]  NUMERIC (18, 10) CONSTRAINT [DF_GoogleLocation_GoogleLongitude] DEFAULT ((0.0)) NULL,
    [ChangedDate]      DATETIME         NULL,
    [CreatedDate]      DATETIME         CONSTRAINT [DF_GoogleLocation_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_GoogleLocation] PRIMARY KEY CLUSTERED ([GoogleLocationID] ASC)
);

