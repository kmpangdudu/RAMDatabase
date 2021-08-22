CREATE TABLE [dbo].[mapping] (
    [id]              INT            IDENTITY (1, 5) NOT NULL,
    [status]          NCHAR (10)     NULL,
    [SPECIFIC_SCHEMA] NVARCHAR (128) NULL,
    [SPECIFIC_NAME]   [sysname]      NOT NULL,
    [ROUTINE_TYPE]    NVARCHAR (20)  NULL,
    [CREATED]         DATETIME       NOT NULL,
    [LAST_ALTERED]    DATETIME       NOT NULL,
    [script]          VARCHAR (255)  NULL
);

