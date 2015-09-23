using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace phoneBook
{
    public partial class _default : System.Web.UI.Page
    {

        public const string SelectFields = @"SELECT p.lastname,p.firstname,p.middlename,p.title,p.company,p.address,p.birthdate,p.mate,p.discription, GROUP_CONCAT(ph.phone_type,': ',ph.phone SEPARATOR '<br/>') phones,GROUP_CONCAT(e.email_type,': ',e.email SEPARATOR '<br/>') emails 
FROM person p
LEFT JOIN phones ph ON ph.person_id = p.id AND ph.active=1
LEFT JOIN emails e ON e.person_id = p.id AND e.active= 1";

        public string CommStr
        {
            get
            {
                if (Session["_commMainStr"] == null)
                    return null;
                return Session["_commMainStr"].ToString();
            }
            set
            {
                Session["_commMainStr"] = value;
            }
        }
        public CUser user
        {
            get
            {
                if (Session["_usr"] == null)
                    return null;
                return Session["_usr"] as CUser;
            }
        }


        protected void Page_Init(object sender, EventArgs e)
        {
            if (!DesignMode && !IsPostBack)
            {
                if (user == null)
                    Response.Redirect("login.aspx");
                if (user.admin || user.viewAll)
                {
                    CommStr = SelectFields + @" WHERE p.active=1 GROUP BY p.id";
                }
                else
                {
                    CommStr = SelectFields + @" WHERE p.active=1 AND p.role_id=" + user.roleID + @" GROUP BY p.id";
                }
            }


        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ContactSource.SelectCommand = CommStr;
            if (!IsPostBack)
                ContactGrid.DataBind();
        }

        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchContact(string prefixText, int count)
        {
            MySqlConnection conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            MySqlCommand comm;
            CUser user = HttpContext.Current.Session["_usr"] as CUser;
            if (user.admin || user.viewAll)
                comm = new MySqlCommand("SELECT p.lastname,p.firstname FROM person p LEFT JOIN phones ph ON ph.person_id=p.id LEFT JOIN emails e ON e.person_id=p.id WHERE (p.title LIKE '" + prefixText + "%' OR p.company LIKE '" + prefixText + "%' OR p.lastname LIKE '" + prefixText + "%' OR p.firstname LIKE '" + prefixText + "%' OR p.middlename LIKE '" + prefixText + "%' OR p.address LIKE '" + prefixText + "%' OR ph.phone LIKE '" + prefixText + "%' OR e.email LIKE '" + prefixText + "%' OR p.mate LIKE '" + prefixText + "%' OR p.discription LIKE '" + prefixText + "%') AND p.active=1 AND (ph.active=1 OR ph.active IS NULL) AND (e.active=1 OR e.active IS NULL) GROUP BY p.id", conn);
            else
                comm = new MySqlCommand("SELECT p.lastname,p.firstname FROM person p LEFT JOIN phones ph ON ph.person_id=p.id LEFT JOIN emails e ON e.person_id=p.id WHERE (p.title LIKE '" + prefixText + "%' OR p.company LIKE '" + prefixText + "%' OR p.lastname LIKE '" + prefixText + "%' OR p.firstname LIKE '" + prefixText + "%' OR p.middlename LIKE '" + prefixText + "%' OR p.address LIKE '" + prefixText + "%' OR ph.phone LIKE '" + prefixText + "%' OR e.email LIKE '" + prefixText + "%' OR p.mate LIKE '" + prefixText + "%' OR p.discription LIKE '" + prefixText + "%') AND p.active=1 AND (ph.active=1 OR ph.active IS NULL) AND (e.active=1 OR e.active IS NULL) AND p.role_id=" + user.roleID+ " GROUP BY p.id", conn);
            List<string> result = new List<string>();
            conn.Open();
            MySqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
            {
                result.Add(string.Format("{0} {1}", reader.GetString(0), reader.GetString("firstname")));
            }
            reader.Close();
            conn.Close();
            return result;
        }

        protected void findBtn_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(findTb.Text))
            {
                if (findTb.Text.Split(' ').Length > 1)
                {
                    if (user.admin || user.viewAll)
                    {
                        CommStr = SelectFields + @" WHERE p.lastname LIKE '" + findTb.Text.Split(' ')[0] + "%' AND p.firstname LIKE '" + findTb.Text.Split(' ')[1] + "%' AND p.active=1 GROUP BY p.id";
                    }
                    else
                    {
                        CommStr = SelectFields + @" WHERE p.lastname LIKE '" + findTb.Text.Split(' ')[0] + "%' AND p.firstname LIKE '" + findTb.Text.Split(' ')[1] + "%' AND p.active=1 AND p.role_id=" + user.roleID + " GROUP BY p.id";
                    }
                    ContactSource.SelectCommand = CommStr;
                    ContactGrid.DataBind();
                }
            }
        }

        protected void clearBtn_Click(object sender, EventArgs e)
        {
            if (user.admin || user.viewAll)
            {
                CommStr = SelectFields + @" WHERE p.active=1 GROUP BY p.id";
            }
            else
            {
                CommStr = SelectFields + @" WHERE p.active=1 AND p.role_id=" + user.roleID + " GROUP BY p.id";
            }
            ContactSource.SelectCommand = CommStr;
            ContactGrid.DataBind();
            findTb.Text = string.Empty;
        }
    }
}