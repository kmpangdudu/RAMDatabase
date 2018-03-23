



/*-last month*/
CREATE VIEW [dbo].[V_LastMonth_Call]
AS
SELECT         DATEADD(year, - 1, dbo.fn_lastmonth_startday()) as [From] ,      Dateadd(dd,-1,DATEADD(year, - 1, dbo.fn_lastmonth_endday())) as [To],
a.All_lastMonth, b.All_lastMonth_lastYear, c.English_lastMonth, d.English_lastMonth_latyear, e.French_lastMonth, f.French_lastMonth_lastyear,KHP_LastMonth,KHP_LastMonth_LastYear,CAMH_LastMonth,CAMH_LastMonth_LastYear,Other_LastMonth,Other_LastMonth_LastYear
FROM            (SELECT        'a' AS l, COUNT(*) AS All_lastMonth
                          FROM            dbo.apilog
                          WHERE        (logdate >= dbo.fn_lastmonth_startday()) AND (logdate < dbo.fn_lastmonth_endday())) AS a INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS All_lastMonth_lastYear
                               FROM            dbo.apilog AS apilog_5
                               WHERE        (logdate >= DATEADD(year, - 1, dbo.fn_lastmonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastmonth_endday()))) AS b ON a.l = b.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastMonth
                               FROM            dbo.apilog AS apilog_4
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= dbo.fn_lastmonth_startday()) AND (logdate < dbo.fn_lastmonth_endday())) AS c ON a.l = c.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastMonth_latyear
                               FROM            dbo.apilog AS apilog_3
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= DATEADD(year, - 1, dbo.fn_lastmonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastmonth_endday()))) AS d ON a.l = d.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastMonth
                               FROM            dbo.apilog AS apilog_2
                               WHERE        (lang = 'fr') AND (logdate >= dbo.fn_lastmonth_startday()) AND (logdate < dbo.fn_lastmonth_endday())) AS e ON a.l = e.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastMonth_lastyear
                               FROM            dbo.apilog AS apilog_1
                               WHERE        (lang = 'fr') AND (logdate >= DATEADD(year, - 1, dbo.fn_lastmonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastmonth_endday()))) AS f ON a.l = f.l INNER JOIN
							   							   (
							   select 'a' as l , count(*) as KHP_LastMonth from dbo.apilog as a1  where  (logdate >= dbo.fn_lastmonth_startday() and logdate <dbo.fn_lastmonth_endday()) and  a1.aclname = 'KHP'  
							   ) as k on a.l = k.l  INNER JOIN 
							   (
							   select 'a' as l, count(*) as KHP_LastMonth_LastYear from apilog as a2 where (logdate >= DATEADD(year, - 1, dbo.fn_LastMonth_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_LastMonth_endday()))  and a2.aclname = 'KHP'  
							   ) as kl on a.l = kl.l INNER JOIN
							   (
							   select 'a' as l, count(*) as [CAMH_LastMonth] from apilog where (logdate >= [dbo].[fn_LastMonth_startday]() AND logdate <[dbo].[fn_LastMonth_endday]()) AND (aclname = 'CAMH' or aclname is null  )
							   ) as CAMH on a.l = camh.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [CAMH_LastMonth_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_LastMonth_startday]()) AND logdate <DATEADD(Year,-1,[dbo].[fn_LastMonth_endday]())) AND (aclname = 'CAMH' or aclname is null  )
							   )as CAMH_L on a.l = CAMH_L.l INNER JOIN 
							   (
							   select 'a' as l, count(*) as [Other_LastMonth] from apilog where (logdate >= [dbo].[fn_LastMonth_startday]() AND logdate <[dbo].[fn_LastMonth_endday]()) AND (aclname = 'Unknown' or aclname is null )
							   ) as u on a.l = u.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [Other_LastMonth_LastYear] from apilog where (logdate >=dateadd(year,-1, [dbo].[fn_LastMonth_startday]()) AND logdate <dateadd(year,-1,[dbo].[fn_LastMonth_endday]())) AND (aclname = 'Unknown' or aclname is null )
							   ) as ul on a.l = ul.l

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 102
               Right = 454
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 492
               Bottom = 102
               Right = 678
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 716
               Bottom = 102
               Right = 942
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 980
               Bottom = 102
               Right = 1164
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 6
               Left = 1202
               Bottom = 102
               Right = 1431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LastMonth_Call';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LastMonth_Call';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LastMonth_Call';

