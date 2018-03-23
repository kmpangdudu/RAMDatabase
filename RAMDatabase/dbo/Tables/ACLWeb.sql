CREATE TABLE [dbo].[ACLWeb] (
    [ACLWebID]           INT            NOT NULL,
    [ACLID]              INT            NULL,
    [ACLWeb]             NVARCHAR (255) NULL,
    [ACLWebActivity]     BIT            CONSTRAINT [DF_ACLWeb_ACLWebActivity] DEFAULT ((1)) NULL,
    [ACLWebDesc]         NVARCHAR (255) NULL,
    [ACLWebModifiedDate] DATETIME       NULL,
    [ACLWebCreatedDate]  DATETIME       CONSTRAINT [DF_ACLWeb_ACLWebCreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ACLWeb] PRIMARY KEY CLUSTERED ([ACLWebID] ASC)
);

