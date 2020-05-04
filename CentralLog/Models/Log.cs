using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CentralLog.Models
{
    public partial class Log
    {
        [Key]
        public long Id { get; set; }
        public DateTime CreatedAt { get; set; }
        [Required]
        public string Application { get; set; }
        [Required]
        public string Scope { get; set; }
        [Required]
        public string Level { get; set; }
        [Required]
        public string ClientIp { get; set; }
        [Required]
        public string Message { get; set; }
        [Required]
        public string Url { get; set; }
        [Required]
        public decimal DurationInSeconds { get; set; }
    }
}
