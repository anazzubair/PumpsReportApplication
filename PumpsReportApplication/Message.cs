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
    
    public partial class Message
    {
        public long Id { get; set; }
        public long StationId { get; set; }
        public long PumpId { get; set; }
        public decimal TotalRunHours { get; set; }
        public decimal DailyRunHours { get; set; }
        public long NumberOfFaults { get; set; }
        public decimal Pressure { get; set; }
        public decimal Amps { get; set; }
        public decimal MainsKWH { get; set; }
        public decimal GeneratorKWH { get; set; }
        public string IsFault { get; set; }
        public System.DateTime MessageTime { get; set; }
        public System.DateTime ReceiveTime { get; set; }
    
        public virtual Pump Pump { get; set; }
        public virtual Station Station { get; set; }
    }
}
