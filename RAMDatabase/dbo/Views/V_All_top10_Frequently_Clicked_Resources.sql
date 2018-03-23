CREATE VIEW [dbo].[V_All_top10_Frequently_Clicked_Resources]
as
WITH B_ranked AS (
  SELECT
    *,
    rnk = ROW_NUMBER() OVER (PARTITION BY r.ResourceAgencyNum ORDER BY r.etlloadid )
  FROM RamResource as r 
)
SELECT
  B.PublicName as [Program],
  c.CityName as [city],
  p.ProvinceAlias as [Province],
  A.num as [All Num]
FROM (select top(10) * from V_All_Frequently_Clicked_Resources as vw order by vw.num desc) as A 
  LEFT JOIN B_ranked AS B ON A.resourcesnum = B.ResourceAgencyNum AND b.rnk = 1
join CityLocation as c on c.CityId = b.PhysicalCityID 
join Province as p on p.ProvinceID = b.PhysicalProvinceID 
