-- =============================================
-- Author:		William Chen
-- Create date: 2018-09-26
-- Description:	Get Survey Type By ID,
-- if ID = 0, or not provide list all
-- =============================================
CREATE PROCEDURE [survey].[Proc_GetSurveyTypeByID] 
	-- Add the parameters for the stored procedure here
@token nvarchar(50),
@sid int = 0,
@lang nvarchar(10) = 'en'
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

DECLARE @ACLID INT = 0;
SELECT @ACLID = [ACLID] FROM [RAM].[dbo].[AccessControlList] WHERE @token = [ACLToken];

if @ACLID > 0 
    Begin
	if @sid = 0
		select surveytype_id ,
			case 
				when @lang = 'fr' then Rtrim(Ltrim(surveryType_fr))
				else Rtrim(Ltrim(surveyType))
			end as [surveyType]
		from survey.surveyType 
		where surveyType_Active = 1 
	else 
		select surveytype_id ,
			case 
				when @lang = 'fr' then Rtrim(Ltrim(surveryType_fr))
				else Rtrim(Ltrim(surveyType))
			end as [surveyType]
		from survey.surveyType 
		where surveyType_Active = 1 and @sid = surveytype_id
	end
else
		select surveytype_id ,
			 surveyType
		from survey.surveyType where 2 = 1 
END