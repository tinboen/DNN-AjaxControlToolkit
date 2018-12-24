<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="CallingWebMethod.ascx.cs" Inherits="DotNetNuke.Modules.DNN_AjaxControlToolkit.CallingWebMethod" %>

<div>
    <h2>Calling Web Methods</h2>
    <table>
        <tr align="left">
            <td>Method that does not return a value:</td>
            <td>
                <!-- Getting no retun value from 
                            the Web service. -->
                <button id="Button1" onclick="GetNoReturn()">
                    No Return</button>
            </td>
        </tr>
        <tr align="left">
            <td>Method that returns a value:</td>
            <td>
                <!-- Getting a retun value from 
                            the Web service. -->
                <button id="Button2" onclick="GetTime(); return false;">
                    Server Time</button>
            </td>
        </tr>
        <tr align="left">
            <td>Method that takes parameters:</td>
            <td>
                <!-- Passing simple parameter types to 
                            the Web service. -->
                <button id="Button3" onclick="Add(20, 30); return false;">
                    Add</button>
            </td>
        </tr>
        <tr align="left">
            <td>Method that returns XML data:</td>
            <td>
                <!-- Get Xml. -->
                <button id="Button4" onclick="GetXmlDocument(); return false;">
                    Get Xml</button>
            </td>
        </tr>
        <tr align="left">
            <td>Method that uses GET:</td>
            <td>
                <!-- Making a GET Web request. -->
                <button id="Button5" onclick="MakeGetRequest(); return false;">
                    Make GET Request</button>
            </td>
        </tr>

    </table>
</div>

<hr />

<div>
    <span id="ResultId"></span>
</div>
