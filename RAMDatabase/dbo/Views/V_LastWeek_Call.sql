





/* last week*/
CREATE VIEW [dbo].[V_LastWeek_Call]
AS
SELECT    dbo.fn_lastweek_startday() as [From], dateadd(dd,-1,dbo.fn_lastweek_endday()) as [To] ,
    a.All_lastweek, b.All_lastweek_lastYear, c.English_lastweek, d.English_lastweek_lastYear, e.French_lastweek, f.French_lastweek_lastYear, 
	k.KHP_Lastweek,kl.KHP_Lastweek_LastYear, 
	CAMH_LastWeek, CAMH_LastWeek_LastYear, 
	Foundry_LastWeek, Foundry_LastWeek_LastYear, 
	MYSMB_LastWeek, MYSMB_LastWeek_LastYear, 
	[Other_LastWeek],[Other_LastWeek_LastYear]
FROM            (SELECT        'a' AS l, COUNT(*) AS All_lastweek
                          FROM            dbo.apilog
                          WHERE        (logdate >= dbo.fn_lastweek_startday()) AND (logdate < dbo.fn_lastweek_endday())) AS a INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS All_lastweek_lastYear
                               FROM            dbo.apilog AS apilog_5
                               WHERE        (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))) AS b ON a.l = b.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastweek
                               FROM            dbo.apilog AS apilog_4
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= dbo.fn_lastweek_startday()) AND (logdate < dbo.fn_lastweek_endday())) AS c ON a.l = c.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS English_lastweek_lastYear
                               FROM            dbo.apilog AS apilog_3
                               WHERE        (lang <> 'fr' OR
                                                         lang IS NULL) AND (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))) AS d ON a.l = d.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastweek
                               FROM            dbo.apilog AS apilog_2
                               WHERE        (lang = 'fr') AND (logdate >= dbo.fn_lastweek_startday()) AND (logdate < dbo.fn_lastweek_endday())) AS e ON a.l = e.l INNER JOIN
                             (SELECT        'a' AS l, COUNT(*) AS French_lastweek_lastYear
                               FROM            dbo.apilog AS apilog_1
                               WHERE        (lang = 'fr') AND (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))) AS f ON a.l = f.l   INNER JOIN
             -- KHP
							   (
							   select 'a' as l , count(*) as KHP_Lastweek from dbo.apilog as a1  where  (logdate >= dbo.fn_lastweek_startday() and logdate <dbo.fn_lastweek_endday()) and  a1.aclname = 'KHP'  
							   ) as k on a.l = k.l  INNER JOIN 
							   (
							   select 'a' as l, count(*) as KHP_Lastweek_LastYear from apilog as a2 where (logdate >= DATEADD(year, - 1, dbo.fn_lastweek_startday())) AND (logdate < DATEADD(year, - 1, dbo.fn_lastweek_endday()))  and a2.aclname = 'KHP'  
							   ) as kl on a.l = kl.l INNER JOIN
							   
			-- CAMH				   
							   (
							   select 'a' as l, count(*) as [CAMH_LastWeek] from apilog where (logdate >= [dbo].[fn_lastweek_startday]() AND logdate <[dbo].[fn_lastweek_endday]()) AND (aclname = 'CAMH'  )
							   ) as CAMH on a.l = camh.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [CAMH_LastWeek_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_lastweek_startday]()) AND logdate <DATEADD(Year,-1,[dbo].[fn_lastweek_endday]())) AND (aclname = 'CAMH'  )
							   )as CAMH_L on a.l = CAMH_L.l INNER JOIN 
			-- Foundry				   
							   (
							   select 'a' as l, count(*) as [Foundry_LastWeek] from apilog where (logdate >= [dbo].[fn_lastweek_startday]() AND logdate <[dbo].[fn_lastweek_endday]()) AND (aclname = 'Foundry'   )
							   ) as Foundry on a.l = Foundry.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [Foundry_LastWeek_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_lastweek_startday]()) AND logdate <DATEADD(year,-1,[dbo].[fn_lastweek_endday]())) AND (aclname = 'Foundry'  )
							   ) as Foundry_l on a.l = Foundry_l.l	INNER JOIN		 				   
							   

			-- MYSMB				    
							   (
							   select 'a' as l, count(*) as [MYSMB_LastWeek] from apilog where (logdate >= [dbo].[fn_lastweek_startday]() AND logdate <[dbo].[fn_lastweek_endday]()) AND (aclname = 'MYSMB'  )
							   ) as MYSMB on a.l = MYSMB.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [MYSMB_LastWeek_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_lastweek_startday]()) AND logdate <DATEADD(year,-1,[dbo].[fn_lastweek_endday]())) AND (aclname = 'MYSMB'  )
							   ) as MYSMB_l on a.l = MYSMB_l.l   	INNER JOIN	



			-- Other				    
							   (
							   select 'a' as l, count(*) as [Other_LastWeek] from apilog where (logdate >= [dbo].[fn_lastweek_startday]() AND logdate <[dbo].[fn_lastweek_endday]()) AND (aclname = 'Unknown' or aclname is null )
							   ) as u on a.l = u.l  INNER JOIN
							   (
							   select 'a' as l, count(*) as [Other_LastWeek_LastYear] from apilog where (logdate >= DATEADD(year,-1,[dbo].[fn_lastweek_startday]()) AND logdate <DATEADD(year,-1,[dbo].[fn_lastweek_endday]())) AND (aclname = 'Unknown' or aclname is null )
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
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "c"
            Begin Extent = 
               Top = 6
               Left = 483
               Bottom = 102
               Right = 660
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
            Begin Extent = 
               Top = 6
               Left = 698
               Bottom = 102
               Right = 921
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "e"
            Begin Extent = 
               Top = 6
               Left = 959
               Bottom = 102
               Right = 1134
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "f"
            Begin Extent = 
               Top = 164
               Left = 1094
               Bottom = 260
               Right = 1315
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
       ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LastWeek_Call';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'  Output = 720
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LastWeek_Call';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'V_LastWeek_Call';

