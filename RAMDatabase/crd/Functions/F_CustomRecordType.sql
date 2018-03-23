-- =============================================
-- Author:		William Chen
-- Create date: 2017-10-24
-- Description:	pivot CustomRecordType 
-- =============================================
CREATE FUNCTION [crd].[F_CustomRecordType] 
(
	-- Add the parameters for the function here
@id  bigint
)
RETURNS 
 @T_CustomRecordType TABLE 
(
  ID int,
  CustomRecordType varchar(255)
)
AS
BEGIN
	-- Fill the table variable with the rows for your result set
	
	 --待分拆的字符串 
declare @s   varchar(max);
select @s= [CustomRecordType] from  [dbo].[ETLLOAD]  where ETLLOadID = @id;
--- select @s='RAM'
 select @s =  REPLACE(@s,'*',';') ;
  --数据分隔符
 DECLARE @splitlen int;
 SET @splitlen=LEN(';'+'a')-2;

 

 
 WHILE CHARINDEX(';',@s)>0
 BEGIN

	if (not exists (select CustomRecordType from @T_CustomRecordType where CustomRecordType =   LEFT(@s,CHARINDEX(';',@s)-1)))
		INSERT into  @T_CustomRecordType  (id,[CustomRecordType] ) VALUES( @ID, LEFT(@s,CHARINDEX(';',@s)-1) )  ;
 
	SET @s=RTRIM(LTRIM(STUFF(@s,1,CHARINDEX(';',@s)+@splitlen,'')));
 
 END;

 if ( not exists (select CustomRecordType from @T_CustomRecordType where [CustomRecordType] = @s) )
 INSERT into @T_CustomRecordType  (ID,[CustomRecordType]) VALUES(@ID,@s);


	RETURN 
END
