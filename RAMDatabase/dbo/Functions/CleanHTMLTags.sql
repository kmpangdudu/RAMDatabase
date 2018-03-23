CREATE FUNCTION [dbo].[CleanHTMLTags] (@HTMLText VARCHAR(MAX),@ReplaceChar char(1))
RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE @Start INT
DECLARE @End INT
DECLARE @Length INT
SET @Start = CHARINDEX('<',@HTMLText) SET @End = CHARINDEX('>',@HTMLText,
    CHARINDEX('<',@HTMLText)) SET @Length = (@End - @Start) + 1 
    WHILE @Start > 0 AND @End > 0 AND @Length > 0
BEGIN
IF (UPPER(SUBSTRING(@HTMLText, @Start, 4)) <> '') AND (UPPER(SUBSTRING(@HTMLText, @Start, 5)) <> '')
begin
SET @HTMLText = RTRIM(LTRIM(STUFF(@HTMLText,@Start,@Length,@ReplaceChar)));
end
ELSE
SET @Length = 0;
SET @Start = CHARINDEX('<',@HTMLText, @End-@Length) 
    SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText, @Start))
SET @Length = (@End - @Start) + 1
END
RETURN isnull(RTRIM(LTRIM(@HTMLText)) ,'')
END