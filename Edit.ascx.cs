/*
' Copyright (c) 2017 Department of Beaches and Harbors
' All rights reserved.
' 
' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
' TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
' THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
' CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
' DEALINGS IN THE SOFTWARE.
' 
*/

using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Text;

using DotNetNuke;
using DotNetNuke.Common.Utilities;
using DotNetNuke.Entities.Modules;
using DotNetNuke.Entities.Modules.Actions;
using DotNetNuke.Security;
using DotNetNuke.Services.Exceptions;
using DotNetNuke.Services.Localization;
using DotNetNuke.Common;
using System.Xml;
using System.Web;
using System.Net.Mail;
using DotNetNuke.Entities.Users;
using System.ComponentModel;
using System.Linq;
using System.Web.UI.HtmlControls;
using DotNetNuke.Modules.DNN_AjaxControlToolkit.Components;
using DotNetNuke.UI.Skins;
using DotNetNuke.UI.Skins.Controls;

namespace DotNetNuke.Modules.DNN_AjaxControlToolkit
{
    /// -----------------------------------------------------------------------------
    /// <summary>   
    /// The Edit class is used to manage content
    /// 
    /// Typically your edit control would be used to create new content, or edit existing content within your module.
    /// The ControlKey for this control is "Edit", and is defined in the manifest (.dnn) file.
    /// 
    /// Because the control inherits from PortalModuleBase you have access to any custom properties
    /// defined there, as well as properties from DNN such as PortalId, ModuleId, TabId, UserId and many more.
    /// 
    /// </summary>
    /// -----------------------------------------------------------------------------
    public partial class Edit : PortalModuleBase
    {
        #region Private Members

        private string strXMLfile = Null.NullString;

        #endregion

        #region BoundFields with Paging and Sorting

        protected void gvMenu_PreRender(object sender, EventArgs e)
        {
            GridView gv = (GridView)sender;

            if ((gv.ShowHeader == true && gv.Rows.Count > 0) || (gv.ShowHeaderWhenEmpty == true))
            {
                //Force GridView to use <thead> instead of <tbody> - 11/03/2013 - MCR.
                gv.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
            if (gv.ShowFooter == true && gv.Rows.Count > 0)
            {
                //Force GridView to use <tfoot> instead of <tbody> - 11/03/2013 - MCR.
                gv.FooterRow.TableSection = TableRowSection.TableFooter;
            }
        }

        #endregion

        #region Gidview Procedures

        protected void BindGrid()
        {
            DataSet ds = new DataSet();
            ds.ReadXml(strXMLfile);
            gvMenu.DataSource = ds;
            gvMenu.DataBind();
        }

        protected void gvMenu_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            int i = gvMenu.Rows[e.RowIndex].DataItemIndex;
            GridViewRow row = gvMenu.Rows[e.RowIndex];
            string strID = ((TextBox)(row.Cells[2].Controls[0])).Text;
            string strLinkLabel = ((TextBox)(row.Cells[3].Controls[0])).Text;
            string strLinkPath = ((TextBox)(row.Cells[4].Controls[0])).Text;

            //Reset the edit index.
            gvMenu.EditIndex = -1;

            //Bind data to the GridView control.
            BindGrid();

            DataSet oDs = (DataSet)gvMenu.DataSource;

            oDs.Tables[0].Rows[i]["ID"] = strID;
            oDs.Tables[0].Rows[i]["LinkLabel"] = strLinkLabel;
            oDs.Tables[0].Rows[i]["LinkPath"] = strLinkPath;
            oDs.WriteXml(strXMLfile);

            //Bind data to the GridView control.
            BindGrid();

        }

        protected void gvMenu_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            gvMenu.EditIndex = -1;

            //Bind data to the GridView control.
            BindGrid();
        }

        protected void gvMenu_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            //Bind data to the GridView control.
            BindGrid();

            DataSet oDs = (DataSet) gvMenu.DataSource;
            oDs.Tables[0].Rows[gvMenu.Rows[e.RowIndex].DataItemIndex].Delete();
            oDs.WriteXml(strXMLfile);

            //Bind data to the GridView control.
            BindGrid();
        }

        protected void gvMenu_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            gvMenu.EditIndex = e.NewEditIndex;

            //Bind data to the GridView control.
            BindGrid();
        }

        #endregion

        #region "Optional Command Interfaces"

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// cmdAddNewRecord_Click redirect to add new record dialog when the add new record button is clicked
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// </history>
        /// -----------------------------------------------------------------------------
        protected void cmdAddNewRecord_Click(System.Object sender, System.EventArgs e)
        {
            try
            {
                if (!string.IsNullOrEmpty(txtID.Text))
                {
                    BindGrid();
                    DataSet oDs = (DataSet)gvMenu.DataSource;
                    DataRow oDr = oDs.Tables[0].NewRow();
                    oDr["ID"] = txtID.Text;
                    oDr["LinkLabel"] = txtLinkLabel.Text;
                    oDr["LinkPath"] = txtLinkPath.Text;
                    oDs.Tables[0].Rows.Add(oDr);
                    oDs.WriteXml(strXMLfile);
                    BindGrid();
                }
                else
                {
                    Skin.AddModuleMessage(this, Localization.GetString("txtID.ErrorMessage", LocalResourceFile), ModuleMessage.ModuleMessageType.YellowWarning);
                }

                // return to main page
                //Response.Redirect(Globals.NavigateURL(AddNewRecord, "COLUMN_NAME=" + ddlCOLUMN_NAME.SelectedValue, "mid=" + ModuleId.ToString()));
            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        #endregion

        #region "Events"

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// OnInit runs when this program start is clicked
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// </history>
        /// -----------------------------------------------------------------------------
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            try
            {
                //JavaScript.RequestRegistration(CommonJs.jQuery);

                //ClientResourceManager.RegisterScript(Page, "~/desktopmodules/DotNetNuke.Modules.DNN_AjaxControlToolkit/scripts/jquery.Manager.js");

                //DetailView.ItemDataBound += RepeaterItemDataBound;

                ////Save User Preferences
                //SavePersonalizedSettings();
            }
            catch (Exception exc)
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        /// -----------------------------------------------------------------------------
        /// <summary>
        /// OnLoad runs when this program start is clicked
        /// </summary>
        /// <remarks>
        /// </remarks>
        /// <history>
        /// </history>
        /// -----------------------------------------------------------------------------
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            ModuleController modCtrl = new ModuleController();
            strXMLfile = @HttpContext.Current.Server.MapPath("~/DesktopModules/") + modCtrl.GetModule(ModuleId).DesktopModule.FolderName + "\\Menu.xml";

            try
            {
                if (!IsPostBack)
                {
                    BindGrid();
                }
            }
            catch (Exception exc)
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        #endregion

    }
}
