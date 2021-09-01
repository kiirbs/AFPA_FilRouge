DROP DATABASE IF EXISTS fil_rouge;

CREATE DATABASE fil_rouge;

USE fil_rouge;

CREATE TABLE Suppliers(
   sup_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   sup_name VARCHAR(255) NOT NULL,
   sup_address VARCHAR(150) NOT NULL,
   sup_zipcode CHAR(5) NOT NULL,
   sup_city VARCHAR(100) NOT NULL,
   sup_email VARCHAR(255) NOT NULL,
   sup_phone CHAR(10) NOT NULL,
   sup_contact VARCHAR(100) NOT NULL,
   UNIQUE(sup_name),
   UNIQUE(sup_email),
   UNIQUE(sup_phone)
);

CREATE TABLE Orders(
   ord_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   ord_order_date DATE NOT NULL,
   ord_payment_date DATE NOT NULL,
   ord_reception_date DATE NOT NULL,
   ord_status VARCHAR(50) NOT NULL,
   ord_address VARCHAR(255) NOT NULL,
   ord_price_ttc DECIMAL(10,2) NOT NULL,
   ord_pay_types BOOLEAN
);

CREATE TABLE Catalogue(
   cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   cat_achat_htva DECIMAL(10,2) NOT NULL,
   cat_achat_tvac DECIMAL(10,2) NOT NULL
);

CREATE TABLE Discount(
   dis_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   dis_pourcentage_value DECIMAL(4,2),
   dis_discount_code VARCHAR(255),
   dis_amount DECIMAL(10,2)
);

CREATE TABLE Relationship(
   rel_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   rel_contact VARCHAR(255) NOT NULL
);

CREATE TABLE Marketing(
   mar_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   mar_contact VARCHAR(255) NOT NULL,
   mar_types BOOLEAN NOT NULL
);

CREATE TABLE Staff(
   sta_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   sta_lastname VARCHAR(50) NOT NULL,
   sta_firstname VARCHAR(50) NOT NULL,
   sta_address VARCHAR(150) NOT NULL,
   sta_city VARCHAR(100) NOT NULL,
   sta_zipcode CHAR(5) NOT NULL,
   sta_email VARCHAR(255) NOT NULL,
   sta_phone CHAR(10) NOT NULL,
   sta_pay DECIMAL(10,2) NOT NULL,
   sta_add_date DATETIME NOT NULL,
   sta_update_date DATETIME NOT NULL,
   UNIQUE(sta_email),
   UNIQUE(sta_phone)
);

CREATE TABLE After_Sales(
   afs_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   afs_contact VARCHAR(255) NOT NULL
);

CREATE TABLE Accounting(
   acc_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   acc_contact VARCHAR(255) NOT NULL
);

CREATE TABLE Stock(
   sto_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   sto_min CHAR(3) NOT NULL,
   sto_max CHAR(10) NOT NULL,
   sto_number_products INT
);

CREATE TABLE Customers(
   cus_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   cus_lastname VARCHAR(50) NOT NULL,
   cus_firstname VARCHAR(50) NOT NULL,
   cus_password VARCHAR(255) NOT NULL,
   cus_address VARCHAR(150) NOT NULL,
   cus_zipcode CHAR(5) NOT NULL,
   cus_city VARCHAR(100) NOT NULL,
   cus_countries_id CHAR(2) NOT NULL,
   cus_email VARCHAR(255) NOT NULL,
   cus_phone CHAR(10) NOT NULL,
   cus_add_date DATETIME NOT NULL,
   cus_update_date DATETIME,
   cus_types BOOLEAN NOT NULL,
   cus_coeff DECIMAL(4,2) NOT NULL,
   cus_reference VARCHAR(255) NOT NULL,
   mar_id INT DEFAULT NULL,
   UNIQUE(cus_email),
   UNIQUE(cus_phone),
   UNIQUE(cus_reference),
   FOREIGN KEY(mar_id) REFERENCES Marketing(mar_id)
);

CREATE TABLE Categories(
   cat_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   cat_name VARCHAR(100) NOT NULL,
   UNIQUE(cat_name)
);

CREATE TABLE SubCategories(
   sub_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   sub_name VARCHAR(100) NOT NULL,
   sub_parent_id INT,
   cat_id INT,
   FOREIGN KEY(cat_id) REFERENCES Categories(cat_id)
);

CREATE TABLE Products(
   pro_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   pro_marque VARCHAR(255) NOT NULL,
   pro_name VARCHAR(255) NOT NULL,
   pro_desc TEXT NOT NULL,
   pro_vente_htva DECIMAL(10,2) NOT NULL,
   pro_vente_tvac DECIMAL(10,2) NOT NULL,
   pro_ean VARCHAR(20) NOT NULL,
   pro_color VARCHAR(30) NOT NULL,
   pro_picture TEXT DEFAULT NULL,
   sub_id INT,
   FOREIGN KEY (sub_id) REFERENCES SubCategories(sub_id)
);

CREATE TABLE Orders_details(
   ode_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   ode_unit_price DECIMAL(19,4) NOT NULL,
   ode_quantity INT NOT NULL,
   ode_invoice_address VARCHAR(100) NOT NULL,
   ode_pay_types BOOLEAN,
   cus_id INT NOT NULL,
   FOREIGN KEY(cus_id) REFERENCES Customers(cus_id)
);

CREATE TABLE Delivery(
   del_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   del_date DATETIME NOT NULL,
   del_status VARCHAR(255) NOT NULL,
   del_quantity VARCHAR(255) NOT NULL,
   ode_id INT NOT NULL,
   FOREIGN KEY(ode_id) REFERENCES Orders_details(ode_id)
);

CREATE TABLE Sell(
   pro_id INT,
   cat_id INT,
   PRIMARY KEY(pro_id, cat_id),
   FOREIGN KEY(pro_id) REFERENCES Products(pro_id),
   FOREIGN KEY(cat_id) REFERENCES Catalogue(cat_id)
);

CREATE TABLE Supply(
   sup_id INT,
   cat_id INT,
   PRIMARY KEY(sup_id, cat_id),
   FOREIGN KEY(sup_id) REFERENCES Suppliers(sup_id),
   FOREIGN KEY(cat_id) REFERENCES Catalogue(cat_id)
);

CREATE TABLE Go_To(
   cus_id INT,
   ord_id INT,
   PRIMARY KEY(cus_id, ord_id),
   FOREIGN KEY(cus_id) REFERENCES Customers(cus_id),
   FOREIGN KEY(ord_id) REFERENCES Orders(ord_id)
);

CREATE TABLE Apply(
   ord_id INT,
   dis_id INT,
   PRIMARY KEY(ord_id, dis_id),
   FOREIGN KEY(ord_id) REFERENCES Orders(ord_id),
   FOREIGN KEY(dis_id) REFERENCES Discount(dis_id)
);

CREATE TABLE Ship(
   ord_id INT,
   del_id INT,
   PRIMARY KEY(ord_id, del_id),
   FOREIGN KEY(ord_id) REFERENCES Orders(ord_id),
   FOREIGN KEY(del_id) REFERENCES Delivery(del_id)
);

CREATE TABLE Trade(
   sup_id INT,
   rel_id INT,
   PRIMARY KEY(sup_id, rel_id),
   FOREIGN KEY(sup_id) REFERENCES Suppliers(sup_id),
   FOREIGN KEY(rel_id) REFERENCES Relationship(rel_id)
);

CREATE TABLE Manage(
   cat_id INT,
   rel_id INT,
   sto_id INT,
   PRIMARY KEY(cat_id, rel_id, sto_id),
   FOREIGN KEY(cat_id) REFERENCES Catalogue(cat_id),
   FOREIGN KEY(rel_id) REFERENCES Relationship(rel_id),
   FOREIGN KEY(sto_id) REFERENCES Stock(sto_id)
);

CREATE TABLE Exchanges(
   cus_id INT,
   afs_id INT,
   acc_id INT,
   PRIMARY KEY(cus_id, afs_id, acc_id),
   FOREIGN KEY(cus_id) REFERENCES Customers(cus_id),
   FOREIGN KEY(afs_id) REFERENCES After_Sales(afs_id),
   FOREIGN KEY(acc_id) REFERENCES Accounting(acc_id)
);

CREATE TABLE Store(
   pro_id INT,
   sto_id INT,
   PRIMARY KEY(pro_id, sto_id),
   FOREIGN KEY(pro_id) REFERENCES Products(pro_id),
   FOREIGN KEY(sto_id) REFERENCES Stock(sto_id)
);

CREATE INDEX idx_suppliers
ON Suppliers (sup_id);

CREATE INDEX idx_subcategories
ON SubCategories (sub_id);

CREATE INDEX idx_orders
ON Orders (ord_id);

CREATE INDEX idx_shops
ON Catalogue (cat_id);

CREATE INDEX idx_discount
ON Discount (dis_id);

CREATE INDEX idx_relationship
ON Relationship (rel_id);

CREATE INDEX idx_marketing
ON Marketing (mar_id);

CREATE INDEX idx_staff
ON Staff (sta_id);

CREATE INDEX idx_after_sales
ON After_Sales (afs_id);

CREATE INDEX idx_Accounting
ON Accounting (acc_id);

CREATE INDEX idx_customers
ON Customers (cus_id);

CREATE INDEX idx_categories
ON Categories (cat_id);

CREATE INDEX idx_orders_details
ON Orders_details (ode_id);

CREATE INDEX idx_delivery
ON Delivery (del_id);

CREATE INDEX idx_products
ON Products (pro_id);

CREATE INDEX idx_stock
ON Stock (sto_id);