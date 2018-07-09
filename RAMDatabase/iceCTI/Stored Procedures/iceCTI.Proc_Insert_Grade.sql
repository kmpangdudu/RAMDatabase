USE [RAM]
GO

/****** Object:  StoredProcedure [survey].[Proc_Insert_Grade]    Script Date: 7/7/2018 5:55:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =======================================================================================================================================
-- Author:		William Chen
-- Create date: 2018-07-03
-- Description:	To get grade of service in last 24 hours, Insert NumOffered and NumhundledLessThanTarget from every queueID
--
-- @PhoneGrade, @G2TGrade, @ChatGrade, @ChatAppGrade will be the avager of last 24 hourse
--
-- Phone_ENG 6001 ; Phone_FRE 6002 ; 
-- G2T_ENG 6013 ; G2T_FRE 6014 ;  
-- Chat_ENG 6007 ;Chat_FRE 6008 ; 
-- ChatApp_ENG  6020 ; ChatApp_FRE 6021
-- =======================================================================================================================================
ALTER PROCEDURE [iceCTI].[Proc_Insert_Grade] 
 
 @PhoneEn_NumhundledLessThanTarget    decimal (6,2)= 0.0 ,
 @PhoneFr_NumhundledLessThanTarget    decimal (6,2)= 0.0 ,
 @G2TEn_NumhundledLessThanTarget	  decimal (6,2)= 0.0 ,
 @G2TFr_NumhundledLessThanTarget 	  decimal (6,2)= 0.0 ,
 @ChatEn_NumhundledLessThanTarget	  decimal (6,2)= 0.0 ,
 @ChatFr_NumhundledLessThanTarget	  decimal (6,2)= 0.0 ,
 @ChatAppEn_NumhundledLessThanTarget  decimal (6,2)= 0.0 ,
 @ChatAppFr_NumhundledLessThanTarget  decimal (6,2)= 0.0 ,
 @PhoneEn_NumOffered				  decimal (6,2)= 0.0 ,
 @PhoneFr_NumOffered				  decimal (6,2)= 0.0 ,
 @G2TEn_NumOffered					  decimal (6,2)= 0.0 ,
 @G2TFr_NumOffered					  decimal (6,2)= 0.0 ,
 @ChatEn_NumOffered					  decimal (6,2)= 0.0 ,
 @ChatFr_NumOffered					  decimal (6,2)= 0.0 ,
 @ChatAppEn_NumOffered				  decimal (6,2)= 0.0 ,
 @ChatAppFr_NumOffered				  decimal (6,2)= 0.0 

 --@PhoneAllGrade Decimal output,
 --@PhoneGrade    decimal output,
 --@G2TGrade      decimal output,

 --@ChatAllGrade  Decimal output, 
 --@ChatGrade     decimal output,
 --@ChatAppGrade  decimal output


AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	declare @Now datetime = getdate (); 
	declare @Last24hr datetime = DATEADD (day , -1 , @Now ) ;


 insert into iceCTI.grade 
 (
  PhoneEn_NumhundledLessThanTarget    
 , PhoneFr_NumhundledLessThanTarget    
 , G2TEn_NumhundledLessThanTarget	
 , G2TFr_NumhundledLessThanTarget 	
 , ChatEn_NumhundledLessThanTarget	
 , ChatFr_NumhundledLessThanTarget	
 , ChatAppEn_NumhundledLessThanTarget
 , ChatAppFr_NumhundledLessThanTarget
 , PhoneEn_NumOffered					
 , PhoneFr_NumOffered					
 , G2TEn_NumOffered					
 , G2TFr_NumOffered					
 , ChatEn_NumOffered					
 , ChatFr_NumOffered					
 , ChatAppEn_NumOffered				
 , ChatAppFr_NumOffered		
 , CreatedDate		
 )
 VALUES
 (
  @PhoneEn_NumhundledLessThanTarget     
 , @PhoneFr_NumhundledLessThanTarget     
 , @G2TEn_NumhundledLessThanTarget	 
 , @G2TFr_NumhundledLessThanTarget 	
  
 , @ChatEn_NumhundledLessThanTarget	 
 , @ChatFr_NumhundledLessThanTarget	 
 , @ChatAppEn_NumhundledLessThanTarget 
 , @ChatAppFr_NumhundledLessThanTarget 

 , @PhoneEn_NumOffered					 
 , @PhoneFr_NumOffered					 
 , @G2TEn_NumOffered					 
 , @G2TFr_NumOffered	
 				 
 , @ChatEn_NumOffered					 
 , @ChatFr_NumOffered					 
 , @ChatAppEn_NumOffered				 
 , @ChatAppFr_NumOffered	

 , @Now			 
 );



  

END
GO

