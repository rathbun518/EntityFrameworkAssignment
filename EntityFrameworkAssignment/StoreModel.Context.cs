﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class StoreEntities : DbContext
    {
        public StoreEntities()
            : base("name=StoreEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AddressTypes> AddressTypes { get; set; }
        public virtual DbSet<CustomerAddresses> CustomerAddresses { get; set; }
        public virtual DbSet<Customers> Customers { get; set; }
        public virtual DbSet<OrderItems> OrderItems { get; set; }
        public virtual DbSet<Orders> Orders { get; set; }
        public virtual DbSet<OrderStatus> OrderStatus { get; set; }
        public virtual DbSet<Payments> Payments { get; set; }
        public virtual DbSet<ProductCategories> ProductCategories { get; set; }
        public virtual DbSet<Products> Products { get; set; }
        public virtual DbSet<Shipments> Shipments { get; set; }
        public virtual DbSet<ShipmentStatus> ShipmentStatus { get; set; }
        public virtual DbSet<ShippingCarriers> ShippingCarriers { get; set; }
        public virtual DbSet<VendorProducts> VendorProducts { get; set; }
        public virtual DbSet<Vendors> Vendors { get; set; }
    }
}
