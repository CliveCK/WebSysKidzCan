CREATE TABLE luPatientStatus
(
	PatientStatusID int IDENTITY(1,1) not null,
	Description varchar(255) null
)
GO

Alter table tblPatients
add StatusID int
GO

/****** Object:  StoredProcedure [dbo].[sp_Save_Patients]    Script Date: 06/01/2016 10:44:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_Save_Patients] 
( 
	@PatientID int = null output, 
	@PatientNo varchar(255) = null, 
	@ReligionID int = null, 
	@MedicalAidTypeID int = null, 
	@StatusID int = null,
	@OrphanhoodID int = null, 
	@ClosestHealthCenterID int = null, 
	@SchoolID int = null, 
	@UpdatedBy int = null, 
	@DOB datetime = null, 
	@DOD datetime = null,
	@FirstName varchar(150) = null, 
	@Surname varchar(150) = null, 
	@MaritalStatus varchar(150) = null, 
	@Sex varchar(20) = null,
	@TelephoneNo varchar(255) = null
) 
AS 
BEGIN 
 
	IF @PatientID IS NULL OR @PatientID <= 0 
	BEGIN 
		 
		SELECT @PatientID = NULL 
 
		INSERT INTO [tblPatients](
			[PatientNo],
			[ReligionID], 
			[MedicalAidTypeID], 
			[StatusID],
			[OrphanhoodID], 
			[ClosestHealthCenterID], 
			[SchoolID], 
			[DOB], 
			[DOD],
			[FirstName], 
			[Surname], 
			[MaritalStatus], 
			[Sex], 	[TelephoneNo],		[CreatedDate], 			[CreatedBy]
		) VALUES ( 
			@PatientNo,
			@ReligionID, 
			@MedicalAidTypeID, 
			@StatusID,
			@OrphanhoodID, 
			@ClosestHealthCenterID, 
			@SchoolID, 
			@DOB, 
			@DOD,
			@FirstName, 
			@Surname, 
			@MaritalStatus, 
			@Sex, 
			@TelephoneNo,
			getdate(), 
			@UpdatedBy
		) 
	END 
	ELSE 
	BEGIN 
		UPDATE [tblPatients] SET  
			[PatientNo]=@PatientNo,
			[ReligionID]=@ReligionID, 
			[MedicalAidTypeID]=@MedicalAidTypeID, 
			[StatusID]=@StatusID,
			[OrphanhoodID]=@OrphanhoodID, 
			[ClosestHealthCenterID]=@ClosestHealthCenterID, 
			[SchoolID]=@SchoolID, 
			[UpdatedBy]=@UpdatedBy, 
			[DOB]=@DOB, 
			[DOD]=@DOD,
			[FirstName]=@FirstName, 
			[Surname]=@Surname, 
			[MaritalStatus]=@MaritalStatus, 
			[Sex]=@Sex, 
			[TelephoneNo]=@TelephoneNo,
			[UpdatedDate] = getdate()

		WHERE [PatientID]=@PatientID 
	END 
 
	SELECT @PatientID = ISNULL(@PatientID, SCOPE_IDENTITY()) 
	SELECT * FROM (SELECT @PatientID AS ReturnID) AS PatientsReturnTable 
 
	RETURN @PatientID 
 
END 
 
