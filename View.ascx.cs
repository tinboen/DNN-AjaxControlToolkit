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
' http://www.adefwebserver.com/DotNetNukeHELP/Misc/DNNTreeView/DNNTreeView.htm
' http://old.denisbauer.com/
' https://www.codeproject.com/articles/18280/%2fArticles%2f18280%2fEdit-XML-files-using-a-GridView
'
*/

using System;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Services.Localization;
using System.Xml;
using System.Data;
using System.Web;

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
    /// Because the control inherits from DNN_AjaxControlToolkitModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class View : DNN_AjaxControlToolkitModuleBase, IActionable
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                DotNetNuke.Entities.Modules.ModuleController modCtrl = new ModuleController();
                string menuPath = @HttpContext.Current.Server.MapPath("~/DesktopModules/") + modCtrl.GetModule(ModuleId).DesktopModule.FolderName + "\\Menu.xml";
                //Create xml reader
                XmlReader xmlFile = XmlReader.Create(menuPath, new XmlReaderSettings());
                DataSet dataSet = new DataSet();
                //Read xml to dataset
                dataSet.ReadXml(xmlFile);
                //Pass menu table to datagridview datasource
                gvMenu.DataSource = dataSet.Tables["menu"];
                gvMenu.DataBind();
                //Close xml reader
                xmlFile.Close();
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        #region DynamicallyLoadControl
        private void DynamicallyLoadControl(DotNetNuke.Entities.Modules.PortalModuleBase objModule)
        {
            if ((objModule != null))
            {
                objModule.ID = "DynamicPage";
                objModule.ModuleConfiguration = this.ModuleConfiguration;
                DCP.Controls.Clear();
                DCP.Controls.Add(objModule);
            }
        }
        #endregion

        #region IActionable Members
        DotNetNuke.Entities.Modules.Actions.ModuleActionCollection IActionable.ModuleActions
        {
            get
            {
                DotNetNuke.Entities.Modules.Actions.ModuleActionCollection Actions = new DotNetNuke.Entities.Modules.Actions.ModuleActionCollection();
                Actions.Add(GetNextActionID(), "Edit Menu Items", DotNetNuke.Entities.Modules.Actions.ModuleActionType.AddContent, "", "", EditUrl(), false, SecurityAccessLevel.Edit, true, false);
                return Actions;
            }
        }
        #endregion

        #region gvMenu_RowCommand
        protected void gvMenu_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            DotNetNuke.Entities.Modules.PortalModuleBase objModule = (DotNetNuke.Entities.Modules.PortalModuleBase)this.LoadControl(String.Format("~/DesktopModules/{0}", e.CommandArgument.ToString()));
            DynamicallyLoadControl(objModule);
        }
        #endregion
    }
}