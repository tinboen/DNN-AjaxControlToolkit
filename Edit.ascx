<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Edit.ascx.cs" Inherits="DotNetNuke.Modules.DNN_AjaxControlToolkit.Edit" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke" Namespace="DotNetNuke.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Assembly="DotNetNuke.Web" Namespace="DotNetNuke.Web.UI.WebControls" %>
<%@ Register TagPrefix="dnn" Namespace="DotNetNuke.UI.WebControls" Assembly="DotNetNuke.WebControls" %>

<div class="container-fluid">
    <div class="dnnFormMessage dnnFormInfo">
        <asp:Label ID="lblIntro" runat="server" resourceKey="lblIntro" />
    </div>

    <div class="dnnForm dnnEditExtension dnnClear" id="dnnEditExtension">
        <fieldset>
            <div class="row">
                <div class="col-md-4">
                    <div class="dnnFormItem">
                        <dnn:Label runat="server" id="lblID" CssClass="dnnFormRequired" />
                        <asp:TextBox runat="server" ID="txtID" CssClass="dnnFormRequired" />
                        <%--<asp:CompareValidator runat="server" Operator="DataTypeCheck" Type="Integer" ControlToValidate="txtID" ErrorMessage="Time Division Code value must be a number" />--%>
<%--                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtID" CssClass="dnnFormMessage dnnFormError" ResourceKey="txtID.Required" Display="Dynamic" />--%>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dnnFormItem">
                        <dnn:Label runat="server" ID="lblLinkLabel" CssClass="dnnFormRequired" />
                        <asp:TextBox runat="server" ID="txtLinkLabel" />
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="dnnFormItem">
                        <dnn:Label runat="server" ID="lblLinkPath" CssClass="dnnFormRequired" />
                        <asp:TextBox runat="server" ID="txtLinkPath" />
                    </div>
                </div>
                <div class="col-md-12">
                    <div class="dnnFormItem">
                        <ul class="dnnActions dnnClear">
                            <li>
                                <asp:LinkButton runat="server" CssClass="dnnPrimaryAction" ID="cmdAddNewRecord" Resourcekey="cmdAddNewRecord" OnClick="cmdAddNewRecord_Click" /></li>
                        </ul>
                    </div>
                </div>
            </div>
        </fieldset>
    </div>

    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <div class="container">

            <%--    <div class="row header" style="text-align: center; color: green">
        <h3>Human Resource is the interface to access the database that has all the information of all the L.A. County Department of Beaches and Harbors employees and positions.<br />
            You can add, modify or delete employees and positions.<br />
            And you can also create and access reports with the information up to date.</h3>
    </div>--%>
            <asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="false"
                OnRowUpdating="gvMenu_RowUpdating"
                OnRowCancelingEdit="gvMenu_RowCancelingEdit"
                OnRowDeleting="gvMenu_RowDeleting"
                OnRowEditing="gvMenu_RowEditing"
                OnPreRender="gvMenu_PreRender"
                CssClass="table table-striped">
                <EmptyDataTemplate>
                    <asp:Image ID="Image0" ImageUrl="~/Images/yellow-warning.gif" AlternateText="No Image" runat="server" />No Data Found.
                </EmptyDataTemplate>
                <Columns>
                    <asp:CommandField ShowEditButton="True" />
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField DataField="ID" SortExpression="ID" HeaderText="ID" />
                    <asp:BoundField DataField="LinkLabel" SortExpression="LinkLabel" HeaderText="Link Label" />
                    <asp:BoundField DataField="LinkPath" SortExpression="LinkPath" HeaderText="Link Path" />
                </Columns>
            </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>

</div>

<script>
    $(document).ready(function () {
        $('#<%= gvMenu.ClientID %>').dataTable({
            "aLengthMenu": [[25, 50, 75, -1], [25, 50, 75, "All"]],
            "iDisplayLength": -1,
            "order": [[2, "asc"]],
            stateSave: true,
            stateSaveCallback: function (settings, data) {
                localStorage.setItem('DataTables_' + settings.sInstance, JSON.stringify(data));
            },
            stateLoadCallback: function (settings) {
                return JSON.parse(localStorage.getItem('DataTables_' + settings.sInstance));
            }
        });
    });
</script>

