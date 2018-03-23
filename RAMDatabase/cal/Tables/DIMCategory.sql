CREATE TABLE [cal].[DIMCategory] (
    [DIMCategory_ID]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [DIMCategory_Num]         BIGINT          NULL,
    [DIMCategory_Name]        NVARCHAR (2000) NULL,
    [DIMCategory_active]      BIT             CONSTRAINT [DF_DIMCategory_DIMCategory_active] DEFAULT ((1)) NULL,
    [DIMCategory_startdate]   DATETIME        CONSTRAINT [DF_DIMCategory_DIM_startdate] DEFAULT (getdate()) NULL,
    [DIMCategory_enddate]     DATETIME        CONSTRAINT [DF_DIMCategory_DIM_enddate] DEFAULT ('9999-12-31') NULL,
    [DIMCategory_changeddate] DATETIME        NULL,
    [DIMCategory_createddate] DATETIME        CONSTRAINT [DF_DIMCategory_DIM_createddate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIMCategory] PRIMARY KEY CLUSTERED ([DIMCategory_ID] ASC)
);

