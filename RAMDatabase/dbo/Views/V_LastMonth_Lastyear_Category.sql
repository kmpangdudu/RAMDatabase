

/*last month category*/
CREATE VIEW [dbo].[V_LastMonth_Lastyear_Category]
AS
SELECT        t.TopCategory, COUNT(aaa.apilogid) AS Num
FROM            dbo.TopCategory AS t INNER JOIN
                             (SELECT        apilogid, logdate,  cscontent, keywords
                               FROM            dbo.apilog AS a
                               WHERE        (cscontent = 'Topcategory') 
							   AND (logdate >= DATEADD(YEAR,-1,dbo.fn_lastmonth_startday())) 
							   AND (logdate < DATEADD(YEAR,-1,dbo.fn_lastmonth_endday()))) AS aaa ON 
                         t.TopCategoryID = aaa.keywords
GROUP BY t.TopCategory
