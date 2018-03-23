-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[InterestTaxonomyCode_Splite] 
 @s   varchar(max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 --待分拆的字符串 
--declare @s   varchar(8000) = 'HL-8120.7950; RF-2500 * YG-8000.1500; RF-3300 * YG-8000.1500; RP-1500.3300 * YG-8000.1500'  

--declare @split varchar(10) = ';'     --数据分隔符

 truncate table [T_TaxonomyCode] -- clearn tamp table

 select @s =  REPLACE(@s,'*',';') 
 
 DECLARE @splitlen int
 SET @splitlen=LEN(';'+'a')-2
 WHILE CHARINDEX(';',@s)>0
 BEGIN

 
 

 if (not exists (select [TaxonomyCode] from [dbo].[T_TaxonomyCode] where [TaxonomyCode] =   LEFT(@s,CHARINDEX(';',@s)-1)))


INSERT into  [T_TaxonomyCode] ([TaxonomyCode] ) VALUES(  LEFT(@s,CHARINDEX(';',@s)-1) )  
 
 
  SET @s=RTRIM(LTRIM(STUFF(@s,1,CHARINDEX(';',@s)+@splitlen,'')))
 
 END

 if ( not exists (select [TaxonomyCode] from [dbo].[T_TaxonomyCode] where [TaxonomyCode] = @s) )
 INSERT into [T_TaxonomyCode] ([TaxonomyCode]) VALUES(@s)
 



 
END
