CREATE PROCEDURE [survey].[Proc_Survey_Answer_pivot_V3]
@startdate date,
@enddate date  
as
select chatID  ,
max(case when surveyquestion_id = 301 then surveyanswer end)   as [Nickname] ,
max(case when surveyquestion_id = 302 then surveyanswer end)   as [Gender:Are you?] ,
max(case when surveyquestion_id = 303 then surveyanswer end)   as [Other Gender] ,
max(case when surveyquestion_id = 304 then surveyanswer end)   as [Birth Month] ,
max(case when surveyquestion_id = 305 then surveyanswer end)   as [Birth Year] ,
max(case when surveyquestion_id = 306 then surveyanswer end)   as [What Province are you contacting us from?] ,
max(case when surveyquestion_id = 307 then surveyanswer end)   as [What kind of community do you live in?] ,
max(case when surveyquestion_id = 308 then surveyanswer end)   as [Other community] ,
max(case when surveyquestion_id = 309 then surveyanswer end)   as [Have you used our service before?] ,
max(case when surveyquestion_id = 310 then surveyanswer end)   as [Per-Survey: On a scale of 0 to 7, how upset are you right now?] ,
max(case when surveyquestion_id = 311 then surveyanswer end)   as [Did you just chat with a counsellor?] ,
max(case when surveyquestion_id = 312 then surveyanswer end)   as [Post-survey: On a scale of 0 to 7, how upset are you right now?] ,
max(case when surveyquestion_id = 313 then surveyanswer end)   as [Would you recommend that others use this service? ] ,
max(case when surveyquestion_id = 320 then surveyanswer end)   as [Why?] ,
max(case when surveyquestion_id = 314 then surveyanswer end)   as [If the chat service did not exist, I would have:] ,
max(case when surveyquestion_id = 315 then surveyanswer end)   as [Other services] ,
max(case when surveyquestion_id = 316 then surveyanswer end)   as [RELATIONSHIP] ,
max(case when surveyquestion_id = 317 then surveyanswer end)   as [GOALS OR TOPICS] ,
max(case when surveyquestion_id = 318 then surveyanswer end)   as [APPROACH or METHOD ] ,
max(case when surveyquestion_id = 319 then surveyanswer end)   as [OVERALL] ,
-- max(case when surveyquestion_id = 320 then surveyanswer end)   as [Why?] ,
max( [language] ) as [Site_Language],
max(surveyAnswer_Device) as [Device],
max(surveyAnswer_createdDate) as [surveyAnswer_Date]
from survey.surveyanswer
where surveyAnswer_createdDate >= @startdate and surveyAnswer_createdDate < @enddate
group by CHATID
order by surveyAnswer_Date