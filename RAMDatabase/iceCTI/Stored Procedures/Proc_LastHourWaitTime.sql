
CREATE Procedure [iceCTI].[Proc_LastHourWaitTime]
as
Begin

declare @Now datetime = getdate (); 
declare @LastHr datetime = DATEADD (HOUR , -1 , @Now ) ;

declare @PhoneWait decimal (16,2);
declare @ChatWait decimal (16,2);
select 
  @PhoneWait = CASE
				WHEN SUM(PhoneEn_HandledInQueue+PhoneFr_HandledInQueue+G2TEn_HandledInQueue+G2TFr_HandledInQueue) !=0 THEN
				SUM(PhoneEn_HandledInQueue * PhoneEn_EstimatedWaitTime   + 
					PhoneFr_HandledInQueue * PhoneFr_EstimatedWaitTime   +
					G2TEn_HandledInQueue * G2TEn_EstimatedWaitTime +
					G2TFr_HandledInQueue * G2TFr_EstimatedWaitTime) / 
					SUM(PhoneEn_HandledInQueue+PhoneFr_HandledInQueue+G2TEn_HandledInQueue+G2TFr_HandledInQueue)
				ELSE 0
				END
, @ChatWait = CASE 
				WHEN SUM(ChatEn_HandledInQueue+ChatFr_HandledInQueue+ChartAppEn_HandledInQueue+ChatAppFr_HandledInQueue) !=0 THEN
				SUM(ChatEn_HandledInQueue * ChatEn_EstimatedWaitTime +
					ChatFr_HandledInQueue * ChatFR_EstimatedWaitTime +
					ChartAppEn_HandledInQueue * ChartAppEn_EstimatedWaitTime +
					ChatAppFr_HandledInQueue * ChatAppFr_EstimatedWaitTime ) /
					SUM(ChatEn_HandledInQueue+ChatFr_HandledInQueue+ChartAppEn_HandledInQueue+ChatAppFr_HandledInQueue)
				ELSE 0
				END
from iceCTI.Grade where [CreatedDate] > @LastHr ;

select @PhoneWait as [phoneWaitTime], @ChatWait as [ChatWaitTime]


end