CREATE TABLE [iceCTI].[Queue] (
    [id]          INT            NOT NULL,
    [Queue]       NVARCHAR (50)  NULL,
    [QueueValue]  NVARCHAR (50)  NULL,
    [QueueDesc]   NVARCHAR (255) NULL,
    [QueueActive] BIT            CONSTRAINT [DF_Queue_QueueActive] DEFAULT ((1)) NULL,
    [ChangedDate] DATETIME       CONSTRAINT [DF_Queue_ChangedDate] DEFAULT (getdate()) NULL,
    [CreatedDate] DATETIME       CONSTRAINT [DF_Queue_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_Queue] PRIMARY KEY CLUSTERED ([id] ASC)
);

