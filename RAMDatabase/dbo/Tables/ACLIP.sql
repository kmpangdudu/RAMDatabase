CREATE TABLE [dbo].[ACLIP] (
    [ACLIPID]           INT            NOT NULL,
    [ACLID]             INT            NULL,
    [ACLIP]             NVARCHAR (50)  NULL,
    [ACLIPActivity]     BIT            CONSTRAINT [DF_ACLIP_ACLIPActivity] DEFAULT ((1)) NULL,
    [ACLIPDesc]         NVARCHAR (255) NULL,
    [ACLIPModifiedDate] DATETIME       NULL,
    [ACLIPCreatedDate]  DATETIME       CONSTRAINT [DF_ACLIP_ACLIPCreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ACLIP] PRIMARY KEY CLUSTERED ([ACLIPID] ASC)
);

