using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using CentralLog.Models;

namespace CentralLog.DAL
{
    public class BaseCentralLog
    {
        SqlConnection con;
        public BaseCentralLog()
        {
            var configuration = GetConfiguration();
            con = new SqlConnection(configuration.GetSection("Data").GetSection("ConnectionString").Value);
        }
        public IConfiguration GetConfiguration()
        {
            var getBuilder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory()).AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);
            return getBuilder.Build();
        }
    }
}
