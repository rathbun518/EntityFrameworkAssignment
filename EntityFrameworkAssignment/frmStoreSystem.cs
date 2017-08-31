using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace EntityFrameworkAssignment
{
    public partial class frmStoreSystem : Form
    {
        public frmStoreSystem()
        {
            InitializeComponent();
        }

        /// <summary>
        /// Show name and email for all customers
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnShowCustomers_Click(object sender, EventArgs e)
        {
            listView1.Clear();
            listView1.Columns.Clear();

            StoreEntities db = new StoreEntities();

            var customers =
                (from customer in db.Customers
                 orderby customer.CustomerLastName
                 select new
                 {
                     customer.CustomerID,
                     customer.CustomerFirstName,
                     customer.CustomerLastName,
                     customer.CustomerEmail
                 }).ToList();

            listView1.Columns.Add("Customer Name", 175);
            listView1.Columns.Add("Customer Email", 260);

            int i = 0;
            foreach (var c in customers)
            {
                listView1.Items.Add($"{c.CustomerFirstName} {c.CustomerLastName}");
                listView1.Items[i].SubItems.Add(c.CustomerEmail);
                i += 1;
            }
        }

        /// <summary>
        /// Show order status for all orders
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnOrderStatus_Click(object sender, EventArgs e)
        {
            listView1.Clear();
            listView1.Columns.Clear();

            StoreEntities db = new StoreEntities();

            var orders =
                (from order in db.Orders
                 join orderStatus in db.OrderStatus
                 on order.OrderStatusID equals orderStatus.OrderStatusID
                 select new
                 {
                     order.OrderID,
                     order.OrderDate,
                     orderStatus.OrderStatusDescription
                 }).ToList();

            listView1.Columns.Add("Order ID", 100);
            listView1.Columns.Add("Order Date", 125);
            listView1.Columns.Add("Order Status", 210);

            int i = 0;
            foreach (var o in orders)
            {
                listView1.Items.Add(o.OrderID.ToString());
                
                listView1.Items[i].SubItems.Add(o.OrderDate.ToShortDateString());
                listView1.Items[i].SubItems.Add(o.OrderStatusDescription);
                i += 1;
            }
        }

        /// <summary>
        /// Show products to reorder if quantity in stock 
        /// is less than or equal to the product reorder level
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void btnShowProductsToReorder_Click(object sender, EventArgs e)
        {
            listView1.Clear();
            listView1.Columns.Clear();

            StoreEntities db = new StoreEntities();

            var products =
                (from product in db.Products
                 join vendorProduct in db.VendorProducts
                 on product.ProductID equals vendorProduct.ProductID
                 join vendor in db.Vendors
                 on vendorProduct.VendorID equals vendor.VendorID
                 where vendorProduct.QuantityInStock <= vendorProduct.ReorderLevel
                 select new
                 {
                    product.ProductID,
                    product.ProductName,
                    vendorProduct.QuantityInStock,
                    vendorProduct.ReorderLevel,
                    vendor.VendorName
                 }).ToList();

            listView1.Columns.Add("Product ID", 67);
            listView1.Columns.Add("Product Name", 128);
            listView1.Columns.Add("Qty in Stock", 73);
            listView1.Columns.Add("Reorder Level", 83);
            listView1.Columns.Add("Vendor Name", 84);

            int i = 0;
            foreach (var p in products)
            {
                listView1.Items.Add(p.ProductID.ToString());

                listView1.Items[i].SubItems.Add(p.ProductName);
                listView1.Items[i].SubItems.Add(p.QuantityInStock.ToString());
                listView1.Items[i].SubItems.Add(p.ReorderLevel.ToString());
                listView1.Items[i].SubItems.Add(p.VendorName);
                i += 1;
            }
        }

        private void frmStoreSystem_Load(object sender, EventArgs e)
        {
            listView1.Clear();
            listView1.Columns.Clear();
        }
    }
}
