CREATE TABLE [dbo].[CityLocation] (
    [CityId]      INT              IDENTITY (1, 1) NOT NULL,
    [CityName]    NVARCHAR (500)   NULL,
    [ProvinceID]  INT              NULL,
    [latitude]    NUMERIC (18, 10) CONSTRAINT [DF_CityLocation_latitude] DEFAULT ((0.0)) NULL,
    [longitude]   NUMERIC (18, 10) CONSTRAINT [DF_CityLocation_longitude] DEFAULT ((0.0)) NULL,
    [ChangedDate] DATETIME         NULL,
    [CreatedDate] DATETIME         CONSTRAINT [DF_c1_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_City_1] PRIMARY KEY CLUSTERED ([CityId] ASC),
    CONSTRAINT [FK_City_Province1] FOREIGN KEY ([ProvinceID]) REFERENCES [dbo].[Province] ([ProvinceID])
);


GO
CREATE NONCLUSTERED INDEX [IX_CityLocation_provinceID]
    ON [dbo].[CityLocation]([ProvinceID] ASC);

