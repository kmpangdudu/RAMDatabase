﻿CREATE TABLE [dbo].[ETLLoad] (
    [ETLLoadID]                          INT              IDENTITY (1, 1) NOT NULL,
    [ResourceAgencyNum]                  NVARCHAR (2000)  NULL,
    [PublicName]                         NVARCHAR (2000)  NULL,
    [AlternateName]                      NVARCHAR (2000)  NULL,
    [OfficialName]                       NVARCHAR (2000)  NULL,
    [TaxonomyLevelName]                  NVARCHAR (2000)  NULL,
    [ParentAgency]                       NVARCHAR (2000)  NULL,
    [ParentAgencyNum]                    NVARCHAR (2000)  NULL,
    [RecordOwner]                        NVARCHAR (2000)  NULL,
    [UniqueIDPriorSystem]                NVARCHAR (2000)  NULL,
    [MailingAttentionName]               NVARCHAR (2000)  NULL,
    [MailingAddress1]                    NVARCHAR (2000)  NULL,
    [MailingAddress2]                    NVARCHAR (2000)  NULL,
    [MailingCity]                        NVARCHAR (2000)  NULL,
    [MailingStateProvince]               NVARCHAR (2000)  NULL,
    [MailingPostalCode]                  NVARCHAR (2000)  NULL,
    [MailingCountry]                     NVARCHAR (2000)  NULL,
    [MailingAddressIsPrivate]            NVARCHAR (2000)  NULL,
    [PhysicalAddress1]                   NVARCHAR (2000)  NULL,
    [PhysicalAddress2]                   NVARCHAR (2000)  NULL,
    [PhysicalCity]                       NVARCHAR (2000)  NULL,
    [PhysicalCounty]                     NVARCHAR (2000)  NULL,
    [PhysicalStateProvince]              NVARCHAR (2000)  NULL,
    [PhysicalPostalCode]                 NVARCHAR (2000)  NULL,
    [PhysicalCountry]                    NVARCHAR (2000)  NULL,
    [PhysicalAddressIsPrivate]           NVARCHAR (2000)  NULL,
    [OtherAddress1]                      NVARCHAR (2000)  NULL,
    [OtherAddress2]                      NVARCHAR (2000)  NULL,
    [OtherCity]                          NVARCHAR (2000)  NULL,
    [OtherCounty]                        NVARCHAR (2000)  NULL,
    [OtherStateProvince]                 NVARCHAR (2000)  NULL,
    [OtherPostalCode]                    NVARCHAR (2000)  NULL,
    [OtherCountry]                       NVARCHAR (2000)  NULL,
    [Latitude]                           NUMERIC (18, 10) NULL,
    [Longitude]                          NUMERIC (18, 10) NULL,
    [HoursOfOperation]                   NVARCHAR (2000)  NULL,
    [Phone1Number]                       NVARCHAR (2000)  NULL,
    [Phone1Name]                         NVARCHAR (2000)  NULL,
    [Phone1Description]                  NVARCHAR (2000)  NULL,
    [Phone1IsPrivate]                    BIT              NULL,
    [Phone1Type]                         NVARCHAR (2000)  NULL,
    [Phone2Number]                       NVARCHAR (2000)  NULL,
    [Phone2Name]                         NVARCHAR (2000)  NULL,
    [Phone2Description]                  NVARCHAR (2000)  NULL,
    [Phone2IsPrivate]                    BIT              NULL,
    [Phone2Type]                         NVARCHAR (2000)  NULL,
    [Phone3Number]                       NVARCHAR (2000)  NULL,
    [Phone3Name]                         NVARCHAR (2000)  NULL,
    [Phone3Description]                  NVARCHAR (2000)  NULL,
    [Phone3IsPrivate]                    BIT              NULL,
    [Phone3Type]                         NVARCHAR (2000)  NULL,
    [Phone4Number]                       NVARCHAR (2000)  NULL,
    [Phone4Name]                         NVARCHAR (2000)  NULL,
    [Phone4Description]                  NVARCHAR (2000)  NULL,
    [Phone4IsPrivate]                    BIT              NULL,
    [Phone4Type]                         NVARCHAR (2000)  NULL,
    [Phone5Number]                       NVARCHAR (2000)  NULL,
    [Phone5Name]                         NVARCHAR (2000)  NULL,
    [Phone5Description]                  NVARCHAR (2000)  NULL,
    [Phone5IsPrivate]                    BIT              NULL,
    [Phone5Type]                         NVARCHAR (2000)  NULL,
    [PhoneFax]                           NVARCHAR (2000)  NULL,
    [PhoneFaxDescription]                NVARCHAR (2000)  NULL,
    [PhoneFaxIsPrivate]                  BIT              NULL,
    [PhoneTTY]                           NVARCHAR (2000)  NULL,
    [PhoneTTYDescription]                NVARCHAR (2000)  NULL,
    [PhoneTTYIsPrivate]                  BIT              NULL,
    [PhoneTollFree]                      NVARCHAR (2000)  NULL,
    [PhoneTollFreeDescription]           NVARCHAR (2000)  NULL,
    [PhoneTollFreeIsPrivate]             BIT              NULL,
    [PhoneNumberHotline]                 NVARCHAR (2000)  NULL,
    [PhoneNumberHotlineDescription]      NVARCHAR (2000)  NULL,
    [PhoneNumberHotlineIsPrivate]        BIT              NULL,
    [PhoneNumberBusinessLine]            NVARCHAR (2000)  NULL,
    [PhoneNumberBusinessLineDescription] NVARCHAR (2000)  NULL,
    [PhoneNumberBusinessLineIsPrivate]   BIT              NULL,
    [PhoneNumberOutOfArea]               NVARCHAR (2000)  NULL,
    [PhoneNumberOutOfAreaDescription]    NVARCHAR (2000)  NULL,
    [PhoneNumberOutOfAreaIsPrivate]      BIT              NULL,
    [PhoneNumberAfterHours]              NVARCHAR (2000)  NULL,
    [PhoneNumberAfterHoursDescription]   NVARCHAR (2000)  NULL,
    [PhoneNumberAfterHoursIsPrivate]     BIT              NULL,
    [EmailAddressMain]                   NVARCHAR (2000)  NULL,
    [WebsiteAddress]                     NVARCHAR (2000)  NULL,
    [AgencyStatus]                       NVARCHAR (2000)  NULL,
    [AgencyClassification]               NVARCHAR (2000)  NULL,
    [AgencyDescription]                  NVARCHAR (MAX)   NULL,
    [SearchHints]                        NVARCHAR (2000)  NULL,
    [CoverageArea]                       NVARCHAR (2000)  NULL,
    [CoverageAreaText]                   NVARCHAR (2000)  NULL,
    [Eligibility]                        NVARCHAR (2000)  NULL,
    [EligibilityAdult]                   BIT              NULL,
    [EligibilityChild]                   BIT              NULL,
    [EligibilityFamily]                  BIT              NULL,
    [EligibilityFemale]                  BIT              NULL,
    [EligibilityMale]                    BIT              NULL,
    [EligibilityTeen]                    BIT              NULL,
    [SeniorWorkerName]                   NVARCHAR (2000)  NULL,
    [SeniorWorkerTitle]                  NVARCHAR (2000)  NULL,
    [SeniorWorkerEmailAddress]           NVARCHAR (2000)  NULL,
    [SeniorWorkerPhoneNumber]            NVARCHAR (2000)  NULL,
    [SeniorWorkerIsPrivate]              NVARCHAR (2000)  NULL,
    [MainContactName]                    NVARCHAR (2000)  NULL,
    [MainContactTitle]                   NVARCHAR (2000)  NULL,
    [MainContactEmailAddress]            NVARCHAR (2000)  NULL,
    [MainContactPhoneNumber]             NVARCHAR (2000)  NULL,
    [MainContactType]                    NVARCHAR (2000)  NULL,
    [MainContactIsPrivate]               NVARCHAR (2000)  NULL,
    [LicenseAccreditation]               NVARCHAR (2000)  NULL,
    [IRSStatus]                          NVARCHAR (2000)  NULL,
    [FEIN]                               NVARCHAR (2000)  NULL,
    [YearIncorporated]                   NVARCHAR (2000)  NULL,
    [AnnualBudgetTotal]                  NVARCHAR (2000)  NULL,
    [LegalStatus]                        NVARCHAR (2000)  NULL,
    [SourceOfFunds]                      NVARCHAR (2000)  NULL,
    [ExcludeFromWebsite]                 NVARCHAR (2000)  NULL,
    [ExcludeFromDirectory]               NVARCHAR (2000)  NULL,
    [DisabilitiesAccess]                 NVARCHAR (2000)  NULL,
    [PhysicalLocationDescription]        NVARCHAR (2000)  NULL,
    [BusServiceAccess]                   NVARCHAR (2000)  NULL,
    [PublicAccessTransportation]         NVARCHAR (2000)  NULL,
    [FeeStructureSource]                 NVARCHAR (2000)  NULL,
    [ApplicationProcess]                 NVARCHAR (2000)  NULL,
    [ResourceInfo]                       NVARCHAR (2000)  NULL,
    [DocumentsRequired]                  NVARCHAR (2000)  NULL,
    [LanguagesOffered]                   NVARCHAR (2000)  NULL,
    [LanguagesOfferedList]               NVARCHAR (2000)  NULL,
    [AvailabilityNumberOfTimes]          NVARCHAR (2000)  NULL,
    [AvailabilityFrequency]              NVARCHAR (2000)  NULL,
    [AvailabilityPeriod]                 NVARCHAR (2000)  NULL,
    [ServiceNotAlwaysAvailability]       NVARCHAR (2000)  NULL,
    [CapacityType]                       NVARCHAR (2000)  NULL,
    [ServiceCapacity]                    NVARCHAR (2000)  NULL,
    [NormalWaitTime]                     NVARCHAR (2000)  NULL,
    [TemporaryMessage]                   NVARCHAR (2000)  NULL,
    [TemporaryMessageAppears]            DATETIME         NULL,
    [TemporaryMessageExpires]            DATETIME         NULL,
    [EnteredOn]                          DATETIME         NULL,
    [UpdatedOn]                          DATETIME         NULL,
    [MadeInactiveOn]                     DATETIME         NULL,
    [InternalNotes]                      NVARCHAR (2000)  NULL,
    [InternalNotesForEditorsAndViewers]  NVARCHAR (2000)  NULL,
    [HighlightedResource]                BIT              NULL,
    [LastVerifiedOn]                     DATETIME         NULL,
    [LastVerifiedByName]                 NVARCHAR (2000)  NULL,
    [LastVerifiedByTitle]                NVARCHAR (2000)  NULL,
    [LastVerifiedByPhoneNumber]          NVARCHAR (2000)  NULL,
    [LastVerifiedByEmailAddress]         NVARCHAR (2000)  NULL,
    [LastVerificationApprovedBy]         NVARCHAR (2000)  NULL,
    [AvailableForDirectory]              NVARCHAR (2000)  NULL,
    [AvailableForReferral]               NVARCHAR (2000)  NULL,
    [AvailableForResearch]               NVARCHAR (2000)  NULL,
    [PreferredProvider]                  BIT              NULL,
    [ConnectsToSiteNum]                  NVARCHAR (2000)  NULL,
    [ConnectsToProgramNum]               NVARCHAR (2000)  NULL,
    [LanguageOfRecord]                   NVARCHAR (2000)  NULL,
    [CurrentWorkflowStepCode]            NVARCHAR (2000)  NULL,
    [VolunteerOpportunities]             NVARCHAR (2000)  NULL,
    [VolunteerDuties]                    NVARCHAR (2000)  NULL,
    [IsLinkOnly]                         NVARCHAR (2000)  NULL,
    [ProgramAgencyNamePublic]            NVARCHAR (2000)  NULL,
    [SiteAgencyNamePublic]               NVARCHAR (2000)  NULL,
    [Categories]                         NVARCHAR (2000)  NULL,
    [TaxonomyTerm]                       NVARCHAR (2000)  NULL,
    [TaxonomyTerms]                      NVARCHAR (2000)  NULL,
    [TaxonomyTermsNotDeactivated]        NVARCHAR (2000)  NULL,
    [TaxonomyCodes]                      NVARCHAR (2000)  NULL,
    [Coverage]                           NVARCHAR (MAX)   NULL,
    [WorkHours]                          NVARCHAR (2000)  NULL,
    [CustomFeesFreeText]                 NVARCHAR (2000)  NULL,
    [CustomIndigenousEmergencyServices]  NVARCHAR (2000)  NULL,
    [CustomServicesToLGBTQ]              NVARCHAR (2000)  NULL,
    [CustomAutomatedStatus]              NVARCHAR (2000)  NULL,
    [CustomBatchID]                      NVARCHAR (2000)  NULL,
    [CustomProgramHarmReductionService]  NVARCHAR (2000)  NULL,
    [CustomEligibilitybyAge]             NVARCHAR (2000)  NULL,
    [CustomEligibilityByGender]          NVARCHAR (2000)  NULL,
    [CustomLanguagePrefer]               NVARCHAR (2000)  NULL,
    [CustomBilingualService]             NVARCHAR (2000)  NULL,
    [CustomManualStatus]                 NVARCHAR (2000)  NULL,
    [CustomMCYSAccountNumber]            NVARCHAR (2000)  NULL,
    [CustomAnonymityPolicy]              NVARCHAR (MAX)   NULL,
    [CustomSuggestKeyword]               NVARCHAR (MAX)   NULL,
    [CustomRecordType]                   NVARCHAR (2000)  NULL,
    [CustomSourceDatabase]               NVARCHAR (2000)  NULL,
    [CustomTargetPopulation]             NVARCHAR (2000)  NULL,
    [changedDate]                        DATETIME         NULL,
    [createdDate]                        DATETIME         CONSTRAINT [DF_ETLLoad_createdDate] DEFAULT (getdate()) NULL,
    CONSTRAINT [PK_ETLLoad] PRIMARY KEY CLUSTERED ([ETLLoadID] ASC)
);








GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-170200]
    ON [dbo].[ETLLoad]([ConnectsToProgramNum] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-170129]
    ON [dbo].[ETLLoad]([ConnectsToSiteNum] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-170056]
    ON [dbo].[ETLLoad]([TaxonomyCodes] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-170030]
    ON [dbo].[ETLLoad]([CustomRecordType] ASC);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20210724-165944]
    ON [dbo].[ETLLoad]([TaxonomyLevelName] ASC);

