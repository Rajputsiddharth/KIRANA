# Kirana - Online Retail Store DBMS Project

This is the database schema and queries for the Kirana online retail store DBMS project created by Siddharth Rajput and Viviana Longjam.

## Project Scope

This project aims to create a web-based platform for an online retail store, "Kirana", using concepts of DBMS. The website will have a user-friendly interface for customers to purchase daily essential products, with features such as login/account creation, order history, product browsing by category, shopping cart, checkout, and return/refund processing. On the system end, developers will have access to the backend to manage the store's inventory, including adding new products and editing existing products, setting discounts and deals, managing customer accounts, and editing product categories. The project scope includes designing and developing a relational database and using SQL for data management and manipulation.

## Functional Requirements

### User Account Management:

- Allow users to create a new account with basic personal information such as name, email, address, and contact number.
- Allow users to log in using their registered email and password.
- Allow users to reset their password in case they forget it.
- Allow users to update their personal information and change their password.
- Allow users to view their order history and track the status of their current orders.

### Product Browsing and Search:

- Allow users to browse products by category.
- Allow users to search for products.
- Display product details such as name, description, images, price, and ratings.

### Shopping Cart and Checkout:

- Allow users to add products to their shopping cart.
- Allow users to add products to their wishlist or mark them as favorites.
- Allow users to view the contents of their shopping cart, change the quantity of items, and remove items.
- Allow users to checkout by providing their shipping address and selecting a delivery option.
- Allow users to track the status of their order and view their order history.
- Allow users to process returns and refunds.

### Inventory Management:

- Allow developers to add new products and edit existing products.
- Keep track of the current inventory and display if a product is out of stock.
- Update the cart of users who have added out-of-stock products.
- Keep track of available stock and balance.
- Keep track of order details.
- Allow developers to set discounts and deals on products.

### Customer Management:

- Allow developers to manage customer accounts, including viewing and processing returns and refunds.
- Store customer details, including personal information such as name, past orders, and address.
- Product categories can be edited, added, or deleted.


## Database Schema

### Customer

- `customer_id`: INT (Auto Increment, Not Null)
- `first_name`: VARCHAR(40) (Not Null)
- `middle_name`: VARCHAR(40)
- `last_name`: VARCHAR(40)
- `date_of_birth`: DATE (Not Null)
- `phone_num`: VARCHAR(20) (Not Null, Unique)
- `email_address`: VARCHAR(50) (Not Null, Unique)
- `password`: VARCHAR(30) (Not Null)
- `apt_number`: INT (Check apt_number >= 0, Not Null)
- `street`: TEXT (Not Null)
- `city`: VARCHAR(50) (Not Null)
- `state`: VARCHAR(50) (Not Null)
- `pincode`: NUMERIC(7,0) (Check pincode >= 0, Not Null)
- PRIMARY KEY: `customer_id`

### Seller

- `seller_id`: INT (Auto Increment, Not Null)
- `name`: VARCHAR(40) (Not Null)
- `phone_num`: VARCHAR(20) (Not Null, Unique)
- `email_address`: VARCHAR(50) (Not Null, Unique)
- `password`: VARCHAR(30) (Not Null)
- `apt_number`: INT (Check apt_number >= 0, Not Null)
- `street`: TEXT (Not Null)
- `city`: VARCHAR(50) (Not Null)
- `state`: VARCHAR(50) (Not Null)
- `pincode`: NUMERIC(6,0) (Check pincode >= 0, Not Null)
- PRIMARY KEY: `seller_id`

### Category

- `category_id`: INT (Auto Increment, Not Null)
- `name`: VARCHAR(40) (Not Null)
- PRIMARY KEY: `category_id`

### Product

- `product_id`: INT (Auto Increment, Not Null)
- `name`: VARCHAR(40) (Not Null)
- `price`: NUMERIC(10,2) (Check Price > 0, Not Null)
- `quantity`: INT (Check quantity >= 0, Not Null)
- `rating`: TINYINT (Check rating >= 0, Not Null)
- `description`: TEXT
- `seller_id`: INT (Not Null)
- `category_id`: INT (Not Null)
- PRIMARY KEY: `product_id`
- FOREIGN KEY: `seller_id` REFERENCES `Seller`(seller_id) ON DELETE CASCADE
- FOREIGN KEY: `category_id` REFERENCES `Category`(category_id) ON DELETE CASCADE

### Payment

- `payment_id`: INT (Auto Increment, Not Null)
- `payment_mode`: VARCHAR(30) (Not Null)
- PRIMARY KEY: `payment_id`

### DeliveryPartner

- `deliverypartner_id`: INT (Auto Increment, Not Null)
- `vehicle_id`: VARCHAR(30) (Unique, Not Null)
- `vehicle_name`: VARCHAR(30) (Not Null)
- PRIMARY KEY: `deliverypartner_id`

### Orders

- `order_id`: INT (Auto Increment, Not Null)
- `delivery_addr`: TEXT (Not Null)
- `order_date`: TIMESTAMP (Not Null)
- `total_cost`: NUMERIC(25,2) (Check total_cost > 0)
- `taxes`: NUMERIC(25,2) (Check taxes > 0)
- `delivery_fee`: NUMERIC(15,2) (Check delivery_fee >= 0)
- `customer_id`: INT (Not Null)
- `payment_id`: INT (Not Null)
- `deliverypartner_id`: INT
- PRIMARY KEY: `order_id`
- FOREIGN KEY: `payment_id` REFERENCES `Payment`(payment_id) ON DELETE CASCADE
- FOREIGN KEY: `customer_id` REFERENCES `Customer`(customer_id) ON DELETE CASCADE
- FOREIGN KEY: `deliverypartner_id` REFERENCES `DeliveryPartner`(deliverypartner_id) ON DELETE SET NULL

### Purchased

- `order_id`: INT (Not Null)
- `product_id`: INT (Not Null)
- `quantity`: INT (Not Null)
- FOREIGN KEY: `order_id` REFERENCES `Orders`(order_id) ON DELETE CASCADE
- FOREIGN KEY: `product_id` REFERENCES `Product`(product_id) ON DELETE CASCADE

### ShoppingCart

- `total_cost`: NUMERIC(25,2) (Check total_cost > 0)
- `taxes`: NUMERIC(25,2) (Check taxes > 0)
- `customer_id`: INT (Not Null)
- `order_id`: INT
- `product_id`: INT (Not Null)
- `quantity`: INT (Not Null)
- FOREIGN KEY: `customer_id` REFERENCES `Customer`(customer_id) ON DELETE CASCADE
- FOREIGN KEY: `order_id` REFERENCES `Orders`(order_id) ON DELETE SET NULL
- FOREIGN KEY: `product_id` REFERENCES `Product`(product_id) ON DELETE CASCADE

### Shipment

- `delivery_date`: TIMESTAMP (Default NULL)
- `delivery_status`: BOOLEAN (Not Null)
- `order_id`: INT (Not Null)
- `deliverypartner_id`: INT
- FOREIGN KEY: `order_id` REFERENCES `Orders`(order_id) ON DELETE CASCADE
- FOREIGN KEY: `deliverypartner_id` REFERENCES `DeliveryPartner`(deliverypartner_id) ON DELETE SET NULL

### Admin

- `admin_id`: INT (Not Null, Unique)
- `username`: VARCHAR(50) (Not Null, Unique)
- `password`: VARCHAR(30) (Not Null, Unique)

### Inventory

- `product_id`: INT (Not Null)
- `quantity`: INT (Check quantity >= 0, Not Null)
- FOREIGN KEY: `product_id` REFERENCES `Product`(product_id) ON DELETE CASCADE
