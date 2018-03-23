CREATE TABLE [cal].[DIMSubCategory] (
    [DIMSubCategory_ID]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [DIMSubCategory_Num]         BIGINT          NULL,
    [DIMSubCategory_Name]        NVARCHAR (2000) NULL,
    [DIMSubCategory_active]      BIT             CONSTRAINT [DF_DIMSubCategory_DIMSubCategory_active] DEFAULT ((1)) NULL,
    [DIMSubCategory_startdate]   DATETIME        CONSTRAINT [DF_DIMSubCategory_DIMSubCategory_startdate] DEFAULT (getdate()) NULL,
    [DIMSubCategory_enddate]     DATETIME        CONSTRAINT [DF_DIMSubCategory_DIMSubCategory_enddate] DEFAULT ('9999-12-31') NULL,
    [DIMSubCategory_changeddate] DATETIME        NULL,
    [DIMSubCategory_createddate] DATETIME        CONSTRAINT [DF_DIMSubCategory_DIMSubCategory_createddate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIMSubCategory] PRIMARY KEY CLUSTERED ([DIMSubCategory_ID] ASC)
);

