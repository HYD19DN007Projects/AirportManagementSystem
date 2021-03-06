﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class AMSEntities : DbContext
    {
        public AMSEntities()
            : base("name=AMSEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<tblAddress> tblAddresses { get; set; }
        public virtual DbSet<tblHanger> tblHangers { get; set; }
        public virtual DbSet<tblLogin> tblLogins { get; set; }
        public virtual DbSet<tblManager> tblManagers { get; set; }
        public virtual DbSet<tblPilot> tblPilots { get; set; }
        public virtual DbSet<tblPlane> tblPlanes { get; set; }
        public virtual DbSet<tblPlaneAllocation> tblPlaneAllocations { get; set; }
    
        public virtual ObjectResult<string> sp_Address(string city)
        {
            var cityParameter = city != null ?
                new ObjectParameter("city", city) :
                new ObjectParameter("city", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("sp_Address", cityParameter);
        }
    
        public virtual ObjectResult<string> sp_Pilot(string socialsecurityno)
        {
            var socialsecuritynoParameter = socialsecurityno != null ?
                new ObjectParameter("socialsecurityno", socialsecurityno) :
                new ObjectParameter("socialsecurityno", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("sp_Pilot", socialsecuritynoParameter);
        }
    
        public virtual ObjectResult<string> sp_Plane(string regno)
        {
            var regnoParameter = regno != null ?
                new ObjectParameter("regno", regno) :
                new ObjectParameter("regno", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("sp_Plane", regnoParameter);
        }
    
        public virtual ObjectResult<sp_getPilotId_Result> sp_getPilotId()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getPilotId_Result>("sp_getPilotId");
        }
    
        public virtual ObjectResult<sp_AvailableHangersDetails_Result> sp_AvailableHangersDetails(Nullable<System.DateTime> f, Nullable<System.DateTime> t)
        {
            var fParameter = f.HasValue ?
                new ObjectParameter("f", f) :
                new ObjectParameter("f", typeof(System.DateTime));
    
            var tParameter = t.HasValue ?
                new ObjectParameter("t", t) :
                new ObjectParameter("t", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_AvailableHangersDetails_Result>("sp_AvailableHangersDetails", fParameter, tParameter);
        }
    
        public virtual ObjectResult<sp_getStatus_Result> sp_getStatus(string hno, Nullable<System.DateTime> stdt, Nullable<System.DateTime> endt)
        {
            var hnoParameter = hno != null ?
                new ObjectParameter("hno", hno) :
                new ObjectParameter("hno", typeof(string));
    
            var stdtParameter = stdt.HasValue ?
                new ObjectParameter("stdt", stdt) :
                new ObjectParameter("stdt", typeof(System.DateTime));
    
            var endtParameter = endt.HasValue ?
                new ObjectParameter("endt", endt) :
                new ObjectParameter("endt", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_getStatus_Result>("sp_getStatus", hnoParameter, stdtParameter, endtParameter);
        }
    
        public virtual ObjectResult<string> sp_Hanger(string location)
        {
            var locationParameter = location != null ?
                new ObjectParameter("location", location) :
                new ObjectParameter("location", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("sp_Hanger", locationParameter);
        }
    
        public virtual ObjectResult<string> sp_Manager(string socialsecurityno)
        {
            var socialsecuritynoParameter = socialsecurityno != null ?
                new ObjectParameter("socialsecurityno", socialsecurityno) :
                new ObjectParameter("socialsecurityno", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<string>("sp_Manager", socialsecuritynoParameter);
        }
    }
}
