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
    public partial class AutoComplete : DNN_AjaxControlToolkitModuleBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {

            }
            catch (Exception exc) //Module failed to load
            {
                Exceptions.ProcessModuleLoadException(this, exc);
            }
        }

        protected void Submit(object sender, EventArgs e)
        {
            string customerName = Request.Form[txtSearch.UniqueID];
            string customerId = Request.Form[hfCustomerId.UniqueID];
            ScriptManager.RegisterStartupScript(Page, this.GetType(), "alert", "alert('Name: " + customerName + "\\nID: " + customerId + "');", true);
        }

    }
}