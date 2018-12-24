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
using DotNetNuke.Entities.Modules.Actions;

namespace DotNetNuke.Modules.DNN_AjaxControlToolkit
{
    /// -----------------------------------------------------------------------------
    /// <summary>
    /// The View class displays the content
    /// 
    /// Typically your view control would be used to display content or functionality in your module.
    /// 
    /// View may be the only control you have in your project depending on the complexity of your module
    /// 
    /// Because the control inherits from DNN_AjaxModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class CallingWebMethod : DNN_AjaxControlToolkitModuleBase
    {
        private void Page_Load(object sender, System.EventArgs e)
        {
            // Determine if AJAX is installed
            if (DotNetNuke.Framework.AJAX.IsInstalled())
            {
                DotNetNuke.Framework.AJAX.RegisterScriptManager();
                // Create a reference to the Script Manager
                ScriptManager objScriptManager = ScriptManager.GetCurrent(this.Page);
                // Add a reference to the web service
                ServiceReference objServiceReference = new ServiceReference();
                objServiceReference.Path = @"~/DesktopModules/DNN_AjaxControlToolkit/WebService/CallWebServiceMethodWS.asmx";
                objScriptManager.Services.Add(objServiceReference);

                ScriptReference objScriptReference = new ScriptReference();
                objScriptReference.Path = @"~/DesktopModules/DNN_AjaxControlToolkit/WebService/CallWebServiceMethodWS.js";
                objScriptManager.Scripts.Add(objScriptReference);
            }

        }
    }
}

