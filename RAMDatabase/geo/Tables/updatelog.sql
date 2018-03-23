CREATE TABLE [geo].[updatelog] (
    [updatelogid]    INT            IDENTITY (1, 1) NOT NULL,
    [updateddate]    DATETIME       CONSTRAINT [DF_Table_1_UpdatedDate] DEFAULT (getdate()) NULL,
    [updatedesc]     NVARCHAR (500) NULL,
    [ipblocks]       INT            NULL,
    [iplocation]     INT            NULL,
    [country]        INT            NULL,
    [region]         INT            NULL,
    [city]           INT            NULL,
    [postalCode]     INT            NULL,
    [latitude]       INT            NULL,
    [longitude]      INT            NULL,
    [metroCode]      INT            NULL,
    [areaCode]       INT            NULL,
    [canadianblocks] INT            NULL,
    [changeddate]    DATETIME       NULL,
    [createddate]    DATETIME       CONSTRAINT [DF_updatelog_createddate_1] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_updatelog_1] PRIMARY KEY CLUSTERED ([updatelogid] ASC)
);

