using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

namespace phoneBook
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        public const string SelectFields = "SELECT id,lastname,firstname,middlename,address,title,company FROM person ";

        #region Глобальные переменные
        public string CommStr
        {
            get
            {
                if (Session["_commStr"] == null)
                    return null;
                return Session["_commStr"].ToString();
            }
            set
            {
                Session["_commStr"] = value;
            }
        }

        public DataTable phoneDT
        {
            get
            {
                if (Session["_phoneDT"] == null)
                    return null;
                return Session["_phoneDT"] as DataTable;
            }
            set
            {
                Session["_phoneDT"] = value;
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

        #endregion

        MySqlConnection conn;
        MySqlCommand comm;


        #region Инициализация страницы
        protected void Page_Init(object sender, EventArgs e)
        {
            if (!DesignMode && !IsPostBack)
            {
                if (user == null)
                    Response.Redirect("login.aspx");
                if (!user.admin)
                    Response.Redirect("default.aspx");
                CommStr = SelectFields + "WHERE active=1";
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
            conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            PersonSource.SelectCommand = CommStr;
            if (!IsPostBack)
                PersonView.DataBind();
        }
        #endregion

        #region Работа с контактами
        #region Добавление контакта
        protected void ShowAddPersonBtn_Click(object sender, EventArgs e)
        {
            lastNameTb.Text = string.Empty;
            firstNameTb.Text = string.Empty;
            middleNameTb.Text = string.Empty;
            addressTb.Text = string.Empty;
            AddPersonPanel.Visible = !AddPersonPanel.Visible;
        }

        protected void AddPersonBtn_Click(object sender, EventArgs e)
        {
            DateTime dt;
            string bday = null;
            if (DateTime.TryParse(birthDateTb.Text, out dt))
                bday = Convert.ToDateTime(birthDateTb.Text).ToString("yyyy-MM-dd");
            comm = new MySqlCommand("INSERT INTO person (lastname,firstname,middlename,address,role_id,title,company,birthdate) VALUES (@lastname,@firstname,@middlename,@address,@role_id,@title,@company,@birthdate)", conn);
            comm.Parameters.AddWithValue("@lastname", lastNameTb.Text);
            comm.Parameters.AddWithValue("@firstname", firstNameTb.Text);
            comm.Parameters.AddWithValue("@middlename", middleNameTb.Text);
            comm.Parameters.AddWithValue("@address", addressTb.Text);
            comm.Parameters.AddWithValue("@role_id", roleDdl.SelectedValue);
            comm.Parameters.AddWithValue("@title", titleTb.Text);
            comm.Parameters.AddWithValue("@company", companyTb.Text);
            comm.Parameters.AddWithValue("@birthdate", bday);
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
            PersonView.DataBind();

            lastNameTb.Text = string.Empty;
            firstNameTb.Text = string.Empty;
            middleNameTb.Text = string.Empty;
            addressTb.Text = string.Empty;
            titleTb.Text = string.Empty;
            companyTb.Text = string.Empty;
            AddPersonPanel.Visible = false;
        }
        #endregion

        #region Кнопки в таблице контактов
        protected void PersonView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ShowPhones")
            {
                int rowInd = Convert.ToInt32(e.CommandArgument);
                personID.Value = PersonView.DataKeys[rowInd]["id"].ToString();

                PhoneExtender.Show();
            }
            if (e.CommandName == "DeleteContact")
            {
                int rowInd = Convert.ToInt32(e.CommandArgument);
                string personID = PersonView.DataKeys[rowInd]["id"].ToString();
                comm = new MySqlCommand("UPDATE person SET active=0 WHERE id=@id", conn);
                comm.Parameters.AddWithValue("@id", personID);
                conn.Open();
                comm.ExecuteNonQuery();
                conn.Close();
                PersonView.DataBind();
            }
            if (e.CommandName == "ShowEmails")
            {
                int rowInd = Convert.ToInt32(e.CommandArgument);
                personID.Value = PersonView.DataKeys[rowInd]["id"].ToString();

                EmailExtender.Show();
            }
        }
        #endregion

        #region Поиск контакта
        [System.Web.Script.Services.ScriptMethod()]
        [System.Web.Services.WebMethod]
        public static List<string> SearchContact(string prefixText, int count)
        {
            MySqlConnection conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            MySqlCommand comm = new MySqlCommand("SELECT p.lastname,p.firstname FROM person p LEFT JOIN phones ph ON ph.person_id=p.id LEFT JOIN emails e ON e.person_id=p.id WHERE lastname LIKE '" + prefixText + "%' OR firstname LIKE '" + prefixText + "%' OR middlename LIKE '" + prefixText + "%' OR address LIKE '" + prefixText + "%' OR ph.phone LIKE '" + prefixText + "%' OR e.email LIKE '" + prefixText + "%'", conn);
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
                CommStr = SelectFields + "WHERE lastname LIKE '" + findTb.Text.Split(' ')[0] + "%' AND firstname LIKE '" + findTb.Text.Split(' ')[1] + "%' AND active=1";
                PersonSource.SelectCommand = CommStr;
                PersonView.DataBind();
            }
        }

        protected void clearBtn_Click(object sender, EventArgs e)
        {
            CommStr = SelectFields + "WHERE active=1";
            PersonSource.SelectCommand = CommStr;
            PersonView.DataBind();
            findTb.Text = string.Empty;
        }
        #endregion
        #endregion

        #region Работа с телефонами
        #region Добавление телефона
        protected void showAddPhoneBtn_Click(object sender, EventArgs e)
        {
            AddNewPhonePanel.Visible = !AddNewPhonePanel.Visible;
            PhoneExtender.Show();
        }

        protected void addPhoneBtn_Click(object sender, EventArgs e)
        {
            comm = new MySqlCommand("INSERT INTO phones (phone_type,phone,person_id) VALUES (@pt,@p,@pid)", conn);
            comm.Parameters.AddWithValue("@pt", phoneTypeTb.Text);
            comm.Parameters.AddWithValue("@p", phoneNumberTb.Text);
            comm.Parameters.AddWithValue("@pid", personID.Value);
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
            phoneNumberTb.Text = string.Empty;
            phoneTypeTb.Text = string.Empty;
            AddNewPhonePanel.Visible = false;
            PhoneView.DataBind();
            PhoneExtender.Show();
        }
        #endregion

        #region Кнопки в таблице телефонов
        protected void PhoneView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeletePhone")
            {
                int rowInd = Convert.ToInt32(e.CommandArgument);
                string phoneID = PhoneView.DataKeys[rowInd]["id"].ToString();
                comm = new MySqlCommand("UPDATE phones SET active=0 WHERE id=@id", conn);
                comm.Parameters.AddWithValue("@id", phoneID);
                conn.Open();
                comm.ExecuteNonQuery();
                conn.Close();
                PhoneView.DataBind();
                PhoneExtender.Show();
            }
        }
        #endregion
        #endregion

        #region Работа с емейлами
        #region Добавление емейла
        protected void newEmailBtn_Click(object sender, EventArgs e)
        {
            AddNewEMailPanel.Visible = !AddNewEMailPanel.Visible;
            EmailExtender.Show();
        }

        protected void addEmailBtn_Click(object sender, EventArgs e)
        {
            comm = new MySqlCommand("INSERT INTO emails (email_type,email,person_id) VALUES (@et,@e,@pid)", conn);
            comm.Parameters.AddWithValue("@et", emailTypeTb.Text);
            comm.Parameters.AddWithValue("@e", emailTb.Text);
            comm.Parameters.AddWithValue("@pid", personID.Value);
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
            emailTypeTb.Text = string.Empty;
            emailTb.Text = string.Empty;
            AddNewEMailPanel.Visible = false;
            EmailView.DataBind();
            EmailExtender.Show();
        }
        #endregion

        #region Кнопки в таблице емейлов
        protected void EmailView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteEmail")
            {
                int rowInd = Convert.ToInt32(e.CommandArgument);
                string emailID = PhoneView.DataKeys[rowInd]["id"].ToString();
                comm = new MySqlCommand("UPDATE emails SET active=0 WHERE id=@id", conn);
                comm.Parameters.AddWithValue("@id", emailID);
                conn.Open();
                comm.ExecuteNonQuery();
                conn.Close();
                EmailView.DataBind();
                EmailExtender.Show();
            }
        }
        #endregion 
        #endregion
    }
}