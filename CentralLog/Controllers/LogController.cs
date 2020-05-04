using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using CentralLog.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

namespace CentralLog.Controllers
{
    public class LogController : Controller
    {
        private CentralLogContext _context;
        public LogController(CentralLogContext context)
        {
            _context = context;
        }
        
        public IActionResult Index()
        {
            if (HttpContext.Session.GetString("UserName") != null)
            {
                //var user = _context.TblUsers.Where(x => x.UserId == id).FirstOrDefault();
                //TempData["UserId"] = id;

                //TempData["ContainUser"] = user.UserName;
                return View(_context.Log.ToList());
            }
            else
            {
                return RedirectToAction("Login", "Home");
            }
        }
        public IActionResult Create()
        {
            if(HttpContext.Session.GetString("UserName") != null)
            {
                //var user = _context.TblUsers.Where(x => x.UserId == id).FirstOrDefault();
                //TempData["UserId"] = id;
                //TempData["ContainUser"] = user.UserName;
                return View();
            }
            return RedirectToAction("Login", "Home");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Log objLog)
        {
            if (ModelState.IsValid)
            {
                //if (Convert.ToInt32(userId) != 0)
                //{
                _context.Log.Add(objLog);
                _context.SaveChanges();
                return RedirectToAction("Index", "Log");
                //}
            }

            return View(objLog);
        }
    }
}