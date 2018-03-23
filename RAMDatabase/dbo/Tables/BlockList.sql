CREATE TABLE [dbo].[BlockList] (
    [BlockID]          INT             NOT NULL,
    [ACLID]            INT             NULL,
    [BlockIP]          NVARCHAR (50)   NULL,
    [BlockDesc]        NVARCHAR (2000) NULL,
    [BlockIPActivity]  BIT             CONSTRAINT [DF_BlockList_BlockIPActivity] DEFAULT ((1)) NULL,
    [BlockChangedDate] DATETIME        NULL,
    [BlockCreatedDate] DATETIME        CONSTRAINT [DF_BlockList_BlockCreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_BlockList] PRIMARY KEY CLUSTERED ([BlockID] ASC)
);

