CREATE TABLE [cal].[DIMTextAnswer] (
    [DIMTextAnswer_ID]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [DIMTextAnswer_Num]         BIGINT          NULL,
    [DIMTextAnswer_Answer]      NVARCHAR (2000) NULL,
    [DIMTextAnswer_active]      BIT             CONSTRAINT [DF_DIMTextAnswer_DIMTextAnswer_active] DEFAULT ((1)) NULL,
    [DIMTextAnswer_startdate]   DATETIME        CONSTRAINT [DF_DIMTextAnswer_DIMTextAnswer_startdate] DEFAULT (getdate()) NULL,
    [DIMTextAnswer_enddate]     DATETIME        CONSTRAINT [DF_DIMTextAnswer_DIMTextAnswer_enddate] DEFAULT ('9999-12-31') NULL,
    [DIMTextAnswer_changeddate] DATETIME        NULL,
    [DIMTextAnswer_createddate] DATETIME        CONSTRAINT [DF_DIMTextAnswer_DIMTextAnswer_createddate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIMTextAnswer] PRIMARY KEY CLUSTERED ([DIMTextAnswer_ID] ASC)
);

