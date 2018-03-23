CREATE TABLE [dbo].[CustomEligibilitybyAge] (
    [ID]                         INT            IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]                  INT            NULL,
    [CustomEligibilitybyAge]     NVARCHAR (50)  NULL,
    [CustomEligibilitybyAgeDesc] NVARCHAR (255) NULL,
    [ChangedDate]                DATETIME       NULL,
    [CreateDate]                 DATETIME       CONSTRAINT [DF_CustomEligibilitybyAge_CreateDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_CustomEligibilitybyAge] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_CustomEligibilitybyAge_TaxonomyRAW] FOREIGN KEY ([ETLLoadID]) REFERENCES [dbo].[TaxonomyRAW] ([ETLLoadID])
);

