﻿/****** Script for SelectTopNRows command from SSMS  ******/
CREATE VIEW [survey].[V5_surveyAnswer]
AS
SELECT  [surveyAnswer_ID]
      ,q.[surveyQuestion]
      ,[chatID]
	  ,case [surveyAnswer]
			when   '50201'   THEN 'Alberta'
			when   '50202'   THEN 'British Columbia'
			when   '50203'   THEN 'New Brunswick'
			when   '50204'   THEN 'Newfoundland'
			when   '50205'   THEN 'Northwest Territories'
			when   '50206'   THEN 'Nova Scotia'
			when   '50207'   THEN 'Nunavut'
			when   '50208'   THEN 'Ontario'
			when   '50209'   THEN 'PEI'
			when   '50210'   THEN 'Québec'
			when   '50211'   THEN 'Manitoba'
			when   '50212'   THEN 'Saskatchewan'
			when   '50213'   THEN 'Yukon'
			when   '50214'   THEN 'Prefer not to answer'
			when   '50401'   THEN 'Prefer not to answer'
			when   '50402'   THEN '9 or younger'
			when   '50403'   THEN '10-13'
			when   '50404'   THEN '14-17'
			when   '50405'   THEN '18-24'
			when   '50406'   THEN '25-29'
			when   '50407'   THEN '30-69'
			when   '50408'   THEN '70+'
			when   '50501'   THEN 'Prefer not to answer'
			when   '50502'   THEN 'Agender'
			when   '50503'   THEN 'Female'
			when   '50504'   THEN 'Non-binary / Genderqueer / Gender fluid'
			when   '50505'   THEN 'Male'
			when   '50506'   THEN 'Trans female'
			when   '50507'   THEN 'Trans male'
			when   '50508'   THEN 'Other - Write In:'
			when   '50601'   THEN 'Prefer not to answer'
			when   '50602'   THEN 'Asexual'
			when   '50603'   THEN 'Bisexual or Pansexual'
			when   '50604'   THEN 'Gay or Lesbian'
			when   '50605'   THEN 'Heterosexual or Straight'
			when   '50606'   THEN 'Questioning or Unsure'
			when   '50607'   THEN 'Other - Write In:'
			when   '50701'   THEN 'Prefer not to answer'
			when   '50702'   THEN 'White, European, Caucasian'
			when   '50703'   THEN 'East Asian, South East Asian'
			when   '50704'   THEN 'Black, African, Caribbean'
			when   '50705'   THEN 'Indigenous to North America'
			when   '50706'   THEN 'First Nation'
			when   '50707'   THEN 'Métis'
			when   '50708'   THEN 'Inuit'
			when   '50709'   THEN 'Indigenous (non-specified)'
			when   '50710'   THEN 'Middle Eastern, North African, Arab'
			when   '50711'   THEN 'Latin American'
			when   '50712'   THEN 'Other - Write In'
			when   '50801'   THEN 'Newcomer, Recent Immigrant, Refugee'
			when   '50802'   THEN 'Home with Family Members/Guardians'
			when   '50803'   THEN 'Member of a Military Family'
			when   '50804'   THEN 'Living Independently/with Peers'
			when   '50805'   THEN 'School Residence'
			when   '50806'   THEN 'In Hospital, Treatment Centre, Recovery Home'
			when   '50807'   THEN 'Homeless, Living in a Shelter'
			when   '50808'   THEN 'Youth in Care, Foster Care, Group Home'
			when   '50809'   THEN 'In Custody or on conditional release'
			when   '50810'   THEN 'Other - Write In:'
			when   '50811'   THEN 'Prefer not to answer OR none of the above'
			when   '50901'   THEN 'Large city (more than 100,000 people)'
			when   '50902'   THEN 'Small city or large town (10,000 to 99,999 people)'
			when   '50903'   THEN 'Rural area or small town (fewer than 10,000 people)'
			when   '50904'   THEN 'First Nations Reserve'
			when   '50905'   THEN 'I do not know'
			when   '50906'   THEN 'Other - Write In:'
			when   '51101'   THEN 'Yes'
			when   '51102'   THEN 'No'
			when   '51301'   THEN 'Yes'
			when   '51302'   THEN 'No'
			when   '51401'   THEN 'Yes'
			when   '51402'   THEN 'No'
			when   '51801'   THEN 'Yes - You may share my answer to the previous question as appropriate'
			when   '51802'   THEN 'No - You many not share my answer to the previous question with anyone'
		  ELSE [surveyAnswer]
	  end as [surveyAnswer]
      ,[language]
      ,[surveyAnswer_Device]
      ,[surveyAnswer_CreatedDate]
  FROM 
  [RAM].[survey].[surveyanswer] as a left join [survey].[surveyQuestionOpt] as qo on a.[surveyAnswer] = qo.surveyQuestionOpt_en
  left join 
  [survey].[surveyQuestion] as q on a.[surveyQuestion_ID] = q.[surveyQuestion_ID]