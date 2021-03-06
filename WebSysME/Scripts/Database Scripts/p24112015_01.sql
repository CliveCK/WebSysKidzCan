USE [PrimaSysActionAid]
GO
/****** Object:  StoredProcedure [dbo].[GetSentMessages]    Script Date: 24/11/2015 13:23:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].GetMessageCount	
	(
	@userId varchar(50),
	@type int
	)	
AS

DECLARE @SqlStr varchar(MAX);

	IF @type = 1 --New 
			Select Count(*) as MsgCount from Messages where senderID <> @userId and [Status] = 'N' and Deleted = 0
	ELSE IF @type = 2  --Outbox
			Select Count(*) as MsgCount from Messages where senderID = @userId and Deleted = 0
	ELSE IF @type = 3  --Deleted
			Select Count(*) as MsgCount from Messages where [Deleted] = 1 
	RETURN

