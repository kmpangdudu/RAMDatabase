CREATE VIEW dbo.V_Build_Pages
AS
SELECT       N'https://ramapi.kidshelpphone.ca/api/v2/resource/favour/json/9BB1408A-81DD-43D1-B621-83E2F71D2669/' +    LanguageOfRecord+N'/'+ Map+ N'/' + ResourceAgencyNum+N'/'   + Convert(Nvarchar(2),SubCategoryID) +N'/'+  convert(NVARCHAR(2),TOPCategoryID)  as [pages]
FROM            RamResource