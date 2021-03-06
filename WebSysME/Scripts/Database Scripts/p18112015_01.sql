
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/****** Object:  StoredProcedure [dbo].[FetchMessages]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FetchMessages]	
	(
	@recieverId varchar(50)
	)	
AS
	select * from Messages where recieverID = @recieverId order by datentime DESC
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[GetSentMessages]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSentMessages]	
	(
	@userId varchar(50)
	)	
AS
	Select * from Messages where senderID = @userId order by datentime DESC
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[GetUserDEtails]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserDEtails]	
	(
	@userId varchar(50)
	)
AS
	select * from tblUsers where userId = @userId
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[GetUserList]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserList]

AS
	select userid, username from tblusers
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[MarkAsRead]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[MarkAsRead]	
	(
	@id int
	)	
AS
	update Messages 
	set status = 'R' where MessageID = @id
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[ReadMessage]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ReadMessage]
	(
	@id int,
	@userId varchar(50)
	)	
AS
	select * from Messages where MessageID = @id and (SenderID = @userId or recieverID = @userId)
	RETURN

GO
/****** Object:  StoredProcedure [dbo].[SendMessage]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SendMessage]
	(
	@senderId varchar(50),
	@recieverId varchar(50),
	@subject varchar(400),
	@body varchar(MAX)	
	)
AS
	insert into Messages(senderID, recieverID, subject, body, datentime) 
	Values(@senderId, @recieverId, @subject, @body, getdate())
	RETURN

GO

/****** Object:  Table [dbo].[Messages]    Script Date: 18/11/2015 13:34:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Messages](
	[MessageID] [bigint] IDENTITY(1,1) NOT NULL,
	[senderID] [nvarchar](50) NOT NULL,
	[recieverID] [nvarchar](50) NOT NULL,
	[subject] [varchar](400) NULL,
	[body] [nvarchar](max) NULL,
	[datenTime] [datetime] NOT NULL,
	[status] [nvarchar](1) NOT NULL,
 CONSTRAINT [PK_Messages] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[Messages] ADD  CONSTRAINT [DF_Messages_status]  DEFAULT (N'U') FOR [status]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users] FOREIGN KEY([senderID])
REFERENCES [dbo].[tblUsers] ([userId])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users]
GO
ALTER TABLE [dbo].[Messages]  WITH CHECK ADD  CONSTRAINT [FK_Messages_Users1] FOREIGN KEY([recieverID])
REFERENCES [dbo].[tblUsers] ([userId])
GO
ALTER TABLE [dbo].[Messages] CHECK CONSTRAINT [FK_Messages_Users1]
GO
