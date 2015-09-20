using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.Data;

namespace FenixPrinters
{
    public partial class _default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        MySqlConnection conn;
        MySqlCommand comm;

       

        protected void DeletePrinter_Click(object sender, CommandEventArgs e)
        {
            int rowInd = Convert.ToInt32(e.CommandArgument);
            conn = new MySqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["MySQLString"].ConnectionString);
            comm = new MySqlCommand("DELETE FROM printers WHERE id=@id", conn);
            comm.Parameters.AddWithValue("@id", rowInd);
            conn.Open();
            comm.ExecuteNonQuery();
            conn.Close();
            PrinterSource.DataBind();

        }

       
    }
}