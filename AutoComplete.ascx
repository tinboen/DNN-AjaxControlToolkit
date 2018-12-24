<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AutoComplete.ascx.cs" Inherits="DotNetNuke.Modules.DNN_AjaxControlToolkit.AutoComplete" %>

<h2>Auto Complete in DNN using aspx</h2>
<script type="text/javascript">
    function ShowCurrentTime() {
        $.ajax({
            type: "POST",
            url: '<%=ResolveUrl("~/DesktopModules/DNN_AjaxControlToolkit/WebService/AutoCompleteWS.aspx/GetCurrentTime") %>',
            data: '{name: "' + $("#<%=txtUserName.ClientID%>")[0].value + '" }',
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: OnSuccess,
        failure: function (response) {
            alert(response.d);
        }
    });
}
function OnSuccess(response) {
    alert(response.d);
}
</script>

<script type="text/javascript">
    $(function () {
        $("[id$=txtSearch]").autocomplete({
            source: function (request, response) {
                $.ajax({
                    url: '<%=ResolveUrl("~/DesktopModules/DNN_AjaxControlToolkit/WebService/AutoCompleteWS.aspx/GetCustomers") %>',
                        data: "{ 'prefix': '" + request.term + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            response($.map(data.d, function (item) {
                                return {
                                    label: item.split('-')[0],
                                    val: item.split('-')[1]
                                }
                            }))
                        },
                        error: function (response) {
                            alert(response.responseText);
                        },
                        failure: function (response) {
                            alert(response.responseText);
                        }
                    });
                },
                select: function (e, i) {
                    $("[id$=hfCustomerId]").val(i.item.val);
                },
                minLength: 1
            });
        });
</script>

<div>
    Your Name : 
    <asp:TextBox ID="txtUserName" runat="server"></asp:TextBox>
    <input id="btnGetTime" type="button" value="Show Current Time"
        onclick="ShowCurrentTime()" />
</div>
<div>
    Enter Customer Name:
    <asp:TextBox ID="txtSearch" runat="server" />
    <asp:HiddenField ID="hfCustomerId" runat="server" />
    <asp:Button ID="Button1" Text="Submit" runat="server" OnClick="Submit" />
</div>

<div>
    <span id="ResultId"></span>
</div>
