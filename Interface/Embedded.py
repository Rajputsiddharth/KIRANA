import mysql.connector
from tabulate import tabulate

# Establish connection with MySQL database
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  password="siddharth@sem3",
  database="kirana"
)

# Create cursor object to execute SQL queries
mycursor = mydb.cursor()


###
# Function to add customer to the database
def add_customer():
  # Get input from user
  first_name = input("Enter first name: ")
  middle_name = input("Enter middle name: ")
  last_name = input("Enter last name: ")
  date_of_birth = input("Enter date of birth (YYYY-MM-DD): ")
  phone_num = input("Enter phone number: ")
  email_address = input("Enter email address: ")
  password = input("Enter password: ")
  apt_number =input("Enter apartment number: ")
  street = input("Enter street: ")
  city = input("Enter city: ")
  state = input("Enter state: ")
  pincode = int(input("Enter pincode: "))
  
  # Define SQL query and data values
  sql = "INSERT INTO Customer (first_name, middle_name, last_name, date_of_birth, phone_num, email_address, password, apt_number, street, city, state, pincode) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
  val = (first_name, middle_name, last_name, date_of_birth, phone_num, email_address, password, apt_number, street, city, state, pincode)

  # Execute query and commit changes
  mycursor.execute(sql, val)
  mydb.commit()

  print(mycursor.rowcount, "record inserted.")

###
# Function to add seller to the database
def add_seller():
  # prompt user to input values for attributes
  name = input("Enter seller name: ")
  phone_num = input("Enter phone number: ")
  apt_number = int(input("Enter apartment number: "))
  street = input("Enter street address: ")
  city = input("Enter city: ")
  state = input("Enter state: ")
  pincode = int(input("Enter pincode: "))

  # Define SQL query and data values
  sql = "INSERT INTO Seller (name, phone_num, apt_number, street, city, state, pincode) VALUES (%s, %s, %s, %s, %s, %s, %s)"
  val = (name, phone_num, apt_number, street, city, state, pincode)

  # Execute query and commit changes
  mycursor.execute(sql, val)
  mydb.commit()

  print(mycursor.rowcount, "record inserted.")

###
# Function to login as customer
def login_customer():
  email_address = input("Enter Email Address: ")
  password = input("Enter Password: ")
  # Embedded SQL query to verify customer login details
  sql = "SELECT * FROM Customer WHERE email_address = %s AND password = %s"
  values = (email_address, password)
  # Executing the SQL query using cursor.execute() method
  mycursor.execute(sql, values)
  # Fetching the result
  result = mycursor.fetchall()
  # Checking if the result is empty
  # Checking if the login details are correct
  if len(result) == 0:
    return False
  else:
    return True

###
# Function to login as a admin
def login_admin():
  username = input("Enter Username: ")
  password = input("Enter Password: ")
  # Embedded SQL query to verify admin login details
  sql = "SELECT * FROM Admin WHERE username = %s AND password = %s"
  values = (username, password)
  # Executing the SQL query using cursor.execute() method
  mycursor.execute(sql, values)
  # Fetching the result
  result = mycursor.fetchall()
  # Checking if the result is empty
  # Checking if the login details are correct
  if len(result) == 0:
    return False
  else:
    return True

### 
# Function to login as seller
def login_seller():
  phone_num = input("Enter Phone Number: ")
  password = input("Enter Password: ")
  # Embedded SQL query to verify seller login details
  sql = "SELECT * FROM Seller WHERE phone_num = %s AND password = %s"
  values = (phone_num, password)
  # Executing the SQL query using cursor.execute() method
  mycursor.execute(sql, values)
  # Fetching the result
  result = mycursor.fetchall()
  # Checking if the result is empty
  # Checking if the login details are correct
  if len(result) == 0:
    return False
  else:
    return True
     
###
# Function to display all customers in the database
def view_customers():
  mycursor.execute("SELECT * FROM customer")

  results = mycursor.fetchall()

  # Printing the customer details using tabulate library
  headers = ["Customer ID", "First Name", "Middle Name", "Last Name", "Date of Birth", "Phone Number", "Email Address", "Apartment Number", "Street", "City", "State", "Pincode"]
  table = tabulate(results, headers=headers, tablefmt="grid")
  print(table)


###
# Function to display all sellers in the database
def view_sellers():
    mycursor.execute("SELECT * FROM seller")

    results = mycursor.fetchall()

    for row in results:
        print(row)

###
# Function to display all categories in the database
def view_categories():
    mycursor.execute("SELECT * FROM category")

    results = mycursor.fetchall()

    for row in results:
        print(row)

###
# Function to display all products in the database
def view_products():
    mycursor.execute("SELECT * FROM product")

    results = mycursor.fetchall()

    for row in results:
        print(row)


###
# Main Function
while (True):
  print("Welcome to Kirana, One stop destination for all your needs ;)\n1) Login\n2) Sign Up\n3) Enter as Admin\n4) Exit")
  choice = int(input("Enter your choice: "))

  # Login 
  if choice == 1:
    while True:
      print("1) Login as Customer\n2) Login as Seller\n3) Go Back")
      i1 = int(input("Enter your choice: "))
      if i1 == 1:
        if login_customer():
          print("Login Successful!")
          while True:
            # print("1) View Categories\n2) View Products\n3) View Cart\n4) Add to Cart\n5) Remove from Cart\n6) Checkout\n7) Logout")
            print("1) View Categories\n2) View Products\n")
            i2 = int(input("Enter your choice: "))
            if i2 == 1:
              view_categories()
            elif i2 == 2:
              view_products()
            # elif choice == 3:
            #   #view_cart()
            # elif choice == 4:
            #   #add_to_cart()
            # elif choice == 5:
            #   #remove_from_cart()
            # elif choice == 6:
            #   #checkout()
            # elif choice == 7:
            #   break
        else:
          print("OOOPS, Login Failed!")
      elif i1 == 2: 
        if login_seller():
          print("Login Successful!")
        else:
          print("OOOPS, Login Failed!")
      elif i1 == 3:
        break


  # Sign Up
  elif choice == 2:
    while True:
      print("1) Sign Up as Customer\n2) Sign Up as Seller\n3) Go Back")
      i1 = int(input("Enter your choice: "))
      if i1 == 1:
        add_customer()
        print("Thank you for signing up!")
      elif i1 == 2:
        add_seller()
        print("Thank you for signing up!")
      elif i1 == 3:
        break
  
  # Admin Login
  elif choice == 3:
    if login_admin():
      print("Login Successful!")
      while True:
        print("1) View Customers\n2) View Sellers\n3) View Categories\n4) View Products\n5) Logout")
        i1 = int(input("Enter your choice: "))
        if i1 == 1:
          view_customers()
        elif i1 == 2:
          view_sellers()
        elif i1 == 3:
          view_categories()
        elif i1 == 4:
          view_products()
        elif i1 == 5:
          break
    else:
      print("OOOPS, Login Failed!")
  
  # Exit the application
  elif choice == 4:
    print("Thank you for using Kirana! Come back soon, we know you can't resist us ;)")
    break

