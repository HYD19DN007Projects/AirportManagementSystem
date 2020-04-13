//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AMS.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class tblPlane
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblPlane()
        {
            this.tblPlaneAllocations = new HashSet<tblPlaneAllocation>();
        }
        public string PlaneID { get; set; }
        [Required(ErrorMessage = "Please Enter Manufacturer Name")]
        [RegularExpression(@"^[A-Za-z ]+$", ErrorMessage = "Invalid Manufacturer Name")]
        public string Manufacturer_Name { get; set; }
        [Required(ErrorMessage = "Please Enter Registration Number")]
        public string Registration_No { get; set; }
        [Required(ErrorMessage = "Please Enter Model Number")]
        public string ModelNo { get; set; }
        [Required(ErrorMessage = "Please Enter Plane Name")]
        public string PlaneName { get; set; }
        [Required(ErrorMessage = "Please Enter Capacity of plane")]
        public int Capacity { get; set; }
        [Required(ErrorMessage = "Please Enter Email")]
        [EmailAddress(ErrorMessage = "Please Enter a valid email")]
        public string Email { get; set; }
        [Required(ErrorMessage = "Please Select Pilotid")]
        public string pilot_ID { get; set; }
       
        public string AddressId { get; set; }
    
        public virtual tblAddress tblAddress { get; set; }
        public virtual tblPilot tblPilot { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblPlaneAllocation> tblPlaneAllocations { get; set; }
    }
}