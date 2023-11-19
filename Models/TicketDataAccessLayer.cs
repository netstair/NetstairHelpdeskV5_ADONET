using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace NetstairHelpdeskV5.Models
{
    public class TicketDataAccessLayer
    {   
        //To View all tickets details    
        public IEnumerable<Ticket> GetAllTickets()
        {
            List<Ticket> lstticket = new List<Ticket>();
            
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {

                string sqlQuery = "spGetTicketData";
                SqlCommand cmd = new SqlCommand(sqlQuery, con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@TicketId", SqlDbType.Int)).Value = 0;

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    Ticket ticket = new Ticket();

                    ticket.ID = Convert.ToInt32(rdr["ID"]);
                    ticket.Business_name = rdr["businees_name"].ToString();
                    ticket.Telephone = rdr["business_phone"].ToString();
                    ticket.Location = rdr["business_location"].ToString();
                    ticket.Contact_Person = rdr["contact_person"].ToString();
                    ticket.Personal_Email = rdr["contact_email"].ToString();
                    ticket.Priority = rdr["priority"].ToString();
                    ticket.Category = rdr["category"].ToString();
                    ticket.Assigned_To = rdr["assigned"].ToString();
                    ticket.Number = rdr["ticket_number"].ToString();
                    ticket.Status = rdr["status"].ToString();

                    lstticket.Add(ticket);
                }
                con.Close();
            }
            return lstticket;
        }

        //To Add new ticket record    
        public void AddTicket(Ticket ticket)
        {
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand("spInsertUpdateTickets", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ID", ticket.ID);
                cmd.Parameters.AddWithValue("@businessname", ticket.Business_name);
                cmd.Parameters.AddWithValue("@businessphone", ticket.Telephone);
                cmd.Parameters.AddWithValue("@businesslocation", ticket.Location);
                cmd.Parameters.AddWithValue("@contactperson", ticket.Contact_Person);
                cmd.Parameters.AddWithValue("@contactemail", ticket.Personal_Email);
                cmd.Parameters.AddWithValue("@priority", ticket.Priority);
                cmd.Parameters.AddWithValue("@category", ticket.Category);
                cmd.Parameters.AddWithValue("@assigned", ticket.Assigned_To);
                cmd.Parameters.AddWithValue("@ticketnumber", ticket.Number);
                cmd.Parameters.AddWithValue("@status", ticket.Status);
                cmd.Parameters.AddWithValue("@nextId", ticket.Personal_Email);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        //To Update the records of a particluar ticket  
        public void UpdateTicket(Ticket ticket)
        {
            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand("spInsertUpdateTickets", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@ID", ticket.ID);
                cmd.Parameters.AddWithValue("@businessname", ticket.Business_name);
                cmd.Parameters.AddWithValue("@businessphone", ticket.Telephone);
                cmd.Parameters.AddWithValue("@businesslocation", ticket.Location);
                cmd.Parameters.AddWithValue("@contactperson", ticket.Contact_Person);
                cmd.Parameters.AddWithValue("@contactemail", ticket.Personal_Email);
                cmd.Parameters.AddWithValue("@priority", ticket.Priority);
                cmd.Parameters.AddWithValue("@category", ticket.Category);
                cmd.Parameters.AddWithValue("@assigned", ticket.Assigned_To);
                cmd.Parameters.AddWithValue("@ticketnumber", ticket.Number);
                cmd.Parameters.AddWithValue("@status", ticket.Status);
                cmd.Parameters.AddWithValue("@nextId", ticket.Personal_Email);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        //Get the details of a particular ticket  
        public Ticket GetTicketData(int? id)
        {
            Ticket ticket = new Ticket();

            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {  
                string sqlQuery = "[dbo].[spGetTicketData] " + id;
                SqlCommand cmd = new SqlCommand(sqlQuery, con);

                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();

                while (rdr.Read())
                {
                    ticket.ID = Convert.ToInt32(rdr["ID"]);
                    ticket.Business_name = rdr["businees_name"].ToString();
                    ticket.Telephone = rdr["business_phone"].ToString();
                    ticket.Location = rdr["business_location"].ToString();
                    ticket.Contact_Person = rdr["contact_person"].ToString();
                    ticket.Personal_Email = rdr["contact_email"].ToString();
                    ticket.Priority = rdr["priority"].ToString();
                    ticket.Category = rdr["category"].ToString();
                    ticket.Assigned_To = rdr["assigned"].ToString();
                    ticket.Number = rdr["ticket_number"].ToString();
                    ticket.Status = rdr["status"].ToString();                    
                }
            }
            return ticket;
        }

        //To Delete the record on a particular ticket  
        public void DeleteTicket(int? id)
        {

            using (SqlConnection con = new SqlConnection(GetConnectionString()))
            {
                SqlCommand cmd = new SqlCommand("spDeleteTicket", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@TicketId", id);

                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }
        static private string GetConnectionString()
        {   
            return "Data Source=NCLLCDEV-WS\\MSQL8;Initial Catalog=HelpdeskDb;Integrated Security=True;";
        }
    }
}
