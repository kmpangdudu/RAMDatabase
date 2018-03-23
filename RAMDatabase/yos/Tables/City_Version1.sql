CREATE TABLE [yos].[City_Version1] (
    [CityID]      INT              IDENTITY (1, 1) NOT NULL,
    [City]        NVARCHAR (500)   NULL,
    [ProvinceID]  INT              NULL,
    [latitude]    NUMERIC (18, 10) NULL,
    [longitude]   NUMERIC (18, 10) NULL,
    [ChangedDate] DATETIME         NULL,
    [CreatedDate] DATETIME         NULL,
    CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED ([CityID] ASC),
    CONSTRAINT [FK_City_Province] FOREIGN KEY ([ProvinceID]) REFERENCES [dbo].[Province] ([ProvinceID])
);

