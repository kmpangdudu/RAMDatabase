select * from RamResource where publicname like '%open doors career%'
select * from RamResource where publicname like '%city of toronto housing%'
select * from RamResource where publicname like '%Skylark Children, Youth and Family Services - Delisle Centralized Access to Residential Services%'

-- topcategory 
-- 1: Counselling;   2:Violence;  3: Violence;   4: Housing;   5:Jobs;    6:Indigenous;  7:Drugs;   8:LGBTQ;   10:Legal
-- ResourceAgencyNum = 12469031       Open Doors Career Resource Centre at Open Doors Career Resource Centre 
-- ResourceAgencyNum = 34061367       Kids Help Phone - Live Chat Counselling
-- ResourceAgencyNum = 12390426       City of Toronto Housing Services - Central Intake  at City of Toronto - Housing - Central Intake
-- ResourceAgencyNum = 17101600       Skylark Children, Youth and Family Services
--  resourceagencryNum = 39970478  Canadian Red Cross - Healthy Youth Relationships
-- KHP keywords = '1/en/34061367/List/1'     Kids Help Phone - Telephone Counselling
-- KHP csurl = 'https://ramapi.kidshelpphone.ca/api/v2/resource/favour/json/9BB1408A-81DD-43D1-B621-83E2F71D2669/en/List/34061367/1/1'

declare @toronto_KWS nvarchar(2000) =  '4/en/12390426/Mapped/9'-- City of Toronto Housing Services
declare @Toronto_url nvarchar(2000) = 'https://ramapi.kidshelpphone.ca/api/v2/resource/favour/json/9BB1408A-81DD-43D1-B621-83E2F71D2669/en/Mapped/12390426/9/4'-- City of Toronto Housing Services

-- 
declare @RedCross_KWS nvarchar(2000) =N'2/en/39970478/Mapped/4' 
declare @RedCross_url nvarchar(2000) =N'https://ramapi.kidshelpphone.ca/api/v2/resource/favour/json/9BB1408A-81DD-43D1-B621-83E2F71D2669/en/Mapped/39970478/4/2'    
--  Skylark Children  
  declare @Skylark_KWS nvarchar(2000) = N'1/en/17101600/List/1'
--  Skylark Children  
  declare @Skylark_url nvarchar(2000) = N'https://ramapi.kidshelpphone.ca/api/v2/resource/favour/json/9BB1408A-81DD-43D1-B621-83E2F71D2669/en/List/17101600/1/1'

--  select * from apilog where keywords like '%17101600%' 
--  select * from V_All_top10_Frequently_Clicked_Resources order by [all Num] DESC
--  select * from [dbo].[V_LastWeek_Top10_Frequently_Clicked_Resources] order by [last week Num] DESC
 declare @Youth_Services_KWS nvarchar(2000) = '4/en/12411805/Mapped/9'
 declare @Youth_Services_url nvarchar(2000) ='https://ramapi.kidshelpphone.ca/api/v2/resource/favour/json/9BB1408A-81DD-43D1-B621-83E2F71D2669/en/Mapped/12411805/9/4'
declare @keywords nvarchar(200) = @Youth_Services_KWS  
declare @csurl    nvarchar(500) = @Youth_Services_url
-- select * from apilog where keywords like '%12390426%'      --- find out open doors career
update apilog set keywords = @keywords, csurl = @csurl
where apilogid in (100123)

