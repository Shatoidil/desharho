using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Security.Cryptography;
using System.Text;

namespace phoneBook
{
    public partial class WebForm2 : System.Web.UI.Page
    {

        public CUser user
        {
            get
            {
                if (Session["_usr"] == null)
                    return null;
                return Session["_usr"] as CUser;
            }
        }

        MySqlConnection conn;
        MySqlCommand comm;

        protected void Page_Init(object sender, EventArgs e)
        {
            if (!DesignMode && !IsPostBack)
            {
                if (user == null)
                    Response.Redirect("login.aspx");
                if (!user.admin)
                    Response.Redirect("default.aspx");
                roleDdl.Items.Clear();
                conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
                comm = new MySqlCommand("SELECT name,id FROM roles ORDER BY name", conn);
                conn.Open();
                MySqlDataReader reader = comm.ExecuteReader();
                while (reader.Read())
                    roleDdl.Items.Add(new ListItem(reader.GetString(0), reader.GetString(1)));
                reader.Close();
                conn.Close();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }



        protected void Submit1_ServerClick(object sender, EventArgs e)
        {
         /*   conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            comm = new MySqlCommand("INSERT IGNORE INTO users (uname,passmd5,admin,view_all,role_id) VALUES (@uname,@passmd5,@admin,@view_all,@role_id)", conn);
            comm.Parameters.AddWithValue("@uname", unameTb.Text);
            comm.Parameters.AddWithValue("@passmd5", Common.ByteArrayToString(new MD5CryptoServiceProvider().ComputeHash(Encoding.Default.GetBytes(passTb.Text))));
            comm.Parameters.AddWithValue("@admin", adminCb.Checked ? "1" : "0");
            comm.Parameters.AddWithValue("@view_all", viewAllCb.Checked ? "1" : "0");
            comm.Parameters.AddWithValue("@role_id", roleDdl.SelectedValue);
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();*/
        }


        protected void ShowAddPersonBtn_Click(object sender, EventArgs e)
        {
            addPersonPanel.Visible = !addPersonPanel.Visible;
        }

        protected void addUserBtn_Click(object sender, EventArgs e)
        {
            conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            comm = new MySqlCommand("INSERT IGNORE INTO users (uname,passmd5,admin,view_all,role_id) VALUES (@uname,@passmd5,@admin,@view_all,@role_id)", conn);
            comm.Parameters.AddWithValue("@uname", loginTb.Text);
            comm.Parameters.AddWithValue("@passmd5", Common.ByteArrayToString(new MD5CryptoServiceProvider().ComputeHash(Encoding.Default.GetBytes(passmd5Tb.Text))));
            comm.Parameters.AddWithValue("@admin", adminCb.Checked ? "1" : "0");
            comm.Parameters.AddWithValue("@view_all", viewAllCb.Checked ? "1" : "0");
            comm.Parameters.AddWithValue("@role_id", roleDdl.SelectedValue);
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
            loginTb.Text = string.Empty;
            passmd5Tb.Text = string.Empty;
            adminCb.Checked = false;
            viewAllCb.Checked = false;
            addPersonPanel.Visible = false;
            UserView.DataBind();
        }
    }
}