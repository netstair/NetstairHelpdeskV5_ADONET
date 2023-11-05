using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using NetstairHelpdeskV5.Models;

namespace NetstairHelpdeskV5.Controllers
{
    public class TicketController : Controller
    {
        TicketDataAccessLayer objticket = new TicketDataAccessLayer();

        public IActionResult Index()
        {
            List<Ticket> lstTicket = new List<Ticket>();            
            lstTicket = objticket.GetAllTickets().ToList();

            return View(lstTicket);
        }
        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind] Ticket ticket)
        {
            if (ModelState.IsValid)
            {
                objticket.AddTicket(ticket);
                return RedirectToAction("Index");
            }
            return View(ticket);
        }

        [HttpGet]
        public IActionResult Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            Ticket ticket = objticket.GetTicketData(id);

            if (ticket == null)
            {
                return NotFound();
            }
            return View(ticket);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind] Ticket ticket)
        {
            if (id != ticket.ID)
            {
                return NotFound();
            }
            if (ModelState.IsValid)
            {
                objticket.UpdateTicket(ticket);
                return RedirectToAction("Index");
            }
            return View(ticket);
        }

        [HttpGet]
        public IActionResult Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            Ticket ticket = objticket.GetTicketData(id);

            if (ticket == null)
            {
                return NotFound();
            }
            return View(ticket);
        }

        [HttpGet]
        public IActionResult Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }
            Ticket ticket = objticket.GetTicketData(id);

            if (ticket == null)
            {
                return NotFound();
            }
            return View(ticket);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int? id)
        {
            objticket.DeleteTicket(id);
            return RedirectToAction("Index");
        }
    }
}
