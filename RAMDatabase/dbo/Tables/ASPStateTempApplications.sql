CREATE TABLE [dbo].[ASPStateTempApplications] (
    [AppId]   INT        NOT NULL,
    [AppName] CHAR (280) NOT NULL,
    PRIMARY KEY CLUSTERED ([AppId] ASC)
);


GO
CREATE NONCLUSTERED INDEX [Index_AppName]
    ON [dbo].[ASPStateTempApplications]([AppName] ASC);

