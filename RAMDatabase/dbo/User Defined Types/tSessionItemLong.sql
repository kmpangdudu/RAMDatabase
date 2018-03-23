CREATE TYPE [dbo].[tSessionItemLong]
    FROM IMAGE NULL;


GO
GRANT REFERENCES
    ON TYPE::[dbo].[tSessionItemLong] TO PUBLIC;

