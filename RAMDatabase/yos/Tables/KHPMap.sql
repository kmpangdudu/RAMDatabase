CREATE TABLE [yos].[KHPMap] (
    [Mapid]            INT            NOT NULL,
    [classificationID] INT            NULL,
    [TaxonomyCode]     NVARCHAR (50)  NULL,
    [TaxonomyDesc]     NVARCHAR (255) NULL,
    [DateCreated]      DATETIME       CONSTRAINT [DF_KHPMap_DateCreated] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_KHPMap] PRIMARY KEY CLUSTERED ([Mapid] ASC)
);

