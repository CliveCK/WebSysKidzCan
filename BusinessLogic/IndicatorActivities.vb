﻿Imports Microsoft.Practices.EnterpriseLibrary.Data 
Imports Universal.CommonFunctions 

Public Class IndicatorActivities

#region "Variables"

    Protected mIndicatorActivityID As long
    Protected mIndicatorID As long
    Protected mActivityID As long
    Protected mCreatedBy As long
    Protected mUpdatedBy As long
    Protected mCreatedDate As string
    Protected mUpdatedDate As string

    Protected db As Database 
    Protected mConnectionName As String 
    Protected mObjectUserID As Long 

    Private Shared ReadOnly log As log4net.ILog = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType)

#end region

#region "Properties"

    Public ReadOnly Property Database() As Database 
        Get 
            Return db 
        End Get 
    End Property 
     
    Public ReadOnly Property OwnerType() As String 
        Get 
            Return Me.GetType.Name 
        End Get 
    End Property 

    Public ReadOnly Property ConnectionName() As String 
        Get 
            Return mConnectionName 
        End Get 
    End Property 

    Public  Property IndicatorActivityID() As long
        Get
		return mIndicatorActivityID
        End Get
        Set(ByVal value As long)
		mIndicatorActivityID = value
        End Set
    End Property

    Public  Property IndicatorID() As long
        Get
		return mIndicatorID
        End Get
        Set(ByVal value As long)
		mIndicatorID = value
        End Set
    End Property

    Public  Property ActivityID() As long
        Get
		return mActivityID
        End Get
        Set(ByVal value As long)
		mActivityID = value
        End Set
    End Property

    Public  Property CreatedBy() As long
        Get
		return mCreatedBy
        End Get
        Set(ByVal value As long)
		mCreatedBy = value
        End Set
    End Property

    Public  Property UpdatedBy() As long
        Get
		return mUpdatedBy
        End Get
        Set(ByVal value As long)
		mUpdatedBy = value
        End Set
    End Property

    Public  Property CreatedDate() As string
        Get
		return mCreatedDate
        End Get
        Set(ByVal value As string)
		mCreatedDate = value
        End Set
    End Property

    Public  Property UpdatedDate() As string
        Get
		return mUpdatedDate
        End Get
        Set(ByVal value As string)
		mUpdatedDate = value
        End Set
    End Property

#end region

#region "Methods"

#Region "Constructors" 
 
    Public Sub New(ByVal ConnectionName As String, ByVal ObjectUserID As Long) 

        mObjectUserID = ObjectUserID 
        mConnectionName = ConnectionName 
        db = New DatabaseProviderFactory().Create(ConnectionName)

    End Sub 

#End Region 

Public Sub Clear()  

    IndicatorActivityID = 0
    mIndicatorID = 0
    mActivityID = 0
    mCreatedBy = mObjectUserID
    mUpdatedBy = 0
    mCreatedDate = ""
    mUpdatedDate = ""

End Sub

#Region "Retrieve Overloads" 

    Public Overridable Function Retrieve() As Boolean 

        Return Me.Retrieve(mIndicatorActivityID) 

    End Function 

    Public Overridable Function Retrieve(ByVal IndicatorActivityID As Long) As Boolean 

        Dim sql As String 

        If IndicatorActivityID > 0 Then 
            sql = "SELECT * FROM tblIndicatorActivities WHERE IndicatorActivityID = " & IndicatorActivityID
        Else 
            sql = "SELECT * FROM tblIndicatorActivities WHERE IndicatorActivityID = " & mIndicatorActivityID
        End If 

        Return Retrieve(sql) 

    End Function 

    Protected Overridable Function Retrieve(ByVal sql As String) As Boolean 

        Try 

            Dim dsRetrieve As DataSet = db.ExecuteDataSet(CommandType.Text, sql) 

            If dsRetrieve IsNot Nothing AndAlso dsRetrieve.Tables.Count > 0 AndAlso dsRetrieve.Tables(0).Rows.Count > 0 Then 

                LoadDataRecord(dsRetrieve.Tables(0).Rows(0)) 

                dsRetrieve = Nothing 
                Return True 

            Else 

                log.error("IndicatorActivities not found.")

                Return False

            End If

        Catch e As Exception

            log.error(e)
            Return False

        End Try

    End Function

    Public Overridable Function GetIndicatorActivities() As System.Data.DataSet

        Return GetIndicatorActivities(mIndicatorActivityID)

    End Function

    Public Overridable Function GetIndicatorActivities(ByVal IndicatorActivityID As Long) As DataSet

        Dim sql As String

        If IndicatorActivityID > 0 Then
            sql = "SELECT * FROM tblIndicatorActivities WHERE IndicatorActivityID = " & IndicatorActivityID
        Else
            sql = "SELECT * FROM tblIndicatorActivities WHERE IndicatorActivityID = " & mIndicatorActivityID
        End If

        Return GetIndicatorActivities(sql)

    End Function

    Protected Overridable Function GetIndicatorActivities(ByVal sql As String) As DataSet

        Return db.ExecuteDataSet(CommandType.Text, sql)

    End Function

#End Region

    Protected Friend Overridable Sub LoadDataRecord(ByRef Record As Object)

        With Record

            mIndicatorActivityID = Catchnull(.Item("IndicatorActivityID"), 0)
            mIndicatorID = Catchnull(.Item("IndicatorID"), 0)
            mActivityID = Catchnull(.Item("ActivityID"), 0)
            mCreatedBy = Catchnull(.Item("CreatedBy"), 0)
            mUpdatedBy = Catchnull(.Item("UpdatedBy"), 0)
            mCreatedDate = Catchnull(.Item("CreatedDate"), "")
            mUpdatedDate = Catchnull(.Item("UpdatedDate"), "")

        End With

    End Sub

#Region "Save"

    Public Overridable Sub GenerateSaveParameters(ByRef db As Database, ByRef cmd As System.Data.Common.DbCommand)

        db.AddInParameter(cmd, "@IndicatorActivityID", DBType.Int32, mIndicatorActivityID)
        db.AddInParameter(cmd, "@IndicatorID", DBType.Int32, mIndicatorID)
        db.AddInParameter(cmd, "@ActivityID", DBType.Int32, mActivityID)
        db.AddInParameter(cmd, "@UpdatedBy", DBType.Int32, mObjectUserID)

    End Sub

    Public Overridable Function Save() As Boolean

        Dim cmd As System.Data.Common.DbCommand = db.GetStoredProcCommand("sp_Save_IndicatorActivities")

        GenerateSaveParameters(db, cmd)

        Try

            Dim ds As DataSet = db.ExecuteDataSet(cmd)

            If ds IsNot Nothing AndAlso ds.Tables.Count > 0 AndAlso ds.Tables(0).Rows.Count > 0 Then

                mIndicatorActivityID = ds.Tables(0).Rows(0)(0)

            End If

            Return True

        Catch ex As Exception

            log.error(ex)
            Return False

        End Try

    End Function

#End Region

#Region "Delete"

    Public Overridable Function Delete() As Boolean

        'Return Delete("UPDATE tblIndicatorActivities SET Deleted = 1 WHERE IndicatorActivityID = " & mIndicatorActivityID) 
        Return Delete("DELETE FROM tblIndicatorActivities WHERE IndicatorActivityID = " & mIndicatorActivityID)

    End Function

    Public Function DeleteEntries() As Boolean

        Return Delete("DELETE FROM tblIndicatorActivities WHERE IndicatorID = " & mIndicatorID & " AND ActivityID = " & mActivityID)

    End Function

    Protected Overridable Function Delete(ByVal DeleteSQL As String) As Boolean

        Try

            db.ExecuteNonQuery(CommandType.Text, DeleteSQL)
            Return True

        Catch e As Exception

            log.error(e)
            Return False

        End Try

    End Function

#End Region

#end region

End Class