CREATE VIEW [dbo].[V_All_Clicked_Program]

AS
SELECT        TOP (100) PERCENT r.ResourceAgencyNum, r.PublicName, v.num
FROM            dbo.V_All_Frequently_Clicked_Resources AS v INNER JOIN
                         dbo.RamResource AS r ON r.ResourceAgencyNum = v.ResourcesNum
ORDER BY v.num DESC
