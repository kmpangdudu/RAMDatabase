
CREATE Procedure [iceCTI].[Proc_LastHourGrade]
as
Begin
DECLARE @Phone_NumhundledLessThanTarget     decimal (16,2);  
DECLARE @G2T_NumhundledLessThanTarget		decimal (16,2); 
DECLARE @Chat_NumhundledLessThanTarget		decimal (16,2); 
DECLARE @ChatApp_NumhundledLessThanTarget	decimal (16,2); 
 												   
DECLARE @Phone_NumOffered					decimal (16,2); 
DECLARE @G2T_NumOffered					    decimal (16,2); 
DECLARE @Chat_NumOffered					decimal (16,2); 
DECLARE @ChatApp_NumOffered				    decimal (16,2); 

declare @Now datetime = getdate (); 
declare @Last24hr datetime = DATEADD (HOUR , -1 , @Now ) ;

select 
		--  @Phone_NumhundledLessThanTarget    = AVG ([PhoneEn_NumhundledLessThanTarget] + [PhoneFr_NumhundledLessThanTarget]    )
		@G2T_NumhundledLessThanTarget		 = AVG ([G2TEn_NumhundledLessThanTarget] + [G2TFr_NumhundledLessThanTarget]		   )
		--, @Chat_NumhundledLessThanTarget	 = AVG ([ChatEn_NumhundledLessThanTarget]+ [ChatFr_NumhundledLessThanTarget]	   )
		, @ChatApp_NumhundledLessThanTarget	 = AVG ([ChatAppEn_NumhundledLessThanTarget]+[ChatAppFr_NumhundledLessThanTarget]  )
 																				    
		--, @Phone_NumOffered					 = AVG ([PhoneEn_NumOffered]+[PhoneFr_NumOffered]								   )
		, @G2T_NumOffered					 = AVG ([G2TEn_NumOffered]+[G2TFr_NumOffered]									   )
		--, @Chat_NumOffered					 = AVG ([ChatEn_NumOffered]+[ChatFr_NumOffered]									   )
		, @ChatApp_NumOffered				 = AVG ([ChatAppEn_NumOffered]+[ChatAppFr_NumOffered]							   )
 , @Phone_NumhundledLessThanTarget    = sum([PhoneEn_NumhundledLessThanTarget] + [PhoneFr_NumhundledLessThanTarget]  + [G2TEn_NumhundledLessThanTarget] +[G2TEn_NumhundledLessThanTarget] + [G2TFr_NumhundledLessThanTarget]	)
 , @Phone_NumOffered = sum([PhoneEn_NumOffered]+[PhoneFr_NumOffered]	+ [G2TEn_NumOffered]+[G2TFr_NumOffered]	)
 , @Chat_NumhundledLessThanTarget =sum([ChatEn_NumhundledLessThanTarget]+ [ChatFr_NumhundledLessThanTarget] + [ChatAppEn_NumhundledLessThanTarget]+[ChatAppFr_NumhundledLessThanTarget] )
 , @Chat_NumOffered =sum([ChatEn_NumOffered]+[ChatFr_NumOffered]	+[ChatAppEn_NumOffered]+[ChatAppFr_NumOffered])
from iceCTI.Grade where [CreatedDate] > @Last24hr ;


 declare @PhoneAllGrade Decimal (6,2);
 declare @PhoneGrade    decimal (6,2);
 declare @G2TGrade      decimal (6,2); 
 								 
 declare @ChatAllGrade  Decimal (6,2); 
 declare @ChatGrade     decimal (6,2);
 declare @ChatAppGrade  decimal (6,2);

 --grade = 100.00 * iNumhundledLessThanTarget / iNumOffered;
if  @Phone_NumOffered = 0.0 
		select @PhoneGrade = 0.00 ;
	else 
		select @PhoneGrade = 100.00 *  @Phone_NumhundledLessThanTarget / @Phone_NumOffered ;

if @G2T_NumOffered = 0.0
		select @G2TGrade = 0.00 ;
	else 
		select @G2TGrade = 100.00 * @G2T_NumhundledLessThanTarget / @G2T_NumOffered ;
 

if @Chat_NumOffered = 0.0
		select @ChatGrade =0.00;
	else 
		select @ChatGrade = 100.00 * @Chat_NumhundledLessThanTarget / @Chat_NumOffered ;
   
if @ChatApp_NumOffered =0.0
		select @ChatAppGrade = 0.00 ;
	else
		select @ChatAppGrade = 100.00 * @ChatApp_NumhundledLessThanTarget / @ChatApp_NumOffered ;
 
--select  @PhoneAllGrade = (@PhoneGrade + @G2TGrade) / 2 ;

--select  @ChatAllGrade  = (@ChatGrade + @ChatAppGrade) / 2 ;
select  @PhoneAllGrade = @PhoneGrade  ;

select  @ChatAllGrade  = @ChatGrade ;




-- final return those
select @PhoneAllGrade as PhoneAllGrade, @PhoneGrade as PhoneGrade, @G2TGrade as G2TGrade ,
       @ChatAllGrade as ChatAllGrade, @ChatGrade as ChatGrade , @ChatAppGrade as ChatAppGrade 

end