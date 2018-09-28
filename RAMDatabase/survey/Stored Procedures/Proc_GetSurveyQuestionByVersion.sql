-- ==========================================================================================
-- Author:		William Chen
-- Create date: 2018-09-26
-- Description:	Get survey question by Version and language
-- if @Ver = '' or not provide , response all question list 
-- ==========================================================================================
CREATE PROCEDURE [survey].[Proc_GetSurveyQuestionByVersion]
@token nvarchar(50),
@ver nvarchar(10) = N'',
@lang nvarchar(10) = 'en'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 DECLARE @ACLID INT = 0;
SELECT @ACLID = [ACLID] FROM [RAM].[dbo].[AccessControlList] WHERE @token = [ACLToken];
if @ACLID >0 
	Begin
			if @ver = N''
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
				where surveyQuestion_active = 1  and surveyQuestion_Desc = @ver 
	end
else
select surveyQuestion_id, surveyTypeID,  surveyQuestion, surveyQuestion_desc as [surveyQuestionDesc]
from survey.surveyQuestion where 1=2
END