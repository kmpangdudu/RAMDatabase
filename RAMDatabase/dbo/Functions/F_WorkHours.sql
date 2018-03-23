-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[F_WorkHours] 
(
	-- Add the parameters for the function here
@id  bigint
)
RETURNS 
 @T_WorkHours TABLE 
(
  ID int,
  WorkHours varchar(100)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	
	 --待分拆的字符串 
declare @s   varchar(max);
select @s=WorkHours from  [dbo].[TaxonomyRAW]   where ETLLOadID = @id;
--- remove last ";" or "space"
  Select @s = SUBSTRING(@s, 0, LEN(@s))
--- select @s='LH-2700.6500'
 select @s =  REPLACE(@s,'*',';') ;
  --数据分隔符
 DECLARE @splitlen int;
 SET @splitlen=LEN(';'+'a')-2;

 

 
 WHILE CHARINDEX(';',@s)>0
 BEGIN

	if (not exists (select WorkHours from @T_WorkHours where WorkHours =   LEFT(@s,CHARINDEX(';',@s)-1)))
		INSERT into  @T_WorkHours  (id, WorkHours) VALUES( @ID, LEFT(@s,CHARINDEX(';',@s)-1) )  ;
 
	SET @s=RTRIM(LTRIM(STUFF(@s,1,CHARINDEX(';',@s)+@splitlen,'')));
 
 END;

 if ( not exists (select WorkHours from  @T_WorkHours where WorkHours = @s) )
 INSERT into  @T_WorkHours  (ID, WorkHours) VALUES(@ID, @s);


 
 

	RETURN 
END
