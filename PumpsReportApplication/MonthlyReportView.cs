//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class MonthlyReportView
    {
        public long Id { get; set; }
        public Nullable<System.DateTime> MessageDate { get; set; }
        public long StationId { get; set; }
        public long PumpId { get; set; }
        public Nullable<decimal> TotalRunHours { get; set; }
        public Nullable<long> NumberOfFaults { get; set; }
        public Nullable<decimal> Pressure { get; set; }
        public Nullable<decimal> Amps { get; set; }
        public Nullable<decimal> GeneratorKWH { get; set; }
        public Nullable<decimal> MainsKWH { get; set; }
        public string Pump { get; set; }
        public string Station { get; set; }
        public Nullable<decimal> MonthlyRunHours { get; set; }
    }
}
