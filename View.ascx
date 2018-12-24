<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="View.ascx.cs" Inherits="DotNetNuke.Modules.DNN_AjaxControlToolkit.View" %>
<%@ Register TagPrefix="dbwc" Namespace="DBauer.Web.UI.WebControls" Assembly="DBauer.Web.UI.WebControls.DynamicControlsPlaceholder" %>

<div class="container-fluid">
    <div class="col-md-3">
        <asp:GridView ID="gvMenu" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
            Caption="Menu" CaptionAlign="Left" CellPadding="2"
            GridLines="None" OnRowCommand="gvMenu_RowCommand" ShowHeader="False">
            <Columns>
                <asp:TemplateField>
                    <ItemTemplate>
                        *
                            <asp:LinkButton ID="LinkButton1" runat="server"
                                CommandArgument='<%# Eval("LinkPath") %>' Font-Underline="True"
                                Text='<%# Eval("LinkLabel") %>'></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    <div class="col-md-9">
            <dbwc:DynamicControlsPlaceholder ID="DCP" runat="server" ControlsWithoutIDs="Persist">
                <p>this is a test</p>
            </dbwc:DynamicControlsPlaceholder>
    </div>
</div>

