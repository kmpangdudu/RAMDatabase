-- ==========================================================================================
-- Author:		William Chen
-- Create date: 2018-09-26
-- Description:	Get question answer options by question ID and Language
-- when question id = 0 or didn't provide, will response all of questions' answer opt
-- ==========================================================================================
CREATE PROCEDURE [survey].[Proc_GetSurveyQuestionOptsByQuestionID]
@token nvarchar(50),
@qid int = 0,
@lang nvarchar(10) = N'en'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 DECLARE @ACLID INT = 0;
SELECT @ACLID = [ACLID] FROM [RAM].[dbo].[AccessControlList] WHERE @token = [ACLToken];
if @ACLID > 0 
	BEGIN
			if @qid = 0
				select surveyQuestionOptID, surveyQuestionID,
	 
				case 
					when @lang = 'fr' then Rtrim(Ltrim(surveyQuestionOpt_fr))
					else Rtrim(Ltrim(surveyQuestionOpt_en))
				end as [surveyQuestionOpt],

				case 
					when @lang = 'fr' then Rtrim(Ltrim(surveyQuestionOptDesc_fr))
					else Rtrim(Ltrim(surveyQuestionOptDesc_en))
				end  as [surveyQuestionOptDesc]

				from survey.surveyQuestionOpt
				where   surveyQuestionOpt_Active = 1
			else

				select surveyQuestionOptID, surveyQuestionID,
	 
				case 
					when @lang = 'fr' then Rtrim(Ltrim(surveyQuestionOpt_fr))
					else Rtrim(Ltrim(surveyQuestionOpt_en))
				end as [surveyQuestionOpt],

				case 
					when @lang = 'fr' then Rtrim(Ltrim(surveyQuestionOptDesc_fr))
					else Rtrim(Ltrim(surveyQuestionOptDesc_en))
				end  as [surveyQuestionOptDesc]

				from survey.surveyQuestionOpt
				where surveyQuestionID = @qid and surveyQuestionOpt_Active = 1
	END
else
	select surveyQuestionOptID, surveyQuestionID,surveyQuestionOpt_en as [surveyQuestionOpt], surveyQuestionOptDesc_en as [surveyQuestionOptDesc]
	from survey.surveyQuestionOpt where 1=2
END