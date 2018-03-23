
CREATE VIEW V_lastMonth_Lastyear_Clicked_Resources

AS
(
SELECT        A.logdate, COUNT(A.apilogid) AS num
FROM            dbo.apilog AS A
WHERE        (cscontent = 'unique') AND
(a.logdate >= Dateadd(year,-1,dbo.fn_lastmonth_startday()) and a.logdate < Dateadd(year,-1,dbo.fn_lastmonth_endday()))
GROUP BY A.logdate  
)
