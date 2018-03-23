CREATE FULLTEXT INDEX ON [dbo].[KeyWords]
    ([PublicName] LANGUAGE 0, [AgencyDescription] LANGUAGE 0, [PhysicalAddress] LANGUAGE 0, [PhysicalCity] LANGUAGE 0, [PhysicalProvince] LANGUAGE 0, [TaxonomyTerm] LANGUAGE 0, [TaxonomyTerms] LANGUAGE 0, [TopCategory] LANGUAGE 0, [TopCategory_fr] LANGUAGE 0, [SubCategory] LANGUAGE 0, [SubCategory_fr] LANGUAGE 0, [Coverage] LANGUAGE 0, [Eligibility] LANGUAGE 0)
    KEY INDEX [PK_KeyWords_1]
    ON [Keyword]
    WITH STOPLIST [freetext];


GO
CREATE FULLTEXT INDEX ON [dbo].[ETLLoad]
    ([PublicName] LANGUAGE 0, [PhysicalAddress1] LANGUAGE 0, [PhysicalAddress2] LANGUAGE 0, [PhysicalCity] LANGUAGE 0, [PhysicalCounty] LANGUAGE 1033, [PhysicalStateProvince] LANGUAGE 0, [PhysicalPostalCode] LANGUAGE 0, [WebsiteAddress] LANGUAGE 0, [AgencyDescription] LANGUAGE 0, [CoverageArea] LANGUAGE 0, [Eligibility] LANGUAGE 0, [TaxonomyTerm] LANGUAGE 0, [TaxonomyTerms] LANGUAGE 0, [Coverage] LANGUAGE 0)
    KEY INDEX [PK_ETLLoad]
    ON [Keyword];


GO
CREATE FULLTEXT INDEX ON [dbo].[RAMRAW]
    ([PublicName] LANGUAGE 0, [PhysicalAddress1] LANGUAGE 0, [PhysicalAddress2] LANGUAGE 0, [PhysicalCity] LANGUAGE 0, [PhysicalCounty] LANGUAGE 0, [PhysicalStateProvince] LANGUAGE 1033, [PhysicalPostalCode] LANGUAGE 5124, [WebsiteAddress] LANGUAGE 1033, [AgencyDescription] LANGUAGE 0, [CoverageArea] LANGUAGE 0, [Eligibility] LANGUAGE 0, [Coverage] LANGUAGE 0)
    KEY INDEX [PK_RAMRAW]
    ON [Keyword];


GO
CREATE FULLTEXT INDEX ON [dbo].[Coverage]
    ([Coverage] LANGUAGE 0)
    KEY INDEX [PK_Coverage]
    ON [Keyword];


GO
CREATE FULLTEXT INDEX ON [dbo].[TaxonomyRAW]
    ([PublicName] LANGUAGE 0, [PhysicalAddress1] LANGUAGE 0, [PhysicalAddress2] LANGUAGE 0, [PhysicalCity] LANGUAGE 0, [PhysicalCounty] LANGUAGE 0, [PhysicalStateProvince] LANGUAGE 0, [PhysicalPostalCode] LANGUAGE 0, [WebsiteAddress] LANGUAGE 0, [AgencyDescription] LANGUAGE 0, [CoverageArea] LANGUAGE 0, [Eligibility] LANGUAGE 0, [Coverage] LANGUAGE 0)
    KEY INDEX [PK_TaxonomyRAW]
    ON [Keyword];

