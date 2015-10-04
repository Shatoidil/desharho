using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FenixPortal
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindTable();
                
            }


        }

        protected void BindTable()
        {
            using (fenixcontactsEntities db = new fenixcontactsEntities())
            {

                var result = from p in db.persons
                             join ph in db.phones on p.id equals ph.person_id into ljoin1
                             from phones in ljoin1.DefaultIfEmpty()
                             join e in db.emails on p.id equals e.person_id into ljoin2
                             from emails in ljoin2.DefaultIfEmpty()
                             select new
                             {
                                 id = p.id,
                                 img = p.img,
                                 firstname = p.firstname,
                                 lastname = p.lastname,
                                 middlename = p.middlename,
                                 position = p.position,
                                 company = p.company,
                                 phone = phones.phone1,
                                 emails = emails.email1

                             };

                ReapeterContacts.DataSource = result.ToList();
                ReapeterContacts.DataBind();
            }
        }

        protected void ShowContact_Command(object sender, CommandEventArgs e)
        {

            int rowInd = Convert.ToInt32(e.CommandArgument);
            using (fenixcontactsEntities db = new fenixcontactsEntities())
            {

                var showPerson = db.persons.First(p => p.id  == rowInd);
                var showPhone = String.Empty;
                if ((db.phones.FirstOrDefault(ph => ph.person_id == rowInd) == null)) { showPhone = ""; } else { showPhone = db.phones.FirstOrDefault(ph => ph.person_id == rowInd).phone1; }
                var showEmail = String.Empty;
                if ((db.emails.FirstOrDefault(em => em.person_id == rowInd) == null)) { showEmail = ""; } else { showEmail = db.emails.FirstOrDefault(em => em.person_id == rowInd).email1; }


                ContactImgPics.ImageUrl = showPerson.img;
                FioLB.Text = string.Format("{0} {1} {2}", showPerson.lastname, showPerson.firstname, showPerson.middlename);
                ModalLBCompany.Text = showPerson.company;
                ModalLBPosition.Text = showPerson.position;

                ModalLBDepartament.Text = showPerson.departments;
                ModalLBTelephone.Text = showPhone;
                ModalLBEmail.Text = showEmail;
                ModalLBAddress.Text = showPerson.address;
                ModalLBirthday.Text = String.Format("{0:m}", showPerson.birthdate); 
                ScriptManager.RegisterStartupScript(this, GetType(), "Pop", "openModal();", true);
                
            }
           
            
        }
    }
}