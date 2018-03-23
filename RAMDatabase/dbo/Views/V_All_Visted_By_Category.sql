

CREATE VIEW [dbo].[V_All_Visted_By_Category] AS
select ISNULL(cc.Num,0) + ISNULL(bb.num,0) as num, tt.TopCategoryID as tid, tt.topcategory
, tt.TopcategoryAlias as category 
from  [dbo].TopCategory as tt
	left join  [dbo].[V_All_Browse_By_Category]  as [bb]   on tt.TopCategory = bb.TopCategory
    left join [dbo].[V_All_Category] as [cc]  on cc.TopCategory = bb.TopCategory 
where tt.Active = 1
