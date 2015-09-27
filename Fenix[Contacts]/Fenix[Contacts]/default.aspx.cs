using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Fenix_Contacts_
{
    public partial class _default : System.Web.UI.Page
    {

        MySqlConnection conn;
        MySqlCommand comm;
        protected void Page_Load(object sender, EventArgs e)
        {
            conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            if (!IsPostBack)
                ContactSource.DataBind();

        }

        protected void ShowContact_Command(object sender, CommandEventArgs e)
        {
            int rowInd = Convert.ToInt32(e.CommandArgument);
            conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
           
            comm = new MySqlCommand("SELECT * FROM  persons p LEFT JOIN phones ph ON p.id = ph.person_id LEFT JOIN emails e ON p.id = e.person_id WHERE p.id = @id LIMIT 1", conn);
            comm.Parameters.AddWithValue("@id", rowInd);
            conn.Open();
            
            MySqlDataReader reader = comm.ExecuteReader();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
            while (reader.Read())
            {
                for (short i = 0; i < reader.FieldCount; i++)
                {
                    if (reader.IsDBNull(i) == false)
                    {
                       
                    }
                        
                    else
                    {
                        
                    }
                }

                FIO.Text = string.Format("{0} {1} {2}", reader.GetString("lastname"), reader.GetString("firstname"), reader.GetString("middlename"));
                COMPANY.Text = string.Format("{0}", reader.GetString("company"));
                POSITION.Text = string.Format("{0}", reader.GetString("position"));
                BIRTHDAY.Text = reader.GetDateTime("birthdate").ToString("MM/dd/yyyy"); ;
                TELEPHONES.Text = string.Format("{0}", reader.GetString("phone"));

            }
            reader.Close();
            conn.Close();
            
            
            
        }
    }
    }
