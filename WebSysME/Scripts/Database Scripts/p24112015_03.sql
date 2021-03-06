USE [PrimaSysActionAid]
GO
/****** Object:  StoredProcedure [dbo].[FetchMessages]    Script Date: 25/11/2015 01:00:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[FetchMessages]	
	(
	@recieverId varchar(50)
	)	
AS
	select CASE WHEN LTRIM(RTRIM(ISNULL(S.UserFirstName, '') + '' + ISNULL(S.UserSurname, ''))) = '' THEN S.Username ELSE ISNULL(S.UserFirstName, '') + '' + ISNULL(S.UserSurname, '') END As Name 
	, M.* from Messages M inner join tblUsers S on M.senderID = S.UserID where recieverID = @recieverId order by datentime DESC
	RETURN

