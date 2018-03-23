CREATE TABLE [yos].[City] (
    [CityId]      INT            IDENTITY (1, 1) NOT NULL,
    [CityName]    NVARCHAR (255) NULL,
    [ChangedDate] DATETIME       NULL,
    [CreatedDate] DATETIME       CONSTRAINT [DF_City_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_City_2] PRIMARY KEY CLUSTERED ([CityId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_CityName]
    ON [yos].[City]([CityName] ASC);

