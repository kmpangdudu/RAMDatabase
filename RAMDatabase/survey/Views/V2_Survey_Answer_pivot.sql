
CREATE VIEW [survey].[V2_Survey_Answer_pivot]
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
max(case when surveyquestion_id = 10 then surveyanswer end)   as [Did you just chat with a counsellor?] ,
max(case when surveyquestion_id = 11 then surveyanswer end)   as [How upset are you right now (Post)?] ,
max(case when surveyquestion_id = 12 then surveyanswer end)   as [How helpful was your chat session overall?] ,
max(case when surveyquestion_id = 13 then surveyanswer end)   as [Did you have any technical problems?] ,
max(case when surveyquestion_id = 14 then surveyanswer end)   as [What happened?] ,
max(case when surveyquestion_id = 15 then surveyanswer end)   as [Would you recommend this service to others?] ,
max(case when surveyquestion_id = 16 then surveyanswer end)   as [Why?] ,
max( [language] ) as [Site_Language],
max(surveyAnswer_Device) as [Device],
max(surveyAnswer_createdDate) as [surveyAnswer_Date]
from survey.surveyanswer
group by CHATID