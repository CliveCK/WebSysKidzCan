﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EvaluationObjects.aspx.vb" Inherits="WebSysME.EvaluationObjects" MasterPageFile="~/Site.Master"%>


<table cellpadding="4" cellspacing="0" border="0" style="width:100%;margin-left:2%"> 
	<tr> 
		<td colspan="4" class="PageTitle"><h4>Survey Mapping</h4></td> 
	</tr> 
	<tr> 
		<td >Evaluation</td> 
        	<td ><telerik:RadAutoCompleteBox runat="server" ID="cboEvaluation" EmptyMessage="Please type here"
                TextSearchMode="Contains" SelectMethod="Single" InputType="Text" Width="350" DropDownWidth="150px" CssClass="form-control">
            </telerik:RadAutoCompleteBox></td> 
	</tr> 
	<tr> 
		<td >Map to:</td> 
        	<td ><asp:dropdownlist id="cboObjectType" runat="server" CssClass="form-control" AutoPostBack="true" ></asp:dropdownlist> </td> 
	</tr> 
	<tr> 
		<td colspan="2"> 
            		<asp:Panel id="pnlError" width="95%" runat="server" EnableViewState="False"><asp:label id="lblError" Width="100%" runat="server" CssClass="Error" EnableViewState="False"></asp:label></asp:Panel> 
     </td> 
	</tr>
	<tr> 
		<td colspan="2"><br />
            		<asp:button id="cmdSave" runat="server" Text="Save" CssClass="btn btn-default"></asp:button> <br />
     </td> 
	</tr>
    <tr>
        <td colspan="2"><br />
            <telerik:RadGrid ID="radObjects" runat="server" GridLines="None" Height="100%" 
                    AllowFilteringByColumn="True" CellPadding="0" Width="231%">
                    <MasterTableView AutoGenerateColumns="True" AllowPaging="True"  PagerStyle-Mode="NextPrevNumericAndAdvanced"
                        AlternatingItemStyle-BackColor="#66ccff">
                        <CommandItemSettings ExportToPdfText="Export to Pdf"></CommandItemSettings>
                        <Columns>
                            <telerik:GridBoundColumn DataField="ObjectID" UniqueName="ObjectID" HeaderText="ObjectID" Display="false" >
                            </telerik:GridBoundColumn>
                           <telerik:GridClientSelectColumn DataType="System.Boolean" FilterControlAltText="Filter chkRowSelect column"
                            UniqueName="chkRowSelect">
                        </telerik:GridClientSelectColumn>                        
                        </Columns>
                        <RowIndicatorColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </RowIndicatorColumn>
                        <ExpandCollapseColumn>
                            <HeaderStyle Width="20px"></HeaderStyle>
                        </ExpandCollapseColumn>
                        <EditFormSettings>
                            <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                            </EditColumn>
                        </EditFormSettings>
                    </MasterTableView>
                    <ClientSettings EnablePostBackOnRowClick="true">
                    </ClientSettings>
                    <FilterMenu EnableImageSprites="False">
                    </FilterMenu>
                </telerik:RadGrid>
        </td>
    </tr>
	<tr> 
		<td colspan="2"> 
			<asp:TextBox  id="txtDocumentObjectID" runat="server" Visible="false" ></asp:TextBox> 
		</td> 
	</tr> 
</table> 


