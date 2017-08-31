namespace EntityFrameworkAssignment
{
    partial class frmStoreSystem
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.btnShowCustomers = new System.Windows.Forms.Button();
            this.btnOrderStatus = new System.Windows.Forms.Button();
            this.btnShowProductsToReorder = new System.Windows.Forms.Button();
            this.listView1 = new System.Windows.Forms.ListView();
            this.SuspendLayout();
            // 
            // btnShowCustomers
            // 
            this.btnShowCustomers.Location = new System.Drawing.Point(23, 35);
            this.btnShowCustomers.Name = "btnShowCustomers";
            this.btnShowCustomers.Size = new System.Drawing.Size(106, 52);
            this.btnShowCustomers.TabIndex = 1;
            this.btnShowCustomers.Text = "Show Customer Email List";
            this.btnShowCustomers.UseVisualStyleBackColor = true;
            this.btnShowCustomers.Click += new System.EventHandler(this.btnShowCustomers_Click);
            // 
            // btnOrderStatus
            // 
            this.btnOrderStatus.Location = new System.Drawing.Point(23, 115);
            this.btnOrderStatus.Name = "btnOrderStatus";
            this.btnOrderStatus.Size = new System.Drawing.Size(106, 52);
            this.btnOrderStatus.TabIndex = 2;
            this.btnOrderStatus.Text = "Show Order Status";
            this.btnOrderStatus.UseVisualStyleBackColor = true;
            this.btnOrderStatus.Click += new System.EventHandler(this.btnOrderStatus_Click);
            // 
            // btnShowProductsToReorder
            // 
            this.btnShowProductsToReorder.Location = new System.Drawing.Point(23, 195);
            this.btnShowProductsToReorder.Name = "btnShowProductsToReorder";
            this.btnShowProductsToReorder.Size = new System.Drawing.Size(106, 52);
            this.btnShowProductsToReorder.TabIndex = 3;
            this.btnShowProductsToReorder.Text = "Show Products to Reorder";
            this.btnShowProductsToReorder.UseVisualStyleBackColor = true;
            this.btnShowProductsToReorder.Click += new System.EventHandler(this.btnShowProductsToReorder_Click);
            // 
            // listView1
            // 
            this.listView1.GridLines = true;
            this.listView1.Location = new System.Drawing.Point(162, 35);
            this.listView1.Margin = new System.Windows.Forms.Padding(0);
            this.listView1.Name = "listView1";
            this.listView1.Size = new System.Drawing.Size(440, 212);
            this.listView1.TabIndex = 5;
            this.listView1.UseCompatibleStateImageBehavior = false;
            this.listView1.View = System.Windows.Forms.View.Details;
            // 
            // frmStoreSystem
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(634, 283);
            this.Controls.Add(this.listView1);
            this.Controls.Add(this.btnShowProductsToReorder);
            this.Controls.Add(this.btnOrderStatus);
            this.Controls.Add(this.btnShowCustomers);
            this.Name = "frmStoreSystem";
            this.Text = "Store Management System";
            this.Load += new System.EventHandler(this.frmStoreSystem_Load);
            this.ResumeLayout(false);

        }

        #endregion
        private System.Windows.Forms.Button btnShowCustomers;
        private System.Windows.Forms.Button btnOrderStatus;
        private System.Windows.Forms.Button btnShowProductsToReorder;
        private System.Windows.Forms.ListView listView1;
    }
}

