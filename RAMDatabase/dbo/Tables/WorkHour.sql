CREATE TABLE [dbo].[WorkHour] (
    [ID]           INT            IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]    INT            NULL,
    [WorkHour]     NVARCHAR (100) NULL,
    [WorkHourDesc] NVARCHAR (255) NULL,
    [ChangedDate]  DATETIME       NULL,
    [CreateDate]   DATETIME       CONSTRAINT [DF_WorkHour_CreateDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_WorkHour] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_WorkHour_TaxonomyRAW] FOREIGN KEY ([ETLLoadID]) REFERENCES [dbo].[TaxonomyRAW] ([ETLLoadID])
);

