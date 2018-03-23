

CREATE VIEW [dbo].[V_LastWeek_Lastyear_Category]
AS
SELECT        t.TopCategory, COUNT(aaa.apilogid) AS Num
FROM            dbo.TopCategory AS t INNER JOIN
                             (SELECT     apilogid,    logdate,    cscontent,   keywords
                               FROM            dbo.apilog AS a
                               WHERE        (cscontent = 'Topcategory')
							    AND  (logdate >= DATEADD(YEAR,-1,dbo.fn_lastweek_startday()) )
								AND (logdate < DATEADD(YEAR,-1,dbo.fn_lastweek_endday() )) ) AS aaa ON t.TopCategoryID = aaa.keywords
GROUP BY t.TopCategory
