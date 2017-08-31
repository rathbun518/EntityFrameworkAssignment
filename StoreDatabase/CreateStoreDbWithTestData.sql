USE master
GO

--Drop database if it exists to recreate it
IF DB_ID('Store') IS NOT NULL
BEGIN
	DROP DATABASE Store
END
GO

--Create database
CREATE DATABASE Store
GO

USE Store
GO

--Create tables
CREATE TABLE Customers
(	
	CustomerID				int				NOT NULL IDENTITY(1000,1)
	,CustomerFirstName		varchar(40)		NOT NULL CHECK (len(rtrim(ltrim(CustomerFirstName))) > 0)
	,CustomerLastName		varchar(40)		NOT NULL CHECK (len(rtrim(ltrim(CustomerLastName))) > 0)
	,CustomerPhone			varchar(20)		NOT NULL
	,CustomerEmail			varchar(100)	NOT NULL
	,CustomerUserName		varchar(40)		NOT NULL UNIQUE CHECK (len(rtrim(ltrim(CustomerUserName))) > 0)
	,CustomerPassword		varchar(30)		NOT NULL CHECK (len(CustomerPassword) >= 8)
	,CONSTRAINT PK_CustomerID PRIMARY KEY (CustomerID)
)
GO

CREATE TABLE AddressTypes
(
	AddressTypeID			tinyint			NOT NULL IDENTITY(1,1)
	,AddressTypeDescription	varchar(50)		NOT NULL
	,CONSTRAINT PK_AddressTypeID PRIMARY KEY (AddressTypeID)
)
GO

CREATE TABLE CustomerAddresses
(
	CustomerAddressID		tinyint			NOT NULL IDENTITY(1,1)
	,CustomerID				int				NOT NULL
	,AddressTypeID			tinyint			NOT NULL
	,AddressLine1			varchar(50)		NOT NULL
	,AddressLine2			varchar(50)		NULL
	,City					varchar(50)		NOT NULL
	,State					char(2)			NOT NULL CHECK (State LIKE '[A-Z][A-Z]')
	,Zip					char(10)		NOT NULL
	,CONSTRAINT PK_CustomerAddressID PRIMARY KEY (CustomerAddressID)
	,CONSTRAINT FK_CustomerAddresses_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
	,CONSTRAINT FK_CustomerAddresses_AddressTypes FOREIGN KEY (AddressTypeID) REFERENCES AddressTypes(AddressTypeID)
)
GO

CREATE TABLE OrderStatus
(
	OrderStatusID			tinyint			NOT NULL IDENTITY(1,1)
	,OrderStatusDescription	varchar(30)		NOT NULL
	,CONSTRAINT PK_OrderStatusID PRIMARY KEY (OrderStatusID)
)
GO

CREATE TABLE Orders
(
	OrderID					int				NOT NULL IDENTITY(1000,1)	
	,CustomerID				int				NOT NULL
	,OrderDate				date			NOT NULL
	,OrderStatusID			tinyint			NOT NULL
	,ShippingCharge			money			NULL 
	,CONSTRAINT PK_OrderID PRIMARY KEY (OrderID)
	,CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
	,CONSTRAINT FK_Orders_OrderStatus FOREIGN KEY (OrderStatusID) REFERENCES OrderStatus(OrderStatusID)
)
GO

CREATE TABLE Payments
(
	PaymentID				int				NOT NULL IDENTITY(1000,1)
	,OrderID				int				NOT NULL
	,PaymentDate			date			NOT NULL
	,PaymentAmount			money			NOT NULL CHECK (PaymentAmount > 0)
	,CONSTRAINT PK_PaymentID PRIMARY KEY (PaymentID)
	,CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
)
GO

CREATE TABLE Vendors
(
	VendorID				int				NOT NULL IDENTITY(1000,1)
	,VendorName				varchar(50)		NOT NULL UNIQUE
	,VendorAddress1			varchar(50)		NOT NULL
	,VendorAddress2			varchar(50)		NULL
	,VendorCity				varchar(50)		NOT NULL
	,VendorState			char(2)			NOT NULL CHECK (VendorState LIKE '[A-Z][A-Z]') 
	,VendorZip				char(10)		NOT NULL
	,VendorPhone			varchar(20)		NOT NULL
	,VendorEmail			varchar(100)	NOT NULL
	,VendorContact			varchar(50)		NULL
	,AccountNumber			varchar(30)		NULL
	,CONSTRAINT PK_VendorID PRIMARY KEY (VendorID)
)
GO

CREATE TABLE ProductCategories
(
	ProductCategoryID		tinyint			NOT NULL IDENTITY(1,1)
	,ProductCategoryDescription	varchar(50)	NOT NULL
	,CONSTRAINT PK_ProductCategoryID PRIMARY KEY (ProductCategoryID)	
)
GO

CREATE TABLE Products
(
	ProductID				int				NOT NULL IDENTITY(1000,1)
	,ProductCategoryID		tinyint			NOT NULL	
	,ProductName			varchar(50)		NOT NULL
	,ProductDescription		varchar(200)	NOT NULL
	,ProductPhoto			varbinary(max)	NULL		
	,ProductPrice			money			NOT NULL CHECK (ProductPrice > 0)
	,CONSTRAINT PK_ProductID PRIMARY KEY (ProductID)
	,CONSTRAINT FK_Products_ProductCategories FOREIGN KEY (ProductCategoryID) REFERENCES ProductCategories(ProductCategoryID)
)
GO

CREATE TABLE VendorProducts
(
	ProductID				int				NOT NULL
	,VendorID				int				NOT NULL
	,QuantityInStock		int				NOT NULL
	,ProductCost			money			NOT NULL CHECK (ProductCost > 0)
	,ReorderLevel			int				NOT NULL
	,ReorderQuantity		int				NOT NULL
	,CONSTRAINT PK_VendorProductID PRIMARY KEY (ProductID,VendorID)
	,CONSTRAINT FK_VendorProducts_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
	,CONSTRAINT FK_VendorProducts_Vendors FOREIGN KEY (VendorID) REFERENCES Vendors(VendorID)
)
GO

CREATE TABLE OrderItems
(
	OrderItemID				int				NOT NULL IDENTITY(1,1)
	,OrderID				int				NOT NULL
	,ProductID				int				NOT NULL
	,OrderItemQuantity		int				NOT NULL CHECK (OrderItemQuantity > 0)
	,OrderItemPrice			money			NOT NULL CHECK (OrderItemPrice > 0)
	,CONSTRAINT PK_OrderItemID PRIMARY KEY (OrderItemID)
	,CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
	,CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductID) REFERENCES Products(ProductID)	
)
GO

CREATE TABLE ShippingCarriers
(
	ShippingCarrierID		tinyint			NOT NULL IDENTITY(1,1)
	,ShippingCarrierName	varchar(50)		NOT NULL UNIQUE
	,CONSTRAINT PK_ShippingCarrierID PRIMARY KEY (ShippingCarrierID)
)
GO

CREATE TABLE ShipmentStatus
(
	ShipmentStatusID		tinyint			NOT NULL IDENTITY(1,1)
	,ShipmentStatusDescription	varchar(30)	NOT NULL
	,CONSTRAINT PK_ShipmentStatusID PRIMARY KEY (ShipmentStatusID)
)
GO

CREATE TABLE Shipments
(
	ShipmentID				int				NOT NULL IDENTITY(1000,1)
	,OrderID				int				NOT NULL
	,ShipDate				date			NOT NULL
	,ShippingCarrierID		tinyint			NOT NULL 
	,TrackingNumber			varchar(30)		NOT NULL UNIQUE
	,ShipmentStatusID		tinyint			NOT NULL
	,CONSTRAINT PK_ShipmentID PRIMARY KEY (ShipmentID)
	,CONSTRAINT FK_Shipments_Orders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
	,CONSTRAINT FK_Shipments_ShippingCarriers FOREIGN KEY (ShippingCarrierID) REFERENCES ShippingCarriers(ShippingCarrierID)
	,CONSTRAINT FK_Shipments_ShipmentStatus FOREIGN KEY (ShipmentStatusID) REFERENCES ShipmentStatus(ShipmentStatusID)
)
GO

CREATE TABLE ShipmentItems
(
	OrderItemID				int				NOT NULL
	,ShipmentID				int				NOT NULL
	,CONSTRAINT PK_ShipmentItemID PRIMARY KEY (OrderItemID,ShipmentID)
	,CONSTRAINT FK_ShipmentItems_OrderItems FOREIGN KEY (OrderItemID) REFERENCES OrderItems(OrderItemID)
	,CONSTRAINT FK_ShipmentItems_Shipments FOREIGN KEY (ShipmentID) REFERENCES Shipments(ShipmentID)
)
GO


INSERT INTO AddressTypes
	(AddressTypeDescription)
VALUES
	('Billing')
	,('Shipping')
GO

INSERT INTO Customers
	(CustomerFirstName, CustomerLastName, CustomerPhone, CustomerEmail, CustomerUserName, CustomerPassword)
VALUES
	('Barbara', 'Bell', '(524)953-5841', 'bbell0@purevolume.com', 'bbell0', '5954BbXeQhwy')
	,('James', 'Ross', '(369)939-2139', 'jross1@marketwatch.com', 'jross1', '2sRUZOrVr')
	,('Katherine', 'Williams', '(888)819-5072', 'kwilliams2@imgur.com', 'kwilliams2', 'ntdo9140')
	,('Philip', 'Harvey', '(207)959-5016', 'pharvey3@ehow.com', 'pharvey3', 'Btjk3umV')
	,('Mark', 'Carr', '(691)685-9956', 'mcarr4@microsoft.com', 'mcarr4', '30Hc8QUdvZPr')
	,('Jean', 'Jones', '(371)272-9257', 'jjones5@sogou.com', 'jjones5', 'u7FemkrOuJ')
	,('Susan', 'Harvey', '(439)402-8076', 'sharvey6@e-recht24.de', 'sharvey6', 'qLpZfSFUte')
	,('Debra', 'Freeman', '(242)743-2206', 'dfreeman7@howstuffworks.com', 'dfreeman7', '93eGfkmP7Se')
	,('Dorothy', 'Pierce', '(269)436-0267', 'dpierce8@independent.co.uk', 'dpierce8', 'zut4kkzpAvj')
	,('Gregory', 'Matthews', '(809)838-9790', 'gmatthews9@ask.com', 'gmatthews9', '1CWUhojMvlT')
GO

INSERT INTO CustomerAddresses
	(CustomerID, AddressTypeID, AddressLine1,  City, State, Zip)
VALUES
	(1000, 1, '9 Straubel Crossing', 'Chicago', 'IL', '60663')
	,(1000, 2, '84006 Sage Plaza', 'Delray Beach', 'FL', '33448')
	,(1001, 1, '34349 Vahlen Parkway', 'Hialeah', 'FL', '33013')
	,(1001, 2, '406 Dapin Place', 'Houston', 'TX', '77080')
	,(1002, 1, '3125 Morrow Hill', 'Shreveport', 'LA', '71151')
	,(1003, 1, '2 Debra Plaza', 'Bradenton', 'FL', '34282')
	,(1003, 2, '7565 Village Court', 'Jersey City', 'NJ', '07305')
	,(1004, 1, '71 Green Pass', 'San Antonio', 'TX', '78230')
	,(1005, 1, '96 Nova Terrace', 'Saint Louis', 'MO', '63116')
	,(1006, 1, '1266 Killdeer Place', 'Pittsburgh', 'PA', '15225')
	,(1006, 2, '166 Swallow Way', 'Albuquerque', 'NM', '87190')
	,(1006, 2, '0051 Corscot Trail', 'Clearwater', 'FL', '34620')
	,(1007, 1, '14920 Elka Terrace', 'Pittsburgh', 'PA', '15210')
	,(1008, 1, '3215 Superior Pass', 'Tallahassee', 'FL', '32309')
	,(1009, 1, '0227 Old Shore Way', 'Las Vegas', 'NV', '89193')
	,(1009, 2, '7 Lakewood Court', 'Dallas', 'TX', '75372')
GO

INSERT INTO Vendors
	(VendorName, VendorAddress1, VendorAddress2, VendorCity, VendorState, VendorZip, VendorPhone, VendorEmail, VendorContact, AccountNumber)
VALUES
	('FedEx', '5 Katie Avenue', NULL, 'Washington', 'DC', '20591', '(202)759-4294', 'ebryant0@fedex.com', 'Earl Bryant', '89-6649835')
	,('UPS', '16852 Almo Center', NULL, 'Washington', 'DC', '20337', '(202)533-7606', 'aedwards1@ups.com', 'Adam Edwards', '08-8726978')
	,('USPS', '9241 Summer Ridge Center', NULL, 'Springfield', 'VA', '22156', '(571)150-7124', 'mnelson2@usps.gov', 'Mildred Nelson', '61-6447298')
	,('Elmhurst Electric', '68 Jay Avenue', NULL, 'El Paso', 'TX', '79977', '(915)135-0401', 'vbarnes3@elmhurst.com', 'Virginia Barnes', '67-3759135')
	,('Artminds', '032 Almo Trail', 'Suite 150', 'Oceanside', 'CA', '92056', '(760)249-2842', 'cmills4@artminds.com', 'Cynthia Mills', '53-4096916')
	,('Prismacolor', '036 5th Park', 'Ste 4', 'Washington', 'DC', '20442', '(202)522-3114', 'pgrant5@prismacolor.com', 'Paula Grant', '46-9923743')
	,('Creatology', '3794 Haas Crossing', NULL, 'Montgomery', 'AL', '36109', '(334)359-3924', 'bdean6@creatology.com', 'Billy Dean', '71-2107620')
	,('Sewing Stuff', '9 Merrick Pass', NULL, 'Frederick', 'MD', '21705', '(240)322-1433', 'wbrown7@sewing.com', 'William Brown', '69-4302683')
GO

INSERT INTO ProductCategories
    (ProductCategoryDescription)
VALUES
    ('Candlemaking')
    ,('Soapmaking')
	,('Wood Crafts')
	,('Drawing')
	,('Painting')
	,('Sewing & Fabrics')
	,('Knitting & Crochet')
	,('Beads & Jewelry')
	,('Clay & Molding')
GO

INSERT INTO Products
    (ProductCategoryID, ProductName, ProductDescription, ProductPrice)
VALUES
    (1, 'Soy Wax', 'Soy wax for container candles; 4 lb.', 21.99)
	,(1, 'Prewaxed Wicks & Clips', 'Prewaxed, flat braid wicks for pillar/filled candles; 6 wick/clip sets.', 3.99)
	,(1, 'Fragrance Oil, Strawberry', 'Strawberry fragrance oil for candlemaking; 0.5 oz.', 3.99)
	,(1, 'Liquid Dye, Red', 'Red liquid dye for candlemaking; 0.5 oz.', 3.99)
	,(2, 'Clear Glycerin Soap', 'Melt and pour soap base; 2 lb.', 10.49)
	,(2, 'Soap Fragance, Vanilla', 'Vanilla fragrance specially blended for soapmaking;  0.5 oz.', 3.99)
	,(2, 'Soap Molds, Flowers & Leaves', 'Soap mold with three flower molds and two leaf molds.', 3.49)
	,(9, 'Plaster Molding Kit', 'Plaster molding kit to make keepsake of a hand; includes plaster, mold tray and paint.', 9.99)
	,(3, 'Wooden Box', 'Unfinished wood box ready to decorate; dimensions 8" x 5" x 3"', 5.99)
	,(5, 'Watercolor Set', 'Set of 36 watercolor paints', 6.49)
	,(5, 'Canvas Pack, 16" x 20"', '100% cotton canvas stapled on wood frame; pack of 4.', 19.99)
	,(4, 'Colored Pencil Set', 'Premier colored pencils with soft cores; 36 pencils.', 15.99)
GO

INSERT INTO VendorProducts
	(ProductID, VendorID, QuantityInStock, ProductCost, ReorderLevel, ReorderQuantity)
VALUES
	(1000, 1004, 100, 12.99, 50, 100)
	,(1001, 1004, 45, 2.50, 50, 100)
	,(1002, 1004, 60, 2.50, 50, 100)
	,(1003, 1004, 35, 2.50, 50, 100)
	,(1004, 1004, 90, 5.99, 50, 100)
	,(1005, 1004, 88, 2.50, 50, 100)
	,(1006, 1004, 65, 1.99, 50, 100)
	,(1007, 1006, 75, 5.99, 50, 100)
	,(1008, 1006, 50, 3.50, 50, 100)
	,(1009, 1005, 75, 3.99, 50, 100)
	,(1010, 1005, 85, 13.99, 50, 100)
	,(1011, 1005, 30, 9.99, 50, 100)
GO

INSERT INTO OrderStatus
	(OrderStatusDescription)
VALUES
	('Pending')  --customer has started order on website
	,('Processed') --customer has paid for order; needs to ship
	,('Cancelled') --customer cancelled order on website
	,('Completed') --order has been paid for and shipped

GO

INSERT INTO Orders
	(CustomerID, OrderDate, OrderStatusID, ShippingCharge)
VALUES
	(1000, '5/1/2016', 3, 0.00)
	,(1001, '5/1/2016', 4, 10.50)
	,(1002, '5/5/2016', 4, 15.00)
	,(1004, '5/9/2016', 2, 8.50)
	,(1006, '5/13/2016', 1, 0.00)
	,(1007, '5/18/2016', 1, 0.00)
	,(1002, '5/23/2016', 1, 0.00)
GO

INSERT INTO Payments
	(OrderID, PaymentDate, PaymentAmount)
VALUES
	(1001, '5/1/2016', 40.47)
	,(1002, '5/5/2016', 48.96)
	,(1003, '5/9/2016', 34.98)

GO

INSERT INTO OrderItems
	(OrderID, ProductID, OrderItemQuantity, OrderItemPrice)
VALUES
	(1001, 1007, 3, 9.99)
	,(1002, 1000, 1, 21.99)
	,(1002, 1001, 1, 3.99)
	,(1002, 1002, 1, 3.99)
	,(1002, 1003, 1, 3.99)
	,(1003, 1009, 1, 6.49)
	,(1003, 1010, 1, 19.99)
GO

INSERT INTO ShipmentStatus
    (ShipmentStatusDescription)
VALUES
    ('Processing')
    ,('Shipped')
	,('Not Shipped')
GO

INSERT INTO ShippingCarriers
    (ShippingCarrierName)
VALUES
    ('FedEx')
    ,('UPS')
    ,('USPS')
GO

INSERT INTO Shipments 
	(OrderID, ShipDate, ShippingCarrierID, TrackingNumber, ShipmentStatusID)
VALUES
	(1001,'5/1/2016', 1, 'FVR456WEF34', 2)
	,(1002,'5/5/2016', 2, '6754RE34WFE', 2)
	,(1003, '5/9/2016', 1, 'FTT786EDA23', 1) 
GO

INSERT INTO ShipmentItems
	(OrderItemID, ShipmentID)
VALUES
	(1, 1000)
	,(2, 1001)
	,(3, 1001)
	,(4, 1001)
	,(5, 1001)
	,(6, 1002)
	,(7, 1002)
GO
