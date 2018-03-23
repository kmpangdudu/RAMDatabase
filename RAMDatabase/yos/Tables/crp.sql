CREATE TABLE [yos].[crp] (
    [id]            INT              NULL,
    [cityid]        INT              NULL,
    [CityName]      NVARCHAR (255)   NULL,
    [ProvinceID]    INT              NULL,
    [latitude]      NUMERIC (18, 10) NULL,
    [longitude]     NUMERIC (18, 10) NULL,
    [ProvinceAlias] NVARCHAR (50)    NULL,
    [County]        NVARCHAR (255)   NULL,
    [ChangedDate]   DATETIME         NULL,
    [CreatedDate]   DATETIME         NULL
);

