using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using CentralLog.Models;
using CentralLog.DAL;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Http;
using System.Runtime.CompilerServices;

namespace CentralLog.Controllers
{
    public class HomeController : Controller
    {
        //public static int count = 0;

        private CentralLogContext _context;
        public HomeController(CentralLogContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public IActionResult Login()
        {
            if(HttpContext.Session.GetString("UserName") == null)
            {
                return View();
            }
            return RedirectToAction("Index","Home");
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Login(TblUsers objUser)
        {
            if (ModelState.IsValid)
            {
                bool isExist = _context.TblUsers.Any(x => x.Email == objUser.Email && x.Password == objUser.Password);
                if (isExist)
                {
                    //count++;
                    var user = _context.TblUsers.Where(x => x.Email == objUser.Email && x.Password == objUser.Password).FirstOrDefault();
                    HttpContext.Session.SetString("UserName", user.UserName);
                    return RedirectToAction("Index", "Home" /*, new { id = user.UserId }*/);
                }
            }
            ModelState.AddModelError(string.Empty, "Invalid Email or Password!");
            return View(objUser);
        }
        [HttpGet]
        public IActionResult Register()
        {
             return View();
        }
        [HttpPost]
        public IActionResult Register(TblUsers objUser)
        {
            if (ModelState.IsValid)
            {
                bool isExist = _context.TblUsers.Any(x => x.UserName == objUser.UserName && x.Email == objUser.Email && x.Password == objUser.Password);
                if (isExist)
                {
                    ModelState.AddModelError("", "The User Already Exist!");
                    objUser.UserName = string.Empty;
                    objUser.Email = string.Empty;
                    objUser.Password = string.Empty;
                }
                else
                {
                    objUser.CreatedAt = DateTime.UtcNow;
                    objUser.IsActive = true;
                    _context.Add(objUser);
                    _context.SaveChanges();
                    return RedirectToAction("Login", "Home");
                }
            }
            return View(objUser);
        }
        public IActionResult Logout()
        {
            //count = 0;
            HttpContext.Session.Remove("UserName");
            //TempData["UserId"] = 0;
            //TempData["ContainUser"] = "";
            return RedirectToAction("Login", "Home");
        }
    }
}
