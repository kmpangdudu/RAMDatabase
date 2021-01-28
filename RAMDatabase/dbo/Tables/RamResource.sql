CREATE TABLE [dbo].[RamResource] (
    [RAMID]                    INT              IDENTITY (1, 1) NOT NULL,
    [ETLLoadID]                INT              NOT NULL,
    [ResourceAgencyNum]        NVARCHAR (50)    NULL,
    [Map]                      NVARCHAR (50)    CONSTRAINT [DF_RamResource_Map] DEFAULT (N'List') NOT NULL,
    [SubCategoryID]            INT              NOT NULL,
    [TOPCategoryID]            INT              NOT NULL,
    [PublicName]               NVARCHAR (2000)  NULL,
    [AgencyDescription]        NVARCHAR (MAX)   NULL,
    [TaxonomyLevelNameID]      INT              NULL,
    [ParentAgencyNum]          NVARCHAR (50)    NULL,
    [PhysicalAddress]          NVARCHAR (2000)  NULL,
    [PhysicalCityID]           INT              NULL,
    [PhysicalProvinceID]       INT              NULL,
    [PhysicalCountry]          NVARCHAR (50)    CONSTRAINT [DF_RamResource_PhysicalCountry] DEFAULT ('Canada') NULL,
    [PhysicalPostalCode]       NVARCHAR (50)    NULL,
    [PhysicalAddressIsPrivate] NVARCHAR (50)    NULL,
    [Latitude]                 NUMERIC (18, 10) NULL,
    [Longitude]                NUMERIC (18, 10) NULL,
    [HoursOfOperation]         NVARCHAR (2000)  NULL,
    [Phone]                    NVARCHAR (2000)  NULL,
    [WebsiteAddress]           NVARCHAR (2000)  NULL,
    [Eligibility]              NVARCHAR (2000)  NULL,
    [DisabilitiesAccess]       NVARCHAR (2000)  NULL,
    [FeeStructureSource]       NVARCHAR (2000)  NULL,
    [ApplicationProcess]       NVARCHAR (2000)  NULL,
    [DocumentsRequired]        NVARCHAR (2000)  NULL,
    [LanguagesOfferedList]     NVARCHAR (2000)  NULL,
    [LanguageOfRecord]         NVARCHAR (50)    NULL,
    [WorkHours]                NVARCHAR (2000)  NULL,
    [CustomEligibilitybyAge]   NVARCHAR (2000)  NULL,
    [CoverageArea]             NVARCHAR (2000)  NULL,
    [Coverage]                 NVARCHAR (MAX)   NULL,
    [NormalWaitTime]           NVARCHAR (2000)  NULL,
    [changedDate]              NVARCHAR (2000)  NULL,
    [createdDate]              DATETIME         CONSTRAINT [DF_RamResource_createdDate] DEFAULT (getdate()) NOT NULL,
    CONSTRAINT [PK_RamResource_1] PRIMARY KEY CLUSTERED ([RAMID] ASC)
);




GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-Language ]
    ON [dbo].[RamResource]([LanguageOfRecord] ASC)
    INCLUDE([ETLLoadID], [SubCategoryID], [TOPCategoryID], [PhysicalCityID], [PhysicalProvinceID], [TaxonomyLevelNameID]);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-ELTID]
    ON [dbo].[RamResource]([ETLLoadID] ASC)
    INCLUDE([Map], [TaxonomyLevelNameID], [SubCategoryID], [TOPCategoryID], [PhysicalCityID], [PhysicalProvinceID], [LanguageOfRecord]);

