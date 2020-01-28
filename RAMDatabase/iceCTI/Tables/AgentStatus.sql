CREATE TABLE [iceCTI].[AgentStatus] (
    [ID]           INT            NOT NULL,
    [StatusCode]   INT            NULL,
    [StatusAlias]  NVARCHAR (255) NULL,
    [StatusWeight] INT            NULL,
    [StatusDesc]   NVARCHAR (500) NULL,
    [DateChanged]  DATETIME       NULL,
    [DateCreated]  DATETIME       CONSTRAINT [DF_AgentStatus_DateCreated] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AgentStatus] PRIMARY KEY CLUSTERED ([ID] ASC)
);

