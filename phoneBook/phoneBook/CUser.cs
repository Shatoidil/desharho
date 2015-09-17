using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace phoneBook
{
    public class CUser
    {
        public string uname { get; set; }
        public bool admin { get; set;}
        public int roleID { get; set; }
        public bool viewAll { get; set; }
    }
}