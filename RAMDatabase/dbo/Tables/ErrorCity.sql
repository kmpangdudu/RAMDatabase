CREATE TABLE [dbo].[ErrorCity] (
    [ErrorCityETLLOADID]              INT            NULL,
    [ErrorCity_ResourceAgencyNum]     NVARCHAR (500) NULL,
    [ErrorCity_PublicName]            NVARCHAR (500) NULL,
    [ErrorCity_PhysicalCity]          NVARCHAR (500) NULL,
    [ErrorCity_physicalProvinceID]    INT            NULL,
    [ErrorCity_PhysicalStateProvince] NVARCHAR (500) NULL,
    [CreatedDate]                     DATETIME       CONSTRAINT [DF_ErrorCity_CreatedDate] DEFAULT (getdate()) NULL
);

