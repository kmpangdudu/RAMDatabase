CREATE TABLE [dbo].[ProgramRAW] (
    [ETLLoadID]                        INT              IDENTITY (1, 1) NOT NULL,
    [ResourceAgencyNum]                NVARCHAR (2000)  NULL,
    [Map]                              NVARCHAR (50)    NULL,
    [PublicName]                       NVARCHAR (2000)  NULL,
    [TaxonomyLevelNameID]              INT              NULL,
    [ParentAgency]                     NVARCHAR (2000)  NULL,
    [ParentAgencyNum]                  NVARCHAR (2000)  NULL,
    [PhysicalAddress1]                 NVARCHAR (2000)  NULL,
    [PhysicalAddress2]                 NVARCHAR (2000)  NULL,
    [PhysicalCityID]                   INT              NULL,
    [PhysicalCity]                     NVARCHAR (2000)  NULL,
    [PhysicalCounty]                   NVARCHAR (2000)  NULL,
    [PhysicalProvinceID]               INT              NULL,
    [PhysicalStateProvince]            NVARCHAR (2000)  NULL,
    [PhysicalPostalCode]               NVARCHAR (2000)  NULL,
    [PhysicalCountry]                  NVARCHAR (2000)  NULL,
    [PhysicalAddressIsPrivate]         NVARCHAR (2000)  NULL,
    [Latitude]                         NUMERIC (18, 10) NULL,
    [Longitude]                        NUMERIC (18, 10) NULL,
    [HoursOfOperation]                 NVARCHAR (2000)  NULL,
    [Phone1Number]                     NVARCHAR (2000)  NULL,
    [Phone1IsPrivate]                  BIT              NULL,
    [Phone2Number]                     NVARCHAR (2000)  NULL,
    [Phone2IsPrivate]                  BIT              NULL,
    [Phone3Number]                     NVARCHAR (2000)  NULL,
    [Phone3IsPrivate]                  BIT              NULL,
    [Phone4Number]                     NVARCHAR (2000)  NULL,
    [Phone4IsPrivate]                  BIT              NULL,
    [Phone5Number]                     NVARCHAR (2000)  NULL,
    [Phone5IsPrivate]                  BIT              NULL,
    [PhoneFax]                         NVARCHAR (2000)  NULL,
    [PhoneFaxIsPrivate]                BIT              NULL,
    [PhoneTTY]                         NVARCHAR (2000)  NULL,
    [PhoneTTYIsPrivate]                BIT              NULL,
    [PhoneTollFree]                    NVARCHAR (2000)  NULL,
    [PhoneTollFreeIsPrivate]           BIT              NULL,
    [PhoneNumberHotline]               NVARCHAR (2000)  NULL,
    [PhoneNumberHotlineIsPrivate]      BIT              NULL,
    [PhoneNumberBusinessLine]          NVARCHAR (2000)  NULL,
    [PhoneNumberBusinessLineIsPrivate] BIT              NULL,
    [PhoneNumberOutOfArea]             NVARCHAR (2000)  NULL,
    [PhoneNumberOutOfAreaIsPrivate]    BIT              NULL,
    [PhoneNumberAfterHours]            NVARCHAR (2000)  NULL,
    [PhoneNumberAfterHoursIsPrivate]   BIT              NULL,
    [WebsiteAddress]                   NVARCHAR (2000)  NULL,
    [AgencyDescription]                NVARCHAR (MAX)   NULL,
    [CoverageArea]                     NVARCHAR (2000)  NULL,
    [CoverageAreaText]                 NVARCHAR (2000)  NULL,
    [Eligibility]                      NVARCHAR (2000)  NULL,
    [DisabilitiesAccess]               NVARCHAR (2000)  NULL,
    [FeeStructureSource]               NVARCHAR (2000)  NULL,
    [ApplicationProcess]               NVARCHAR (2000)  NULL,
    [DocumentsRequired]                NVARCHAR (2000)  NULL,
    [LanguagesOffered]                 NVARCHAR (2000)  NULL,
    [LanguagesOfferedList]             NVARCHAR (2000)  NULL,
    [NormalWaitTime]                   NVARCHAR (2000)  NULL,
    [EnteredOn]                        DATETIME         NULL,
    [UpdatedOn]                        DATETIME         NULL,
    [MadeInactiveOn]                   DATETIME         NULL,
    [ConnectsToSiteNum]                NVARCHAR (2000)  NULL,
    [ConnectsToProgramNum]             NVARCHAR (2000)  NULL,
    [LanguageOfRecord]                 NVARCHAR (2000)  NULL,
    [IsLinkOnly]                       BIT              NULL,
    [Categories]                       NVARCHAR (2000)  NULL,
    [TaxonomyCodes]                    NVARCHAR (2000)  NULL,
    [Coverage]                         NVARCHAR (MAX)   NULL,
    [WorkHours]                        NVARCHAR (2000)  NULL,
    [CustomEligibilitybyAge]           NVARCHAR (2000)  NULL,
    [CustomAnonymityPolicy]            NVARCHAR (MAX)   NULL,
    [CustomRecordType]                 NVARCHAR (2000)  NULL,
    [changedDate]                      DATETIME         NULL,
    [createdDate]                      DATETIME         CONSTRAINT [DF_ProgramRAW_createdDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ProgramRAW] PRIMARY KEY CLUSTERED ([ETLLoadID] ASC),
    CONSTRAINT [FK_ProgramRAW_CityLocation] FOREIGN KEY ([PhysicalCityID]) REFERENCES [dbo].[CityLocation] ([CityId]),
    CONSTRAINT [FK_ProgramRAW_Province] FOREIGN KEY ([PhysicalProvinceID]) REFERENCES [dbo].[Province] ([ProvinceID]),
    CONSTRAINT [FK_ProgramRAW_TaxonomyLevelName] FOREIGN KEY ([TaxonomyLevelNameID]) REFERENCES [dbo].[TaxonomyLevelName] ([TaxonomyLevelNameID])
);




GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-171749]
    ON [dbo].[ProgramRAW]([CustomRecordType] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-171720]
    ON [dbo].[ProgramRAW]([ConnectsToProgramNum] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-171627]
    ON [dbo].[ProgramRAW]([ConnectsToSiteNum] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-171501]
    ON [dbo].[ProgramRAW]([ResourceAgencyNum] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-171431]
    ON [dbo].[ProgramRAW]([ETLLoadID] ASC);

