CREATE VIEW V_All_Clicked_Resources
AS
(
SELECT        logdate, COUNT(apilogid) AS num
FROM            dbo.apilog
WHERE        (cscontent = 'unique')
GROUP BY logdate  
)
