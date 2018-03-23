
CREATE VIEW V_LastMonth_Clicked_Resources

AS
(
SELECT        A.logdate, COUNT(A.apilogid) AS num
FROM            dbo.apilog AS A
WHERE        (cscontent = 'unique') AND
(a.logdate >= dbo.fn_lastmonth_startday() and a.logdate < dbo.fn_lastmonth_endday())
GROUP BY A.logdate  
)
