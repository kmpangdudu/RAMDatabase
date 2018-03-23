CREATE TABLE [dbo].[Permission] (
    [PermissionID]    INT            IDENTITY (1, 1) NOT NULL,
    [ACLID]           INT            NULL,
    [TopCategoryID]   INT            NULL,
    [TopCategoryDesc] NVARCHAR (255) NULL,
    [SubCategoryID]   INT            NULL,
    [SubCategoryDesc] NVARCHAR (255) NULL,
    [ProvinceID]      INT            NULL,
    [ProvinceDesc]    NVARCHAR (255) NULL,
    [CityID]          INT            NULL,
    [CityDesc]        NVARCHAR (255) NULL,
    [ModifiedDate]    DATETIME       NULL,
    [CreatedDated]    DATETIME       CONSTRAINT [DF_Permission_CreatedDated] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Permission] PRIMARY KEY CLUSTERED ([PermissionID] ASC)
);

