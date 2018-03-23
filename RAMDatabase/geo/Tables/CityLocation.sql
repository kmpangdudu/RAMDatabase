CREATE TABLE [geo].[CityLocation] (
    [locId]      BIGINT           NULL,
    [country]    NVARCHAR (50)    NULL,
    [region]     NVARCHAR (50)    NULL,
    [city]       NVARCHAR (255)   NULL,
    [postalCode] NVARCHAR (50)    NULL,
    [latitude]   NUMERIC (18, 10) NULL,
    [longitude]  NUMERIC (18, 10) NULL,
    [metroCode]  NVARCHAR (50)    NULL,
    [areaCode]   NVARCHAR (50)    NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20170808-132122]
    ON [geo].[CityLocation]([locId] ASC);

