//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace EntityFrameworkAssignment
{
    using System;
    using System.Collections.Generic;
    
    public partial class ShipmentStatus
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public ShipmentStatus()
        {
            this.Shipments = new HashSet<Shipments>();
        }
    
        public byte ShipmentStatusID { get; set; }
        public string ShipmentStatusDescription { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Shipments> Shipments { get; set; }
    }
}
