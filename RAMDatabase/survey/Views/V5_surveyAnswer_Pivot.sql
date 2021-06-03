

CREATE  VIEW [survey].[V5_surveyAnswer_Pivot]
as
 
with CTE1 as
(
select 
-- surveyAnswer_ID   as surveyAnswer_ID,
 chatID  ,
max(case when [surveyQuestion_ID] =  501  then surveyanswer end)   as [Nickname] , --501
max(case when [surveyQuestion_ID] =  502  then surveyanswer end)   as [What province or territory do you live in?] , --502
max(case when [surveyQuestion_ID] =  503  then surveyanswer end)   as [On a scale of 1 to 7, how upset are you right now?] , --503
max(case when [surveyQuestion_ID] =  504  then surveyanswer end)   as [How old are you?] , --504

--505 write in
max(case when [surveyQuestion_ID] =  505  then surveyanswer end)   as [Gender. Do you consider yourself to be:] ,  --505
MAX(case when [surveyQuestion_ID] =  505
		and UPPER (surveyanswer) !='50501'
		and UPPER (surveyanswer) !='50502'
		and UPPER (surveyanswer) !='50503'
		and UPPER (surveyanswer) !='50504'
		and UPPER (surveyanswer) !='50505'
		and UPPER (surveyanswer) !='50506'
		and UPPER (surveyanswer) !='50507'
		and UPPER (surveyanswer) !='50508'  -- write in
	then surveyanswer
end ) as '505 write in ',

max(case when [surveyQuestion_ID] =  506  then surveyanswer end)   as [Sexual orientation. Do you consider yourself to be:] ,  --506
max(case when [surveyQuestion_ID] =  506 
		and UPPER (surveyanswer) != '50601'
		and UPPER (surveyanswer) != '50602'
		and UPPER (surveyanswer) != '50603'
		and UPPER (surveyanswer) != '50604'
		and UPPER (surveyanswer) != '50605'
		and UPPER (surveyanswer) != '50606'
		and UPPER (surveyanswer) != '50607'  -- write in 
then surveyanswer
end ) as '506 write in',


max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50701' then surveyanswer end ) as '50701',	
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50702' then surveyanswer end ) as '50702',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50703' then surveyanswer end ) as '50703',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50704' then surveyanswer end ) as '50704',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50705' then surveyanswer end ) as '50705',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50706' then surveyanswer end ) as '50706',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50707' then surveyanswer end ) as '50707',                        -- < --- 
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50708' then surveyanswer end ) as '50708',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50709' then surveyanswer end ) as '50709',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50710' then surveyanswer end ) as '50710',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50711' then surveyanswer end ) as '50711',
max(case when [surveyQuestion_ID] =  507  and [surveyanswer] = '50712' then surveyanswer end ) as '50712',
MAX(case when [surveyQuestion_ID] =  507
			and UPPER ([surveyanswer]) != '50701'
			and UPPER ([surveyanswer]) != '50702'
			and UPPER ([surveyanswer]) != '50703'
			and UPPER ([surveyanswer]) != '50704'
			and UPPER ([surveyanswer]) != '50705'
			and UPPER ([surveyanswer]) != '50706'
			and UPPER ([surveyanswer]) != '50707'
			and UPPER ([surveyanswer]) != '50708'
			and UPPER ([surveyanswer]) != '50709'
			and UPPER ([surveyanswer]) != '50710'
			and UPPER ([surveyanswer]) != '50711'
			and UPPER ([surveyanswer]) != '50712' -- write in
		 then [surveyanswer]
	end ) as '507 write in',
	  
		-- as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply)] ,--507

max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50801' then surveyanswer end)   as '50801',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50802' then surveyanswer end)   as '50802',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50803' then surveyanswer end)   as '50803',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50804' then surveyanswer end)   as '50804',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50805' then surveyanswer end)   as '50805',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50806' then surveyanswer end)   as '50806',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50807' then surveyanswer end)   as '50807',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50808' then surveyanswer end)   as '50808',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50809' then surveyanswer end)   as '50809',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50810' then surveyanswer end)   as '50810',   
max(case when [surveyQuestion_ID] =  508 and surveyanswer = '50811' then surveyanswer end)   as '50811',  --  write in 
-- [Which of these best describes your current situation? (Select all that apply):]
max(case when 
		[surveyQuestion_ID] =  508 
			and UPPER (surveyanswer) != '50801'
		    and UPPER (surveyanswer) != '50802'
		    and UPPER (surveyanswer) != '50803'
		    and UPPER (surveyanswer) != '50804'
		    and UPPER (surveyanswer) != '50805'
		    and UPPER (surveyanswer) != '50806'
		    and UPPER (surveyanswer) != '50807'
		    and UPPER (surveyanswer) != '50808'
		    and UPPER (surveyanswer) != '50809'
		    and UPPER (surveyanswer) != '50810'  -- write in 
		    and UPPER (surveyanswer) != '50811'
then surveyanswer
end ) as '508 write in',

max(case when [surveyQuestion_ID] =  509 then surveyanswer end) as '509',   
 -- as [What kind of community do you live in?] ,  --509
max(case when [surveyQuestion_ID] =  509 
			and UPPER ([surveyanswer]) != '50901'
			and UPPER ([surveyanswer]) != '50902'
			and UPPER ([surveyanswer]) != '50903'
			and UPPER ([surveyanswer]) != '50904'
			and UPPER ([surveyanswer]) != '50905'
			and UPPER ([surveyanswer]) != '50906' -- write in 
			then [surveyanswer] end 
)	as '509 writr in',							 	 
 
max( [language] ) as [Site_Language],
max(surveyAnswer_Device) as [Device],
max(surveyAnswer_createdDate) as [surveyAnswer_Date]
from survey.surveyAnswer
where surveyAnswer_createdDate > '2021-03-01' and chatID !=1234567890 and chatID > 1350000
group by CHATID
),
CTE2 as
(
select ChatID,  [Nickname]
,case [What province or territory do you live in?]
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
     end as [What province or territory do you live in?]
,[On a scale of 1 to 7, how upset are you right now?] 

, case [How old are you?] 
			when   '50401'   THEN 'Prefer not to answer'
			when   '50402'   THEN '9 or younger'
			when   '50403'   THEN '10-13'
			when   '50404'   THEN '14-17'
			when   '50405'   THEN '18-24'
			when   '50406'   THEN '25-29'
			when   '50407'   THEN '30-69'
			when   '50408'   THEN '70+'
   end as [How old are you?] 


,case [Gender. Do you consider yourself to be:]
			when   '50501'   THEN 'Prefer not to answer'
			when   '50502'   THEN 'Agender'
			when   '50503'   THEN 'Female'
			when   '50504'   THEN 'Non-binary / Genderqueer / Gender fluid'
			when   '50505'   THEN 'Male'
			when   '50506'   THEN 'Trans female'
			when   '50507'   THEN 'Trans male'
	--		when   '50508'   THEN 'Other - Write In:'
end as [Gender. Do you consider yourself to be:]
,   [505 write in] as [Gender: write in]

, case [Sexual orientation. Do you consider yourself to be:]
			when   '50601'   THEN 'Prefer not to answer'
			when   '50602'   THEN 'Asexual'
			when   '50603'   THEN 'Bisexual or Pansexual'
			when   '50604'   THEN 'Gay or Lesbian'
			when   '50605'   THEN 'Heterosexual or Straight'
			when   '50606'   THEN 'Questioning or Unsure'
		--	when   '50607'   THEN 'Other - Write In:'
end as [Sexual orientation. Do you consider yourself to be:]
,[506 write in] as [Sexual orientation write in]
 
 , CONCAT (
     Case [50701] when '50701'  THEN  'Prefer not to answer,' end                 --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Prefer not to answer]
,    Case [50702] when '50702'  then  'White, European, Caucasian,'end            --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): White, European, Caucasian]
,    Case [50703] when '50703'  then  'East Asian, South East Asian,'end          --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): East Asian, South East Asian]
,    Case [50704] when '50704'  then  'Black, African, Caribbean,'end             --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Black, African, Caribbean]
,    Case [50705] when '50705'  then  'Indigenous to North America,'end           --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Indigenous to North America]
,    Case [50706] when '50706'  then  'First Nation,'end                          --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): First Nation]
,    Case [50707] when '50707'  then  'Métis,'end                                 --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Métis]
,    Case [50708] when '50708'  then  'Inuit,'end                                 --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Inuit]
,    Case [50709] when '50709'  then  'Indigenous (non-specified),'end            --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Indigenous (non-specified)]
,    Case [50710] when '50710'  then  'Middle Eastern, North African, Arab,'end   --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Middle Eastern, North African, Arab]
,    Case [50711] when '50711'  then  'Latin American,'end                        --as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Latin American]
--,    Case [50712] when '50712'  then  'Other - Write In'end as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply): Other - Write In]
) as [Race and Ethnicity. Do you consider yourself to be: (Select all that apply):]
,[507 write in]  as [Race and Ethnicity write in]

,concat (
   case [50801]	when   '50801'   THEN 'Newcomer, Recent Immigrant, Refugee'           end --as 'Which of these best describes your current situation? (Select all that apply):Newcomer, Recent Immigrant, Refugee'                
,  case [50802]	when   '50802'   THEN 'Home with Family Members/Guardians'			  end --as 'Which of these best describes your current situation? (Select all that apply):Home with Family Members/Guardians'			
,  case [50803]	when   '50803'   THEN 'Member of a Military Family'					  end --as 'Which of these best describes your current situation? (Select all that apply):Member of a Military Family'					
,  case [50804]	when   '50804'   THEN 'Living Independently/with Peers'				  end --as 'Which of these best describes your current situation? (Select all that apply):Living Independently/with Peers'				
,  case [50805]	when   '50805'   THEN 'School Residence'							  end --as 'Which of these best describes your current situation? (Select all that apply):School Residence'							
,  case [50806]	when   '50806'   THEN 'In Hospital, Treatment Centre, Recovery Home'  end --as 'Which of these best describes your current situation? (Select all that apply):In Hospital, Treatment Centre, Recovery Home'
,  case [50807]	when   '50807'   THEN 'Homeless, Living in a Shelter'				  end --as 'Which of these best describes your current situation? (Select all that apply):Homeless, Living in a Shelter'				
,  case [50808]	when   '50808'   THEN 'Youth in Care, Foster Care, Group Home'		  end --as 'Which of these best describes your current situation? (Select all that apply):Youth in Care, Foster Care, Group Home'		
,  case [50809]	when   '50809'   THEN 'In Custody or on conditional release'		  end --as 'Which of these best describes your current situation? (Select all that apply):In Custody or on conditional release'		
--,  case [50810]	when   '50810'   THEN 'Other - Write In:'						  end --as 'Which of these best describes your current situation? (Select all that apply):Other - Write In:'
,  case [50811]	when   '50811'   THEN 'Prefer not to answer OR none of the above'	  end --as 'Which of these best describes your current situation? (Select all that apply):Prefer not to answer OR none of the above'
) as [Which of these best describes your current situation? (Select all that apply):]
,[508 write in] as 	[Which of these best describes your current situation write in]																				   

,case [509] 
			when   '50901'   THEN 'Large city (more than 100,000 people)'
			when   '50902'   THEN 'Small city or large town (10,000 to 99,999 people)'
			when   '50903'   THEN 'Rural area or small town (fewer than 10,000 people)'
			when   '50904'   THEN 'First Nations Reserve'
			when   '50905'   THEN 'I do not know'
			when   '50906'   THEN 'Other - Write In:'
 end as [What kind of community do you live in?]
,[509 writr in] as [What kind of community do you live in: write in]
, Site_Language
, Device
, surveyAnswer_Date
from CTE1
)

select * from cte2   --  where chatid = 1396930