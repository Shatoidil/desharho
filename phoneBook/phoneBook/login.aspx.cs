using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Web.Security;
using System.Security.Cryptography;
using System.Text;

namespace phoneBook
{
    public partial class login : System.Web.UI.Page
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
        }

        protected void Submit1_ServerClick(object sender, EventArgs e)
        {
            string hash = Common.ByteArrayToString(new MD5CryptoServiceProvider().ComputeHash(Encoding.Default.GetBytes(TextBox2.Text)));
            MySqlConnection conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            MySqlCommand comm = new MySqlCommand("SELECT passmd5 FROM users WHERE uname=@uname AND active=1", conn);
            comm.Parameters.AddWithValue("@uname", TextBox1.Text);
            conn.Open();
            string result = null;
            MySqlDataReader reader = comm.ExecuteReader();
            while (reader.Read())
                result = reader.GetString(0);
            reader.Close();
            conn.Close();
            if (hash == result)
            {
                user = new CUser();
                user.uname = TextBox1.Text;
                conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
                comm = new MySqlCommand("SELECT admin,role_id,view_all FROM users WHERE uname=@uname",conn);
                comm.Parameters.AddWithValue("@uname", user.uname);
                conn.Open();
                reader = comm.ExecuteReader();
                while(reader.Read())
                {
                    user.admin = reader.GetBoolean(0);
                    user.roleID = reader.GetInt32(1);
                    user.viewAll = reader.GetBoolean(2);
                }
                reader.Close();
                conn.Close();
                FormsAuthentication.SetAuthCookie(Convert.ToString(TextBox1.Text), false);
                Response.Redirect(FormsAuthentication.GetRedirectUrl(TextBox1.Text, false));
            }
            else
            {
                Label1.Text = "Неправильное имя пользователя или пароль!";
            }
        }
    }
}