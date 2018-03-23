-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE  [dbo].[splite_map_and_WP_1]
 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
Create table #find (eid int); 

 declare mycursor cursor for select etlloadid  ,  ParentAgencyNum from TaxonomyRAW
 open mycursor

 
 declare @eid int
 declare @ParentAgencyNum varchar(50)
 
 fetch next from mycursor into   @eid,   @ParentAgencyNum 

 while @@FETCH_STATUS =0
 begin 

 if not exists 
		 (
			select   etlloadid  from RAMRAW join TaxonomyLevelName as t on RAMRAW.taxonomylevelnameid=t.TaxonomyLevelNameID where parentagencynum = @ParentAgencyNum and RAMRAW.taxonomylevelnameid in (2,4)
		 )
 begin
 insert into #find	select etlloadid from  TaxonomyRAW   where etlloadid = @eid
 end 

 fetch next from mycursor into  @eid,  @ParentAgencyNum 
 end

 close mycursor
 deallocate mycursor


 select * from  #find


 select etlloadid, resourceagencynum,TaxonomyLevelNameID, ParentAgencyNum from TaxonomyRAW where etlloadid in ( select eid from  #find)
 select  eid, * from NewRam left join #find on eid = etlloadid  where eid is not null




END
