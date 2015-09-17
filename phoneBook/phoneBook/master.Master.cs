using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace phoneBook
{
    public partial class master : System.Web.UI.MasterPage
    {
        public CUser user
        {
            get
            {
                if (Session["_usr"] == null)
                    return null;
                return Session["_usr"] as CUser;
            }
            set
            {
                Session["_usr"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (user == null)
                Response.Redirect("login.aspx");
            if (!user.admin)
            {
                AddPersonLi.Visible = false;
                AdminLi.Visible = false;
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            user = null;
            Response.Redirect("login.aspx");
        }
    }
}