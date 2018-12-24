/*
' Copyright (c) 2018  Don Hoang
'  All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using DotNetNuke;
using DotNetNuke.Security.Roles;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using System;
using DotNetNuke.Services.Localization;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using System.Web;
using DotNetNuke.Entities.Modules;

namespace DotNetNuke.Modules.DNN_AjaxControlToolkit
{
    public partial class CascadingDropDown : DNN_AjaxControlToolkitModuleBase
    {
        private void Page_Load(object sender, System.EventArgs e)
        {
            //// Determine if AJAX is installed
            //if (DotNetNuke.Framework.AJAX.IsInstalled())
            //{
            //    DotNetNuke.Framework.AJAX.RegisterScriptManager();
            //    // Create a reference to the Script Manager
            //    ScriptManager objScriptManager = ScriptManager.GetCurrent(this.Page);
            //    // Add a reference to the web service
            //    ServiceReference objServiceReference = new ServiceReference();
            //    objServiceReference.Path = @"~/DesktopModules/DNN_AjaxControlToolkit/WebService/CarsService.asmx";
            //    objScriptManager.Services.Add(objServiceReference);

            //    ScriptReference objScriptReference = new ScriptReference();
            //    objScriptReference.Path = @"~/DesktopModules/DNN_AjaxControlToolkit/WebService/CallWebServiceMethods.js";
            //    objScriptManager.Scripts.Add(objScriptReference);
            //}

        }

    }
}

