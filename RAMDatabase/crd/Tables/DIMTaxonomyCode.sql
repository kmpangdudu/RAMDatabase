CREATE TABLE [crd].[DIMTaxonomyCode] (
    [DIMTaxonomyCode_ID]          INT           IDENTITY (1, 1) NOT NULL,
    [DIMTaxonomyCode_Name]        NVARCHAR (50) NULL,
    [DIMTaxonomyCode_Active]      BIT           CONSTRAINT [DF_DIMTaxonomyCode_DIMTaxonomyCode_Active] DEFAULT ((1)) NULL,
    [DIMTaxonomyCode_StartDate]   DATETIME      CONSTRAINT [DF_DIMTaxonomyCode_DIMTaxonomyCode_StartDate] DEFAULT (getdate()) NULL,
    [DIMTaxonomyCode_EndDate]     DATETIME      CONSTRAINT [DF_DIMTaxonomyCode_DIMTaxonomyCode_EndDate] DEFAULT ('9999-12-31') NULL,
    [DIMTaxonomyCode_changedDate] DATETIME      NULL,
    [DIMTaxonomyCode_CreatedDate] DATETIME      CONSTRAINT [DF_DIMTaxonomyCode_DIMTaxonomyCode_CreatedDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_DIMTaxonomyCode] PRIMARY KEY CLUSTERED ([DIMTaxonomyCode_ID] ASC)
);

