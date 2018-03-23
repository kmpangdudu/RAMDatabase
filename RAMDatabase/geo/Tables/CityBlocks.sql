CREATE TABLE [geo].[CityBlocks] (
    [startIpNum] BIGINT NULL,
    [endIpNum]   BIGINT NULL,
    [locId]      BIGINT NULL
);


GO
CREATE CLUSTERED INDEX [ClusteredIndex-20170808-132100]
    ON [geo].[CityBlocks]([startIpNum] ASC, [endIpNum] ASC, [locId] ASC);

