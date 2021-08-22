-- ==========================================================================================
-- Author:		William Chen
-- Create date: 2018-09-26
-- Description:	Get survey question by QID and language
-- if q1d = 0 or not provide , response all question list 
-- ==========================================================================================
create PROCEDURE [survey].[p916]
@token nvarchar(50),
@qid int = 0,
@lang nvarchar(10) = 'en'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 DECLARE @ACLID INT = 0;
SELECT @ACLID = [ACLID] FROM [dbo].[AccessControlList] WHERE @token = [ACLToken];
if @ACLID >0 
	Begin
			if @qid = 0
				select surveyQuestion_id, surveyTypeID, 
					case 
						when @lang = 'fr' then Rtrim(Ltrim(surveyQuestion_fr))
						else Rtrim(Ltrim(surveyQuestion))
					end as [surveyQuestion],

					case 
						when @lang = 'fr' then Rtrim(Ltrim(surveyQuestion_desc_fr))
						else Rtrim(Ltrim(surveyQuestion_Desc))
					end as [surveyQuestionDesc]
				from survey.surveyQuestion 
				where surveyQuestion_active = 1 
			else 
				select surveyQuestion_id, surveyTypeID, 
					case 
						when @lang = 'fr' then Rtrim(Ltrim(surveyQuestion_fr))
						else Rtrim(Ltrim(surveyQuestion))
					end as [surveyQuestion],
					case 
						when @lang = 'fr' then Rtrim(Ltrim(surveyQuestion_desc_fr))
						else Rtrim(Ltrim(surveyQuestion_Desc))
					end as [surveyQuestionDesc]
				from survey.surveyQuestion 
				where surveyQuestion_active = 1  and surveyQuestion_id = @qid 
	end
else
select surveyQuestion_id, surveyTypeID,  surveyQuestion, surveyQuestion_desc as [surveyQuestionDesc]
from survey.surveyQuestion where 1=2
END