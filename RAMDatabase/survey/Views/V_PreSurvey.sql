CREATE VIEW [survey].[V_PreSurvey]
as
select chatID  ,
max(case when surveyquestion_id = 1 then surveyanswer end)   as [age-month] ,
max(case when surveyquestion_id = 2 then surveyanswer end)   as [age-year] ,
max(case when surveyquestion_id = 3 then surveyanswer end)   as [Community] ,
max(case when surveyquestion_id = 4 then surveyanswer end)   as [community-other] ,
max(case when surveyquestion_id = 5 then surveyanswer end)   as [I identify as ...] ,
max(case when surveyquestion_id = 6 then surveyanswer end)   as [gender-other] ,
max(case when surveyquestion_id = 7 then surveyanswer end)   as [Province/Territory] ,
max(case when surveyquestion_id = 8 then surveyanswer end)   as [nickname] ,
max(case when surveyquestion_id = 9 then surveyanswer end)   as [How upset are you right now?] ,
max( [language] ) as [Site_Language],
max(surveyAnswer_Device) as [Device],
max(surveyAnswer_createdDate) as [surveyAnswer_Date]
from survey.surveyanswer
group by CHATID
