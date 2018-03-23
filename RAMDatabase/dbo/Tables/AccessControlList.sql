CREATE TABLE [dbo].[AccessControlList] (
    [ACLID]           INT             NOT NULL,
    [ACLName]         NVARCHAR (255)  NULL,
    [ACLToken]        NVARCHAR (50)   CONSTRAINT [DF_AccessControlList_ACLToken] DEFAULT (newid()) NULL,
    [ACLActivity]     BIT             CONSTRAINT [DF_AccessControlList_ACLActivity] DEFAULT ((1)) NULL,
    [ACLDesc]         NVARCHAR (1000) NULL,
    [ACLmodifiedDate] DATETIME        NULL,
    [ACLCreatedDate]  DATETIME        CONSTRAINT [DF_Table_1_ACTCreateDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_AccessControlList] PRIMARY KEY CLUSTERED ([ACLID] ASC)
);

