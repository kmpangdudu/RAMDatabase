CREATE VIEW [dbo].[V_English_API_Call]
AS
SELECT        logdate, COUNT(logdate) AS English
FROM            dbo.apilog
WHERE        (lang <> 'fr') OR
                         (lang IS NULL)
GROUP BY logdate
