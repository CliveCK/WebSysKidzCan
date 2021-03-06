CREATE TABLE tblGroupMaturityIndex
(
	GroupMaturityIndexID int IDENTITY(1,1) not null,
	GroupID int not null,
	KeyAreaID int null,
	MonthID int null,
	Year int null,
	Score varchar(150) null,
	CreatedBy int null,
	CreatedDate datetime null,
	UpdatedBy int null,
	UpdatedDate datetime null
)

GO


CREATE PROCEDURE [dbo].[sp_Save_GroupMaturityIndex] 
( 
	@GroupMaturityIndexID int = null output,  
	@GroupID int = null, 
	@KeyAreaID int = null, 
	@MonthID int = null, 
	@Year int = null, 
	@UpdatedBy int = null, 
	@Score varchar(150) = null
) 
AS 
BEGIN 
 
	IF @GroupMaturityIndexID IS NULL OR @GroupMaturityIndexID <= 0 
	BEGIN 
		 
		SELECT @GroupMaturityIndexID = NULL 
 
		INSERT INTO [tblGroupMaturityIndex](
			[GroupID], 
			[KeyAreaID], 
			[MonthID], 
			[Year], 
			[Score], 			[CreatedDate], 			[CreatedBy]
		) VALUES ( 

			@GroupID, 
			@KeyAreaID, 
			@MonthID, 
			@Year, 
			@Score, 
			getdate(), 
			@UpdatedBy
		) 
	END 
	ELSE 
	BEGIN 
		UPDATE [tblGroupMaturityIndex] SET  
			[GroupID]=@GroupID, 
			[KeyAreaID]=@KeyAreaID, 
			[MonthID]=@MonthID, 
			[Year]=@Year, 
			[UpdatedBy]=@UpdatedBy, 
			[Score]=@Score, 
			[UpdatedDate] = getdate()

		WHERE [GroupMaturityIndexID]=@GroupMaturityIndexID 
	END 
 
	SELECT @GroupMaturityIndexID = ISNULL(@GroupMaturityIndexID, SCOPE_IDENTITY()) 
	SELECT * FROM (SELECT @GroupMaturityIndexID AS ReturnID) AS GroupMaturityIndexReturnTable 
 
	RETURN @GroupMaturityIndexID 
 
END 
 
GO

CREATE TABLE luMaturityArea
(
	MaturityAreaID int IDENTITY(1,1) not null,
	Description varchar(255) null
)
GO

ALter table tblOrganization
add WebsiteAddress varchar(255) 
GO

/****** Object:  StoredProcedure [dbo].[sp_Save_Organization]    Script Date: 05/02/2016 13:22:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_Save_Organization] 
( 
	@OrganizationID int = null output,  
	@WardID int = null, 
	@OrganizationTypeID int = null, 
	@Longitude numeric = null, 
	@Latitude numeric = null, 
	@ContactNo bigint = null, 
	@Name varchar(150) = null, 
	@Description varchar(255) = null, 
	@ContactName varchar(150) = null,
	@Address varchar(255) = null,
	@EmailAddress varchar(150) = null,
	@WebsiteAddress varchar(255) = null
) 
AS 
BEGIN 
 
	IF @OrganizationID IS NULL OR @OrganizationID <= 0 
	BEGIN 
		 
		SELECT @OrganizationID = NULL 
 
		INSERT INTO [tblOrganization](
			[WardID], 
			[OrganizationTypeID], 
			[Longitude], 
			[Latitude], 
			[ContactNo], 
			[Name], 
			[Description], 
			[ContactName],
			[Address],
			[EmailAddress],
			[WebsiteAddress]
		) VALUES ( 

			@WardID, 
			@OrganizationTypeID, 
			@Longitude, 
			@Latitude, 
			@ContactNo, 
			@Name, 
			@Description, 
			@ContactName,
			@Address,
			@EmailAddress,
			@WebsiteAddress
		) 
	END 
	ELSE 
	BEGIN 
		UPDATE [tblOrganization] SET  
			[WardID]=@WardID, 
			[OrganizationTypeID]=@OrganizationTypeID, 
			[Longitude]=@Longitude, 
			[Latitude]=@Latitude, 
			[ContactNo]=@ContactNo, 
			[Name]=@Name, 
			[Description]=@Description, 
			[ContactName]=@ContactName,
			[Address]=@Address,
			[EmailAddress]=@EmailAddress,
			[WebsiteAddress]=@WebsiteAddress
		WHERE [OrganizationID]=@OrganizationID 
	END 
 
	SELECT @OrganizationID = ISNULL(@OrganizationID, SCOPE_IDENTITY()) 
	SELECT * FROM (SELECT @OrganizationID AS ReturnID) AS OrganizationReturnTable 
 
	RETURN @OrganizationID 
 
END 
 
GO