ALTER ROLE [db_owner] ADD MEMBER [RAMUser];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [BIDM];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [BIDW];


GO
ALTER ROLE [db_ddladmin] ADD MEMBER [BIODS];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [BIDM];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [BIDW];


GO
ALTER ROLE [db_datawriter] ADD MEMBER [BIODS];


GO
ALTER ROLE [db_datareader] ADD MEMBER [BIDM];


GO
ALTER ROLE [db_datareader] ADD MEMBER [BIDW];


GO
ALTER ROLE [db_datareader] ADD MEMBER [BIODS];

