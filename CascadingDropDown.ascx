<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CascadingDropDown.ascx.cs" Inherits="DotNetNuke.Modules.DNN_AjaxControlToolkit.CascadingDropDown" %>
<%@ Register TagPrefix="dnn" TagName="Label" Src="~/controls/LabelControl.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<h2>Cascading Drop Down</h2>
<div class="dnnForm dnnEditExtension dnnClear" id="dnnEditExtension">
    <fieldset>
        <div class="dnnFormItem">
            <asp:Label ID="lblCountries" runat="server">Countries</asp:Label>
            <asp:DropDownList ID="ddlCountries" runat="server" Width="150" />
            <ajaxToolkit:CascadingDropDown ID="cdlCountries" TargetControlID="ddlCountries" PromptText="Select Country"
                PromptValue="" ServicePath="~/DesktopModules/DNN_AjaxControlToolkit/WebService/CascadingDropDownWS.asmx" ServiceMethod="GetCountries" runat="server"
                Category="CountryId" LoadingText="Loading..." />
        </div>
        <div class="dnnFormItem">
            <asp:Label ID="lblStates" runat="server">States</asp:Label>
            <asp:DropDownList ID="ddlStates" runat="server" Width="150" />
            <ajaxToolkit:CascadingDropDown ID="cdlStates" TargetControlID="ddlStates" PromptText="Select State"
                PromptValue="" ServicePath="~/DesktopModules/DNN_AjaxControlToolkit/WebService/CascadingDropDownWS.asmx" ServiceMethod="GetStates" runat="server"
                Category="StateId" ParentControlID="ddlCountries" LoadingText="Loading..." />
        </div>
        <div class="dnnFormItem">
            <asp:Label ID="lblCities" runat="server">Cities</asp:Label>
            <asp:DropDownList ID="ddlCities" runat="server" Width="150" />
            <ajaxToolkit:CascadingDropDown ID="cdlCities" TargetControlID="ddlCities" PromptText="Select City"
                PromptValue="" ServicePath="~/DesktopModules/DNN_AjaxControlToolkit/WebService/CascadingDropDownWS.asmx" ServiceMethod="GetCities" runat="server"
                Category="CityId" ParentControlID="ddlStates" LoadingText="Loading..." />
        </div>
    </fieldset>
</div>
