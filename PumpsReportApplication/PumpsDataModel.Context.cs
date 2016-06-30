﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PumpsReportApplication
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class PumpsDBEntities : DbContext
    {
        public PumpsDBEntities()
            : base("name=PumpsDBEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Message> Messages { get; set; }
        public virtual DbSet<Pump> Pumps { get; set; }
        public virtual DbSet<Station> Stations { get; set; }
        public virtual DbSet<User> Users { get; set; }
        public virtual DbSet<MessageView> MessageViews { get; set; }
        public virtual DbSet<DailyReportView> DailyReportViews { get; set; }
        public virtual DbSet<YearlyReportView> YearlyReportViews { get; set; }
        public virtual DbSet<MonthlyReportView> MonthlyReportViews { get; set; }
    
        public virtual ObjectResult<DailyReportView> GetDailyReport(Nullable<long> stationId, Nullable<System.DateTime> fromDate, Nullable<System.DateTime> toDate)
        {
            var stationIdParameter = stationId.HasValue ?
                new ObjectParameter("StationId", stationId) :
                new ObjectParameter("StationId", typeof(long));
    
            var fromDateParameter = fromDate.HasValue ?
                new ObjectParameter("FromDate", fromDate) :
                new ObjectParameter("FromDate", typeof(System.DateTime));
    
            var toDateParameter = toDate.HasValue ?
                new ObjectParameter("ToDate", toDate) :
                new ObjectParameter("ToDate", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<DailyReportView>("GetDailyReport", stationIdParameter, fromDateParameter, toDateParameter);
        }
    
        public virtual ObjectResult<DailyReportView> GetDailyReport(Nullable<long> stationId, Nullable<System.DateTime> fromDate, Nullable<System.DateTime> toDate, MergeOption mergeOption)
        {
            var stationIdParameter = stationId.HasValue ?
                new ObjectParameter("StationId", stationId) :
                new ObjectParameter("StationId", typeof(long));
    
            var fromDateParameter = fromDate.HasValue ?
                new ObjectParameter("FromDate", fromDate) :
                new ObjectParameter("FromDate", typeof(System.DateTime));
    
            var toDateParameter = toDate.HasValue ?
                new ObjectParameter("ToDate", toDate) :
                new ObjectParameter("ToDate", typeof(System.DateTime));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<DailyReportView>("GetDailyReport", mergeOption, stationIdParameter, fromDateParameter, toDateParameter);
        }
    }
}
