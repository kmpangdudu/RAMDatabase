CREATE TABLE [geo].[canadaip] (
    [blockid]     INT             IDENTITY (1, 1) NOT NULL,
    [locid]       BIGINT          NULL,
    [start_ip]    BIGINT          NULL,
    [end_ip]      BIGINT          NULL,
    [country]     NVARCHAR (50)   NULL,
    [region]      NVARCHAR (50)   NULL,
    [city]        NVARCHAR (255)  NULL,
    [postalcode]  NVARCHAR (50)   NULL,
    [latitude]    NUMERIC (18, 8) NULL,
    [longitude]   NUMERIC (18, 8) NULL,
    [metroCode]   NVARCHAR (50)   NULL,
    [areaCode]    NVARCHAR (50)   NULL,
    [changeddate] DATETIME        NULL,
    [createddate] DATETIME        CONSTRAINT [DF_canadaip_createddate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_canadaIP] PRIMARY KEY CLUSTERED ([blockid] ASC)
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20170808-132032]
    ON [geo].[canadaip]([locid] ASC, [start_ip] ASC, [end_ip] ASC);

