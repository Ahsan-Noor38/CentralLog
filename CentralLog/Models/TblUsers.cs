using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace CentralLog.Models
{
    public partial class TblUsers
    {
        [Key]
        public long UserId { get; set; }
        //[Required]
        [Display(Name ="User Name")]
        public string UserName { get; set; }
        [Required]
        [EmailAddress]
        public string Email { get; set; }
        [Required]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        public DateTime? CreatedAt { get; set; }
        public bool? IsActive { get; set; }
    }
}
