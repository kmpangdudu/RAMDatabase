MERGE INTO RAMResource AS T
using (select  resourceagencynum  from RamResource where map= 'BOTH' ) as S
on (T.resourceagencynum = S.resourceagencynum   and T.map <> 'BOTH')
WHEN   MATCHED THEN 
Delete;