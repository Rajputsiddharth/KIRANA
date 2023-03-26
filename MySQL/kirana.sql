DROP DATABASE IF EXISTS kirana;
CREATE DATABASE kirana;
USE kirana;

DROP TABLE IF EXISTS Customer;
CREATE TABLE Customer
(
	customer_id INT AUTO_INCREMENT NOT NULL,
    first_name varchar(40) NOT NULL,
    middle_name varchar(40),
    last_name varchar(40),
    date_of_birth date NOT NULL,
    phone_num varchar(20) NOT NULL unique,
    email_address varchar(50) NOT NULL unique,
    password varchar(30) NOT NULL,
    apt_number INT check(apt_number >= 0) NOT NULL,
	street text NOT NULL,
    city varchar(50) NOT NULL,
    state varchar(50) NOT NULL,
	pincode numeric(7,0) check(pincode >= 0) NOT NULL,
    PRIMARY KEY (customer_id)
);


DROP TABLE IF EXISTS Seller;
create table Seller
(
	seller_id INT AUTO_INCREMENT NOT NULL,
    name varchar(40) NOT NULL,
    phone_num varchar(20) NOT NULL unique,
    email_address varchar(50) NOT NULL unique,
	password varchar (30) NOT NULL, 
	apt_number INT check(apt_number >= 0) NOT NULL,
	street text NOT NULL,
    city varchar(50) NOT NULL,
    state varchar(50) NOT NULL,
	pincode numeric(6,0) check(pincode >= 0) NOT NULL,
    PRIMARY KEY(seller_id)
);

DROP TABLE IF EXISTS Category;
create table Category
(
	category_id INT AUTO_INCREMENT NOT NULL,
    name varchar(40) NOT NULL,
    PRIMARY KEY(category_id)
);

DROP TABLE IF EXISTS Product;
CREATE TABLE Product
(
	product_id INT AUTO_INCREMENT NOT NULL,
    name varchar(40) NOT NULL,
    price numeric(10, 2) check(Price > 0) NOT NULL,
    quantity INT check (quantity >=0) NOT NULL,
    rating tinyint check (rating >=0) NOT NULL,
    description text,
    seller_id INT NOT NULL ,
    category_id INT NOT NULL,
    PRIMARY KEY(product_id),
	FOREIGN KEY(seller_id) REFERENCES Seller(seller_id) ON DELETE CASCADE,
    FOREIGN KEY(category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Payment;
create table Payment
(
	payment_id INT AUTO_INCREMENT NOT NULL,
	payment_mode varchar(30) NOT NULL,
    PRIMARY KEY(payment_id)
);

DROP TABLE IF EXISTS DeliveryPartner;
create table DeliveryPartner
(
	deliverypartner_id INT AUTO_INCREMENT NOT NULL,
    vehicle_id varchar(30) unique NOT NULL,
    vehicle_name varchar(30) NOT NULL,
    PRIMARY KEY(deliverypartner_id)
);

DROP TABLE IF EXISTS Orders;
create table Orders
(
    order_id INT AUTO_INCREMENT NOT NULL,
    delivery_addr text NOT NULL,
    order_date TIMESTAMP NOT NULL,
    total_cost numeric(25,2) check(total_cost > 0),
    taxes numeric(25,2) check(taxes > 0),
    delivery_fee numeric (15,2) check(delivery_fee >= 0),
    customer_id INT NOT NULL ,
    payment_id INT NOT NULL,
    deliverypartner_id INT,
    PRIMARY KEY(order_id),
    FOREIGN KEY(payment_id) REFERENCES Payment(payment_id) ON DELETE CASCADE,
    FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(deliverypartner_id) REFERENCES DeliveryPartner(deliverypartner_id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS Purchased;
create table Purchased
(	
	order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
	FOREIGN KEY(order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS ShoppingCart;
create table ShoppingCart
(
	total_cost numeric(25,2) check(total_cost > 0),
    taxes numeric(25,2) check(taxes > 0),
    customer_id INT NOT NULL,
    order_id INT,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES Customer(customer_id) ON DELETE CASCADE,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id) ON DELETE SET NULL,
    FOREIGN KEY(product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Shipment;
create table Shipment
(
	delivery_date TIMESTAMP default NULL,
    delivery_status boolean NOT NULL,
    order_id INT NOT NULL,
    deliverypartner_id INT,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
	FOREIGN KEY(deliverypartner_id) REFERENCES DeliveryPartner(deliverypartner_id) ON DELETE SET NULL
);

DROP TABLE IF EXISTS Admin;
create table Admin
(
	admin_id INT NOT NULL unique,
	username varchar(50) NOT NULL unique,
    password varchar(30) NOT NULL unique
);

DROP TABLE IF EXISTS Inventory;
create table Inventory
(
	product_id INT NOT NULL,
	quantity INT check (quantity >=0) NOT NULL,
	FOREIGN KEY(product_id) REFERENCES Product(product_id) ON DELETE CASCADE
);

