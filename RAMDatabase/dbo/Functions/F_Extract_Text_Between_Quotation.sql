-- =============================================
-- Author:		William Chen
-- Create date: Aug.8, 2016
-- Description:	Extract text between double quotation mark, so that the key works can be searched as whole section
-- Example: when user enter "24.7 "
-- Default delimiter is double qutiation "
-- =============================================
CREATE FUNCTION F_Extract_Text_Between_Quotation
(
	-- Add the parameters for the function here
	@kws NVARCHAR(4000)
)
RETURNS NVARCHAR(4000)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @words NVARCHAR(4000);
	DECLARE @delimiter NVARCHAR(5) = '"' ;  -- delimiter mark, here is double quotation "

		
		SET @words = LTRIM(RTRIM(@KWS)); -- remove any space front and rear 
		DECLARE @Orginal_len INT = LEN(@words);  -- inpute key words length, includes quotation mark 
		DECLARE @first INT = CHARINDEX( @delimiter, @words); -- the first quotation index
		DECLARE @last INT = CHARINDEX(    @delimiter,   REVERSE(@words)  ); -- last qutation index

		declare @myvar nvarchar(4000) = @words; -- Declare a test variable to how many quotation are there in the keywors 
		set @myvar = replace (@myvar, '"','')  -- remove double quotation marks
	 
		-- process trailing space issue
		-- this LEN(REPLACE(@myvar, @delimiter,'') + 'a') -1 solve SQL Server LEN function not including trailing spaces
		set @myvar = @myvar + 'a';  -- in case, there are spaces before last double quotation mark
		declare @final_len int
		set @final_len = len(@myvar)-1;  -- because above add a char 'a', so here his lenth should min 1


		IF ((@Orginal_len - @final_len = 2) AND (@first = 1) AND (@last = 1)) 
			BEGIN -- Quotation in a pair, 1st quotation is at 1st letter, and last quotation is at last letter
				DECLARE @bl int = @Orginal_len - @first - @last  -- how many letters are there between the first quotation" and the last Quotation "
				SET @words = SUBSTRING (@words,  CHARINDEX(@delimiter, @words) + 1,  @bl  );
				SET @words = LTRIM(RTRIM(@words)); -- remove any space front and rear AGAIN
			END
		ELSE   -- Quotation is NOT in pair; or are not at 1st and last letter
			BEGIN
				SET @words = '';  -- return a empty string, do not need process
			END

	-- Return the result of the function
	RETURN @words

END
