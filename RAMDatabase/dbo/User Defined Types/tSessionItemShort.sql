CREATE TYPE [dbo].[tSessionItemShort]
    FROM VARBINARY (7000) NULL;


GO
GRANT REFERENCES
    ON TYPE::[dbo].[tSessionItemShort] TO PUBLIC;

