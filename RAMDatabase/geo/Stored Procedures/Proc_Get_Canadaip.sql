CREATE PROCEDURE [geo].[Proc_Get_Canadaip] 
@ip bigint,
@token nvarchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @R INT;
	SELECT TOP (1) @R = [ACLID] FROM [dbo].[AccessControlList] WHERE @TOKEN = [ACLToken] AND [ACLActivity] = 1
    
	IF @R > 0 
		BEGIN 
			SELECT RTRIM(LTRIM(c.[country])) as country FROM [geo].[canadaip] as c WHERE c.[start_ip] <= @ip AND  @ip <= c.[end_ip]
		END
END

GO
GRANT EXECUTE
    ON OBJECT::[geo].[Proc_Get_Canadaip] TO PUBLIC
    AS [chatuser];


GO
GRANT ALTER
    ON OBJECT::[geo].[Proc_Get_Canadaip] TO [RAMUser]
    AS [chatuser];


GO
GRANT CONTROL
    ON OBJECT::[geo].[Proc_Get_Canadaip] TO [RAMUser]
    AS [chatuser];


GO
GRANT EXECUTE
    ON OBJECT::[geo].[Proc_Get_Canadaip] TO [RAMUser]
    AS [chatuser];


GO
GRANT TAKE OWNERSHIP
    ON OBJECT::[geo].[Proc_Get_Canadaip] TO [RAMUser]
    AS [chatuser];


GO
GRANT VIEW DEFINITION
    ON OBJECT::[geo].[Proc_Get_Canadaip] TO [RAMUser]
    AS [chatuser];

