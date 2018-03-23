CREATE VIEW [dbo].[V_French_API_Call]
AS
SELECT        logdate, COUNT(logdate) AS French
FROM            dbo.apilog
WHERE        (lang = 'fr')
GROUP BY logdate
