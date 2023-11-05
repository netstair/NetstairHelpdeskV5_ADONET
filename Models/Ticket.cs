using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace NetstairHelpdeskV5.Models
{
    public class Ticket
    {
        public int ID { get; set; }
      
        public DateTime DateCreated { get; set; }
        [Required]
        public string Businees_Name { get; set; }
        [Required]
        public string Telephone { get; set; }
       
        public string Location { get; set; }
        [Required]
        public string Contact_Person { get; set; }
        [Required]
        public string Personal_Email { get; set; }
        [Required]
        public string Priority { get; set; }
        [Required]
        public string Category { get; set; }
      
        public string Assigned_To { get; set; }
        public string Number { get; set; }
        public string Status { get; set; }

    }
}
