-- DROP DATABASE SecondHandStore;
CREATE DATABASE SecondHandStore;
USE  SecondHandStore;

CREATE TABLE Author(
  Author_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Author_Name VARCHAR(45) NOT NULL,
  PRIMARY KEY (Author_id)
  );
  
  CREATE TABLE Publisher(
  Publisher_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Publisher_Name VARCHAR(45) NOT NULL,
  PRIMARY KEY (Publisher_id)
  ); 

  CREATE TABLE Translation(
  Translation_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Book_Language VARCHAR(45) NOT NULL,
  PRIMARY KEY (Translation_id)
);

CREATE TABLE Book(
  Book_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Book_Name VARCHAR(45) NOT NULL,
  Title VARCHAR(45) NOT NULL,
  Weight DECIMAL(10,2) UNSIGNED NOT NULL,
  Book_Condition VARCHAR(45) NULL,
  Pages SMALLINT(4) UNSIGNED NOT NULL,
  PRIMARY KEY (Book_id)
 );
 
 CREATE TABLE Book_Copy(
  Copy_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Book_id SMALLINT(15) UNSIGNED NOT NULL,
  Translation_id SMALLINT(15) UNSIGNED NOT NULL ,
  Author_id SMALLINT(15) UNSIGNED NOT NULL,
  Publisher_id SMALLINT(15) UNSIGNED NOT NULL,
  Publishing_Year SMALLINT(4)  NOT NULL,
  PRIMARY KEY (Copy_id)
 );
 
 CREATE TABLE Customer(
  Customer_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  First_Name VARCHAR(45) NOT NULL,
  Last_Name VARCHAR(45) NOT NULL,
  Cellphone VARCHAR(10) NOT NULL,
  Landine VARCHAR(9),
  Sign_Up_Date DATETIME NOT NULL,
  UNIQUE INDEX Cellphone_UNIQUE (Cellphone ASC) VISIBLE,
  PRIMARY KEY (Customer_id)
  );
  
  -- Purchase_Type : Closing Store , Customer
  
CREATE TABLE Purchasing(
  Purchase_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Purchase_Type  VARCHAR(25),
  Total_Price DECIMAL(15,2) UNSIGNED NOT NULL,
  Purchasing_Date DATETIME NOT NULL,
  PRIMARY KEY (Purchase_id)
  );
  
CREATE TABLE Purchasing_Detail (
  Purchase_id SMALLINT(15) UNSIGNED NOT NULL,
  Copy_id SMALLINT(15) UNSIGNED NOT NULL,
  Inventory_id SMALLINT(15) UNSIGNED NOT NULL,
  Customer_id SMALLINT(15) UNSIGNED NOT NULL,
  Amount SMALLINT(15) UNSIGNED NOT NULL,
  Price_Per_one DECIMAL(20,2) UNSIGNED NOT NULL
  );
  

CREATE TABLE Inventory(
  Inventory_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Copy_id SMALLINT(15) UNSIGNED NOT NULL,
  Inventory_Type_id SMALLINT(15) UNSIGNED NOT NULL,
  Stored_Date DATETIME NOT NULL,
  Last_Action_Date  DATETIME NOT NULL,
  Amount_Change SMALLINT(15) NOT NULL,
  New_Amount SMALLINT(15) UNSIGNED NOT NULL,
  purchase_cost DECIMAL(20,2) UNSIGNED NOT NULL,
  Stored_Location VARCHAR(45) NOT NULL,
  Sequence SMALLINT(15),
  PRIMARY KEY (Inventory_id)
  );
 
 CREATE TABLE Inventory_Action(
  Inventory_Type_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Purchase_id SMALLINT(15) UNSIGNED NOT NULL,
  Order_id SMALLINT(15) UNSIGNED NOT NULL,
  Deal_id SMALLINT(15) UNSIGNED NOT NULL,
  Last_Action VARCHAR(20) NOT NULL,
  PRIMARY KEY (Inventory_Type_id)
);
 

CREATE TABLE Store_Worker(
  Worker_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  First_Name VARCHAR(45) NOT NULL,
  Last_Name VARCHAR(45) NULL,
  Address VARCHAR(100) NOT NULL,
  Phone VARCHAR(10) NOT NULL,
  Start_Date DATETIME NOT NULL,
  End_Date DATETIME NOT NULL,
  Hourly_Salary DECIMAL(15,2) UNSIGNED NOT NULL,
  Is_Manager TINYINT(1) NOT NULL,
  User_id VARCHAR(45) NOT NULL,
  User_Password VARCHAR(45) NOT NULL,
  PRIMARY KEY (Worker_id),
  UNIQUE INDEX Phone_UNIQUE (Phone ASC) VISIBLE);

CREATE TABLE Summery_Worker(
  Worker_id SMALLINT(10) UNSIGNED NOT NULL,
  Hours DECIMAL(10) UNSIGNED NOT NULL,
  Month_val SMALLINT(2) UNSIGNED NOT NULL,
  Year_val SMALLINT(4) UNSIGNED NOT NULL
 );

CREATE TABLE Shop_Expenses (
  Expenses_id SMALLINT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  Water DECIMAL(15,2) UNSIGNED NOT NULL,
  Landline DECIMAL(15,2) UNSIGNED,
  Telephone DECIMAL(15,2) UNSIGNED NOT NULL,
  Tax DECIMAL(15) UNSIGNED NOT NULL,
  Electricity DECIMAL(15,2) UNSIGNED NOT NULL,
  Rent DECIMAL(15,2) UNSIGNED NOT NULL,
  Delivery_Total DECIMAL(15,2) UNSIGNED NOT NULL,
  Worker_Payment_Total DECIMAL(15,2) UNSIGNED NOT NULL,
  Other DECIMAL(15,2) UNSIGNED,
  PRIMARY KEY (Expenses_id)
  );
  
  CREATE TABLE Annual_Summery (
  Expenses_id SMALLINT(15) UNSIGNED NOT NULL,
  Total_Expense DECIMAL(15,2) NOT NULL,
  Month_val SMALLINT(2) UNSIGNED NOT NULL,
  Year_val SMALLINT(4) UNSIGNED NOT NULL
  );
  
CREATE TABLE Deal(
  Deal_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Total_Cost DECIMAL(15,2) UNSIGNED NOT NULL,
  Pay_Option VARCHAR(45) NOT NULL,
  Is_Delivery TINYINT NOT NULL,
  Deal_Date DATETIME NOT NULL,
  Customer_id SMALLINT(15) UNSIGNED NOT NULL,
  Worker_id SMALLINT(15) UNSIGNED NOT NULL,
  PRIMARY KEY (Deal_id)
  );
  
  CREATE TABLE Deal_Details (
  Deal_id SMALLINT(15) UNSIGNED NOT NULL,
  Copy_id SMALLINT(15) UNSIGNED NOT NULL,
  Sell_Price DECIMAL(15,2) UNSIGNED NOT NULL,
  Amount SMALLINT(15) UNSIGNED NOT NULL,
  Inventory_Type_id SMALLINT(15) UNSIGNED NOT NULL
  -- Purchasing_Price DECIMAL(15,2) UNSIGNED NOT NULL
  );
  
  
CREATE TABLE Store_Order (
  Order_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Customer_id SMALLINT(15) UNSIGNED NOT NULL,
  Copy_id SMALLINT(15) UNSIGNED NOT NULL,
  Inventory_Type_id SMALLINT(15) UNSIGNED NOT NULL,
  Amount SMALLINT(15) UNSIGNED NOT NULL,
  Order_Date DATETIME NOT NULL,
  Order_Status VARCHAR(45) NOT NULL,
  PRIMARY KEY (Order_id)
  );
  
CREATE TABLE Delivery_Type(
  Type_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Sub_Type VARCHAR(45) NOT NULL,
  Cost DECIMAL(15,2) UNSIGNED NOT NULL,
  Type_Delivery VARCHAR(45) NOT NULL,
  PRIMARY KEY (Type_id)
  );
  
  
CREATE TABLE Delivery(
  Deliver_id SMALLINT(15) UNSIGNED NOT NULL AUTO_INCREMENT,
  Deal_id SMALLINT(15) UNSIGNED NOT NULL,
  Customer_id SMALLINT(15) UNSIGNED NOT NULL,
  Type_id SMALLINT(15) UNSIGNED NOT NULL,
  Status_Delivery VARCHAR(45) NOT NULL,
  Address VARCHAR(45) NOT NULL,
  Start_Date DATETIME NOT NULL,
  End_Date DATETIME NOT NULL,
  Is_Deal_Complete TINYINT NOT NULL,
  PRIMARY KEY (Deliver_id)
);

CREATE TABLE Delivery_Detail(
	Deliver_id SMALLINT(15) UNSIGNED NOT NULL,
	Copy_id SMALLINT(15) UNSIGNED NOT NULL,
	Weight DECIMAL(15,2) UNSIGNED NOT NULL,
	Amount SMALLINT(15) UNSIGNED NOT NULL
);
  
  
-- ---------------------------------
-- INSERT Values
-- ---------------------------------

INSERT INTO Author (Author_Name)
VALUES ("Daniel Silvan"), ("Judi Pico"), ("Harlen Coban"), ("Ram Oren"),  ("Halen Huseny"),
	   ("Gabi Nirzan"), ("J K Rolling"), ("Benny Goren"), ("Yohel Geva"), ("Henery Bill");


INSERT INTO Translation (Book_Language)
VALUES ("Hebrew"), ("English"), ("Spanish"), ("German"), ("Russian"), ("Arab"); 


INSERT INTO Publisher (Publisher_Name)
VALUES ("Keter"), ("Modan"), ("Yediot Aharonot"), ("Meter"), ("Dvash"), ("Am Oved"), ("Kineret");


-- Book_Condition - Brand new, as new, good, medium, dilapidated 

INSERT INTO Book (Book_Name, Title, Weight, Book_Condition, Pages)
VALUES ("Dangerous trap", "thriller", 2.2, "Brand new", 321),
	   ("Badolina", "thriller", 2.2, "Brand new", 321),
	   ("Rose Efect", "Roman", 2.2, "Brand new", 321),
       ("Rich Father Poor Father", "Business", 2.2, "Brand new", 200),
       ("My sister Guard", "Comedy", 1.6, "dilapidated", 125),
       ("De Vin Chi Code", "thriller", 3.5, "dilapidated", 456),
       ("Do not leave", "thriller", 2.2, "medium", 321),
       ("Harry Potter 1", "fantasy", 2.2, "medium", 321),
       ("Harry Potter 2", "fantasy", 2.2, "as new", 322),
       ("Harry Potter 3", "fantasy", 2.2, "as new", 323),
       ("Abaldarit", "thriller", 2.2, "good", 321),
       ("Vertigo", "thriller", 2.2, "good", 321),
       ("Math 5 point", "Learning", 3.4, "Brand new", 321);

 
INSERT INTO Book_Copy (Book_id, Publisher_id, Author_id ,Translation_id, Publishing_Year)
VALUES  (1, 1 ,1 , 1, 2000), (1, 2 ,1 , 1, 2001), (1, 1 ,3 , 1, 2002), (1, 1 ,1 , 4, 2003), (1, 1 ,2 , 1, 2004), (1, 2 ,1 , 5, 2005),
		(2, 2 ,2 , 2, 2000), (2, 2 ,1 , 1, 2001), (2, 3 ,3 , 3, 2002), (1, 1 ,1 , 4, 2003), (1, 1 ,7 , 1, 2004), (1, 2 ,6 , 5, 2005),
		(3, 3 ,3 , 3, 2000), (3, 3 ,3 ,5 , 2001), (4, 3 ,3 , 3, 2002), (3, 5 ,2 , 4, 2003), (1, 1 ,2 , 4, 2004), (1, 2 ,5 , 5, 2005),
		(2, 1 ,6 , 1, 2000), (3, 2 ,1 , 1, 2001), (4, 1 ,3 , 1, 2002), (5, 1 ,1 , 4, 2003), (6, 1 ,2 , 1, 2004), (7, 2 ,1 , 5, 2005),
		(8, 5 ,5 , 5, 2000), (9, 7 ,7 , 4, 2001), (10, 6 ,6 , 6, 2002), (11, 1 ,1 , 4, 2003), (12, 1 ,2 , 1, 2004), (13, 2 ,1 , 5, 2005);


INSERT INTO Customer (First_Name, Last_Name, Cellphone, Landine, Sign_Up_Date)
VALUES  ("None", "None" , 0, 0, "2020-01-01"),
		("Daniel", "Model" , 0507939887, 035749494, "2019-09-13"), 
		("Anar", "Djafarov" , 0544886618, 037584736, "2020-06-21"),
		("Omri", "Haham" , 0526999779, 072093847, "2019-02-04"),
		("Aviram", "Shemesh" , 0527247877, 049482674, "2018-07-29"),
		("Lucas", "Argentini" , 0586753353, 048213123, "2019-08-17"),
		("Inbal", "Model" , 0501112221, 085785794, "2019-09-13"), 
		("Halel", "Sarusi" , 0507483622, 069102854, "2018-12-11"), 
		("Ariel", "Lunenfeld" , 0522222222, 031111111, "2019-10-19"), 
		("Beni", "Benyamin" , 0536040300, 036040300, "2020-04-04"), 
		("Ilana", "Shapiro" , 05356789009, 041487533, "2020-05-29");


-- Purchase_Type : Closing Store , Customer
INSERT INTO Purchasing (Purchase_Type , Total_Price, Purchasing_Date)
VALUES  ("Closing Store", 200 , "2020-07-25"),
		("Closing Store", 200 , "2020-07-25"),
		("Closing Store", 200 , "2020-07-25"),
		("Customer", 200 , "2020-07-25"),
		("Customer", 200 , "2020-07-25"),
		("Customer", 200 , "2020-07-25");
	

-- customer_id = 0 : Byuing from "Closing Store"
INSERT INTO Purchasing_Detail (Purchase_id, Copy_id, Inventory_id, Customer_id, Amount, Price_Per_one )
VALUES  (1, 1, 1, 1, 30, 10), (1, 2, 2, 1, 30, 12), (1, 3, 3, 1, 30, 13), (1, 4, 4, 1, 30, 14), (1, 5, 5, 1, 30, 15),
		(2, 6, 6, 1, 30, 16), (2, 7, 7, 1, 30, 15), (2, 8, 8, 1, 30, 14), (3, 9, 9, 1, 30, 12), (3, 10, 10, 1, 30, 10),
		(4, 11, 11, 2, 30, 12),
		(4, 12, 12, 2, 30, 10),
		(4, 13, 13, 2, 30, 18),
		(4, 20, 14, 2, 30, 20),
		(5, 14, 15, 3, 30, 10),
		(5, 15, 16, 3, 30, 11),
		(5, 16, 17, 3, 30, 12),
		(6, 17, 18, 4, 30, 14),
		(6, 18, 19, 4, 30, 6);


INSERT INTO Inventory_Action (Purchase_id, Order_id, Deal_id, Last_Action)
VALUES 	(0, 0, 1, "Sell"), (0, 1, 0, "Order_Complete"),(1, 0, 0, "Purchase");
 

-- Last_Action: Purchase, Sell, Complete Order
-- Stored_Date = Purchase_Date or 
-- Stored_Location : Store, Stock
INSERT INTO Inventory (Copy_id, Inventory_Type_id, Stored_Date, Last_Action_Date, Amount_Change, New_Amount, purchase_cost, Stored_Location, Sequence )
VALUES  (1, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(2, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(3, 1,"2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(4, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(5, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(6, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(7, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(8, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(9, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(10, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(11, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(12, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(13, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(14, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Store", 1),
		(15, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Stock", 1),
		(16, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Stock", 1),
		(17, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Stock", 1),
		(18, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Stock", 1),
		(20, 1, "2020-07-25", "2020-07-25", 30, 30, 25, "Stock", 1),
		(21, 1, "2020-07-25", "2020-08-02", 30, 30, 25, "Stock", 1);


INSERT INTO Store_Worker (First_Name, Last_Name, Address, Phone , Start_Date, End_Date, Hourly_Salary, Is_Manager, User_id, User_Password)
VALUES ("Britni", "Spirs", "Tel Aviv", 0541344678, "2018-03-20", "2025-12-12", 50,  1, "12345", "Britni123"),
		("Jhonatan", "Cubani", "Haifa", 0512345691, "2019-04-20", "2025-12-12", 30,  0, "23456", "Jhonatan"),
        ("Daniel", "Modilevsky", "Jerusalem", 0514345666, "2020-01-21", "2025-12-12", 35,  0, "34578", "Daniel123"),
        ("Anar", "Djafarov", "Jerusalem", 0522345655, "2018-11-22", "2025-12-12", 40,  0, "45678", "Anar1234"),
        ("Yaniv", "Zlotnik", "Metula", 0532545644, "2020-12-23", "2025-12-12", 35,  0, "56789", "Yaniv123"),
        ("Omri", "Haham", "Metula", 0542345633, "2019-07-24", "2025-12-12", 37,  0, "98765", "Omri1234"),
        ("Daniel", "Machloof", "Ramat Gan", 0552345622, "2018-07-25", "2025-12-12", 41,  0, "87654", "Machloof"),
        ("Irad", "Keren", "Ramat Gan", 0525345611, "2020-08-26", "2025-12-12", 35,  0, "76543", "Irad1234"),
        ("Muhamad", "Kadafi", "Ashdod", 0514345600, "2019-09-13", "2025-12-12", 38,  0, "65432", "Muhamad1"),
        ("Mick", "Tyson", "Ashdod", 0562845634, "2020-10-09", "2025-12-12", 33,  0, "54321", "Mick1234");

INSERT INTO Summery_Worker (Worker_id, Hours, Month_val, Year_val)
VALUES (1, 120 , 2 , 2020), (2, 140 , 2 , 2020), (3, 160 , 2 , 2020), (4, 180 , 2 , 2020), (5, 200 , 2 , 2020),
	   (1, 200 , 3 , 2020), (2, 180 , 3 , 2020), (3, 150 , 3 , 2020), (4, 110 , 3 , 2020), (5, 130 , 3 , 2020);


INSERT INTO Shop_Expenses (Water, Landline, Telephone, Tax, Electricity, Rent, Delivery_Total, Worker_Payment_Total , Other )
VALUES (200, 200 , 200 , 200, 200, 200 , 1000, 20000, 0), 
       (100, 100 , 100 , 100, 100, 100 , 1000, 19000, 0),
	   (300, 300 , 300 , 300, 300, 300 , 1000, 18000, 0),
	   (400, 400 , 400 , 400, 400, 400 , 1000, 17000, 100),
       (500, 500 , 500 , 500, 500, 500 , 1000, 16000, 0),
       (200, 200 , 200 , 200, 200, 200 , 1000, 15000, 0),
       (200, 200 , 400 , 200, 200, 400 , 1000, 14000, 0),
       (200, 400 , 200 , 200, 400, 200 , 1000, 13000, 0),
       (300, 300 , 300 , 300, 300, 300 , 1000, 12000, 0),
       (500, 500 , 500 , 500, 500, 500 , 1000, 11000, 0);


INSERT INTO Annual_Summery (Expenses_id, Total_Expense, Month_val, Year_val)
VALUES 	(1, 120067, 03 , 2020),
		(2, 167254, 08 , 2017),
		(3, 182990, 11 , 2014),
		(4, 102222, 12 , 2006),
		(5, 123321, 01 , 1997),
		(6, 98000, 04 , 2001),
		(7, 164223, 09 , 2019),
		(8, 129678, 02 , 2015),
		(9, 345543, 02 , 2012),
		(10, 456654, 01 , 2008);
        

INSERT INTO Deal (Total_Cost, Pay_Option, Is_Delivery, Deal_Date, Customer_id, Worker_id )
VALUES (200, "Credit" , 1, "2020-07-25", 3, 2 ),
	   (200, "Credit" , 1, "2020-07-25", 4, 2 ),
	   (200, "Credit" , 1, "2020-07-25", 2, 2 ),
	   (200, "bank transfer" , 1, "2020-07-24", 2, 3 ),
	   (200, "bank transfer" , 1, "2020-07-24", 5, 3 ),
	   (200, "bank transfer" , 1, "2020-07-24", 6, 3 ),
	   (200, "Bit" , 1, "2020-07-21", 7, 4 ),
	   (200, "Bit" , 0, "2020-07-24", 8, 4 ),
	   (200, "Bit" , 0, "2020-07-22", 3, 5 ),
	   (200, "Bit" , 1, "2020-07-23",2 ,5 ),
	   (200, "Bit" , 1, "2020-06-20",2 ,5 );



INSERT INTO Deal_Details (Deal_id, Copy_id, Sell_Price, Amount, Inventory_Type_id )
VALUES (1, 2 , 45 , 10, 1),
	   (1, 1 , 45 , 10, 1),
	   (2, 3 , 45 , 10, 1),
	   (2, 8 , 45 , 10, 1),
	   (3, 4 , 45 , 10, 1),
	   (3, 5 , 45 , 10, 1),
	   (3, 2 , 45 , 10, 1),
	   (4, 3 , 45 , 10, 1),
	   (5, 6 , 45 , 10, 1),
	   (5, 7 , 45 , 10, 1);


-- Order_Status - Waiting , in_Storge, Complete 
INSERT INTO Store_Order (Customer_id, Copy_id, Inventory_Type_id, Amount, Order_Date, Order_Status)
VALUES (6, 19 , 3 , 10, "2020-07-27", "Waiting"),
	   (2, 15 , 3 , 10, "2020-07-27", "in_Storge"),
	   (3, 16 , 3 , 10, "2020-07-27", "in_Storge"),
	   (4, 10, 3 , 10, "2020-07-27", "Complete"),
	   (5, 11 , 3 , 10, "2020-07-27", "Complete");


-- Type_Delivery : Israel_Post, Courier_Company
-- Sub_Type 	 : Registered, Courier, Fast_Courier // Collection_Point, Courier_Home
INSERT INTO Delivery_Type (Sub_Type, Cost, Type_Delivery )
VALUES ( "Collection_Point", 1.5 , "Courier_Company Xpress"),
	   ( "Courier_Home", 2 , "Courier_Company Xpress"),
	   ( "Fast_Courier", 3 , "Israel_Post"),
	   ( "Courier", 2.5 , "Israel_Post"),
	   ( "Registered", 3.5 , "Israel_Post");
       

-- Status_Delivery : In_Preparation, Shipped, Arrived, Awaiting_Collection, Delivered
INSERT INTO Delivery (Deal_id, Customer_id, Type_id, Status_Delivery, Address, Start_Date, End_Date, Is_Deal_Complete )
VALUES ( 1, 3 , 1, "In_Preparation", "Shenkar","2020-02-21", "2020-02-22", 0 ),
	   ( 1, 3 , 2, "Delivered", "Shenkar","2020-02-21", "2020-02-22", 1 ),
	   ( 2, 4 , 3, "In_Preparation", "Shenkar","2020-02-21", "2020-02-22", 0 ),
	   ( 3, 2 , 4, "Awaiting_Collection", "Shenkar","2020-02-21", "2020-02-22", 0 ),
	   ( 4, 2 , 5, "Shipped", "Shenkar","2020-02-21", "2020-02-22", 0 ),
	   ( 5, 5 , 4, "Arrived", "Shenkar","2020-02-21", "2020-02-22", 0 ),
	   ( 5, 5 , 4, "Awaiting_Collection", "Shenkar","2020-02-21", "2020-02-22", 0 );
	 
       

INSERT INTO Delivery_Detail (Deliver_id, Copy_id, Weight, Amount)
VALUES ( 1, 1 , 3, 3 ),
	   ( 1, 2 , 4, 4 ),
	   ( 2, 3 , 5, 4 ),
	   ( 2, 6 , 6, 1 ),
	   ( 3, 4 , 6, 9 ),
	   ( 3, 5 , 7, 38 ),
	   ( 3, 2 , 8, 7 ),
	   ( 4, 3 , 3, 6 ),
	   ( 5, 6 , 2, 3 ),
	   ( 5, 7 , 1, 5 );


-- ---------------------------------
-- Add Forign Key
-- ---------------------------------

ALTER TABLE Book_Copy
ADD INDEX Translation_idx (Translation_id ASC) VISIBLE,
ADD INDEX Author_idx (Author_id ASC) VISIBLE,
ADD INDEX Publisher_idx (Publisher_id ASC) VISIBLE,
ADD INDEX Book_idx (Book_id ASC) VISIBLE,
ADD FOREIGN KEY (Translation_id) REFERENCES Translation(Translation_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Author_id) REFERENCES Author(Author_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Publisher_id) REFERENCES Publisher(Publisher_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Book_id) REFERENCES Book(Book_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Purchasing_Detail
ADD INDEX Purchase_idx (Purchase_id ASC) VISIBLE,
ADD INDEX Copy_idx (Copy_id ASC) VISIBLE,
ADD INDEX Inventory_idx (Inventory_id ASC) VISIBLE,
ADD INDEX Customer_idx (Customer_id ASC) VISIBLE,
ADD FOREIGN KEY (Purchase_id) REFERENCES Purchasing(Purchase_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Copy_id) REFERENCES Book_Copy(Copy_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Inventory_id) REFERENCES Inventory(Inventory_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE ON UPDATE CASCADE;



ALTER TABLE Inventory
ADD INDEX Copy_id_idx (Copy_id ASC) VISIBLE,
ADD INDEX Inventory_Type_id_idx (Inventory_Type_id ASC) VISIBLE,
ADD FOREIGN KEY (Copy_id) REFERENCES Book_Copy(Copy_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Inventory_Type_id) REFERENCES Inventory_Action(Inventory_Type_id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE Summery_Worker
ADD INDEX Worker_id_idx (Worker_id ASC) VISIBLE,
ADD FOREIGN KEY (Worker_id) REFERENCES Store_Worker(Worker_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Annual_Summery
ADD INDEX Expenses_id_idx (Expenses_id ASC) VISIBLE,
ADD FOREIGN KEY (Expenses_id) REFERENCES Shop_Expenses(Expenses_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Deal
ADD INDEX Customer_id_idx (Customer_id ASC) VISIBLE,
ADD INDEX Worker_id_idx (Worker_id ASC) VISIBLE,
ADD FOREIGN KEY (Worker_id) REFERENCES Store_Worker(Worker_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Deal_Details
ADD INDEX Inventory_Type_id_idx (Inventory_Type_id ASC) VISIBLE,
ADD INDEX Copy_idx (Copy_id ASC) VISIBLE,
ADD INDEX Deal_id_idx (Deal_id ASC) VISIBLE,
ADD FOREIGN KEY (Deal_id) REFERENCES Deal(Deal_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Inventory_Type_id) REFERENCES Inventory_Action(Inventory_Type_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Copy_id) REFERENCES Book_Copy(Copy_id) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE Store_Order
ADD INDEX Inventory_Type_id_idx (Inventory_Type_id ASC) VISIBLE,
ADD INDEX Copy_idx (Copy_id ASC) VISIBLE,
ADD INDEX Customer_id_idx (Customer_id ASC) VISIBLE,
ADD FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Inventory_Type_id) REFERENCES Inventory_Action(Inventory_Type_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Copy_id) REFERENCES Book_Copy(Copy_id) ON DELETE CASCADE ON UPDATE CASCADE;


 ALTER TABLE Delivery
ADD INDEX Type_id_idx (Deliver_id ASC) VISIBLE,
ADD INDEX Deal_id_idx (Deal_id ASC) VISIBLE,
ADD INDEX Customer_id_idx (Customer_id ASC) VISIBLE,
ADD FOREIGN KEY (Type_id) REFERENCES Delivery_Type(Type_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Deal_id) REFERENCES Deal(Deal_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Customer_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE ON UPDATE CASCADE;


 ALTER TABLE Delivery_Detail
ADD INDEX Deliver_id_idx (Deliver_id ASC) VISIBLE,
ADD INDEX Copy_id_idx (Copy_id ASC) VISIBLE,
ADD FOREIGN KEY (Deliver_id) REFERENCES Delivery(Deliver_id) ON DELETE CASCADE ON UPDATE CASCADE,
ADD FOREIGN KEY (Copy_id) REFERENCES Book_Copy(Copy_id) ON DELETE CASCADE ON UPDATE CASCADE;

-- ====================================  
  -- Update -- 
-- ====================================

-- deal
UPDATE inventory i SET i.Amount_Change = -20 ,i.New_Amount = 10, i.Last_Action_Date = "2020-07-25"   WHERE i.Copy_id = 1;
UPDATE inventory i SET i.Amount_Change = -10 ,i.New_Amount = 20, i.Last_Action_Date = "2020-07-25"   WHERE i.Copy_id = 2;
UPDATE inventory i SET i.Amount_Change = -30 ,i.New_Amount = 0, i.Last_Action_Date = "2020-07-24"   WHERE i.Copy_id = 3;
UPDATE inventory i SET i.Amount_Change = -10 ,i.New_Amount = 20, i.Last_Action_Date = "2020-07-25"   WHERE i.Copy_id = 4;
UPDATE inventory i SET i.Amount_Change = -10 ,i.New_Amount = 20, i.Last_Action_Date = "2020-07-25"   WHERE i.Copy_id = 5;
UPDATE inventory i SET i.Amount_Change = -10 ,i.New_Amount = 20, i.Last_Action_Date = "2020-07-25"   WHERE i.Copy_id = 6;
UPDATE inventory i SET i.Amount_Change = -10 ,i.New_Amount = 20, i.Last_Action_Date = "2020-07-25"   WHERE i.Copy_id = 7;

-- order
UPDATE inventory i SET i.Amount_Change = -10 ,i.New_Amount = 20, i.Last_Action_Date = "2020-07-26", i.Stored_Location = "Store"   WHERE i.Copy_id = 15;
UPDATE inventory i SET i.Amount_Change = -10 ,i.New_Amount = 20, i.Last_Action_Date = "2020-07-26", i.Stored_Location = "Store"   WHERE i.Copy_id = 16;


-- ====================================  
  -- Questions -- 
-- ====================================

-- 0 --
select * from Book_Copy BC
inner join book b on b.Book_id and BC.Book_id 
inner join author a on a.Author_id and BC.Author_id
inner join publisher p on p.Publisher_id and BC.Publisher_id
inner join translation t on t.Translation_id and BC.Translation_id
where BC.Book_id = b.Book_id 
and BC.Author_id = a.Author_id
and BC.Publisher_id = p.Publisher_id
and BC.Translation_id = t.Translation_id;


-- 1 --
Select b.Book_Name , i.New_Amount as Amount, i.Stored_Location from Inventory i
inner join Book_Copy BC on BC.Book_id = i.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
where b.Book_Name = "Badolina"
group by i.Sequence;

-- 2 --
Select * from Customer c
order by c.Sign_Up_Date
limit 1;

-- 3 --
select i.Copy_id, i.Stored_Date, b.Book_Name from Inventory i 
inner join Book_Copy BC on BC.Book_id = i.Copy_id 
inner join book b on b.Book_id = BC.Book_id order by i.Stored_Date 
limit 1;

-- 4 --
select * from Store_Order SO
where Order_Status != "Complete"
order by SO.Order_Date;


-- 5 --
select sum(dd.Amount) as NUm_Of_Books from Deal d
inner join Deal_Details dd on d.Deal_id = dd.Deal_id
inner join Book_Copy BC on BC.Book_id = dd.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
where b.Book_Name = "Badolina"
group by dd.Amount;

-- 6 --
select sum(dd.Amount) as Selling_Books , a.Author_Name from Deal d
inner join Deal_Details dd on d.Deal_id = dd.Deal_id
inner join Book_Copy BC on dd.Copy_id = BC.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
inner join author a on a.Author_id = BC.Author_id
where d.Deal_Date >= "2000-01-01" AND d.Deal_Date <= "2021-01-01"
group by A.Author_Name
order by sum(dd.Amount) DESC
LIMIT 1;


-- 7 -- 
select sum(dd.Amount) as Buing_Books, CONCAT(c.First_Name, " ", c.Last_Name ) as Customer_Name from Deal d
inner join Deal_Details dd on d.Deal_id = dd.Deal_id
inner join Book_Copy BC on dd.Copy_id = BC.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
inner join customer c on d.customer_id = c.customer_id
group by d.Customer_id
order by count(d.customer_id) DESC
limit 3;


-- 8 -- מי הוא הספר עם מספר התרגומים הגדול ביותר שקיים כרגע במלאי
select count(distinct(BC.Translation_id)) Translation_Num, b.Book_Name from Inventory i 
inner join Book_Copy BC on i.Copy_id = BC.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
inner join translation t on t.Translation_id = BC.Translation_id
group by b.Book_id
order by count(distinct(BC.Translation_id)) DESC
limit 1;

-- 9 --
select CONCAT(c.First_Name, " ", c.Last_Name ) as Customer_Name  , b.book_name, dd.sell_price, d.Deal_Date from Deal d
inner join Deal_Details dd on d.Deal_id = dd.Deal_id
inner join Book_Copy BC on dd.Copy_id = BC.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
inner join customer c on d.customer_id = c.customer_id
where c.First_Name = "Daniel" And c.Last_Name = "Model"
order by d.Deal_Date;

-- 10 -- 
select CONCAT(c.First_Name, " ", c.Last_Name ) as Customer_Name, SO.Order_Date, b.Book_Name, b.Title, b.Book_Condition, SO.Amount, So.Order_Status  from Store_Order SO
inner join Book_Copy BC on SO.Copy_id = BC.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
inner join customer c on SO.customer_id = c.customer_id
where c.First_Name = "Daniel" And c.Last_Name = "Model"
order by SO.Order_Date;

-- 11 -- 
select d.Deliver_id, sum(Amount * dd.Weight *  dt.Cost) as Delivery_Price, CONCAT(c.First_Name, " ", c.Last_Name ) as Customer_Name   from delivery d
inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id 
inner join Delivery_Type dt on d.Type_id = dt.type_id
inner join customer c on d.customer_id = c.customer_id
group by d.Deliver_id;

-- 12 -- 
select * from delivery d
inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id 
inner join Delivery_Type dt on d.Type_id = dt.type_id
inner join customer c on d.customer_id = c.customer_id
where d.Deal_id = c.First_Name = "Anar" and c.Last_Name = "Djafarov";

-- 13 -- 
select d.Deliver_id, d.Status_Delivery from delivery d
inner join Delivery_Type dt on d.Type_id = dt.type_id
inner join customer c on d.customer_id = c.customer_id
where d.Deliver_id = 1;

-- 14 -- 
select sum(Amount * dd.Weight *  dt.Cost) as Delivery_Price , dt.Type_Delivery   from delivery d
inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id 
inner join Delivery_Type dt on d.Type_id = dt.type_id
inner join customer c on d.customer_id = c.customer_id
where d.Start_Date >= "2020-02-01" AND d.Start_Date <= "2020-03-01"
and dt.Type_Delivery = "Courier_Company xpress"
group by dt.Type_Delivery;


-- 15 -- סך הכסף שהועבר לחשבון החנות באמצעות אפליקציית Bit מסוים בחודש
select Sum(d.Total_Cost) as Total_Cost , d.Pay_Option from Deal d
where d.Pay_Option = "bit"
and d.Deal_Date >= "2020-07-01" AND d.Deal_Date <= "2020-08-01"
group by d.Pay_Option;


-- 16 -- 
--  .מהן העסקאות שבוצעו במהלך 12 החודשים האחרונים, ואשר הניבו
-- רווח גדול יותר מרווח העסקאות הממוצע ב- 12 החודשים האלו

SELECT d.deal_id, sum((dd.Sell_Price - pd.price_per_one) * dd.Amount) AS book_profit FROM Deal d
inner join Deal_Details dd on d.Deal_id = dd.Deal_id
inner join inventory i on dd.Copy_id = i.Copy_id 
inner join Purchasing_Detail pd on dd.Copy_id = pd.Copy_id
where d.Deal_Date >= 12-MONTH(NOW()) AND d.Deal_Date <= NOW()
GROUP BY d.deal_id
HAVING (
		SELECT AVG(Profit) AS average FROM
				(select sum((dd.Sell_Price - pd.price_per_one) * dd.Amount) as Profit  from Deal d
				inner join Deal_Details dd on d.Deal_id = dd.Deal_id
				inner join inventory i on dd.Copy_id = i.Copy_id 
				inner join Purchasing_Detail pd on dd.Copy_id = pd.Copy_id
				inner join purchasing p  on p.Purchase_id = pd.Purchase_id 
				where d.Deal_Date >= 12-MONTH(NOW()) AND d.Deal_Date <= NOW()
				group by d.deal_id) AS Average_Profit
		) < book_profit ;

-- 17 -- 
--  .כמה משלוחים בוצעו במהלך 12 החודשים האחרונים באמצעות דואר
-- ישראל, וכמה בוצעו באמצעות חברת Xpress

select count(d.Deliver_id) Num_Of_Delivers, dt.Type_Delivery  from delivery d
inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id 
inner join Delivery_Type dt on d.Type_id = dt.type_id
where d.Start_Date >= 12-MONTH(NOW()) AND d.Start_Date <= NOW()
group by dt.Type_Delivery;




-- 18 -- 
-- נתונים על כל המשלוחים שבוצעו, אי פעם, וכללו לפחות 2 מהדורות
-- שונות של אותו הספר

select count(distinct(b.book_id)) Num_Of_Copys , d.Deliver_id, b.Book_Name , bc.Copy_id from delivery d
inner join Delivery_Detail dd on d.Deliver_id = dd.Deliver_id 
inner join Delivery_Type dt on d.Type_id = dt.type_id
inner join Book_Copy BC on dd.Copy_id = BC.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
group by d.Deliver_id
having Num_Of_Copys > 1


-- 19 -- 
-- נתונים על כל הלקוחות שרכשו בעבר, מתי שהוא, לפחות ספר אחד
-- מהחנות, ושלא ביצעו שום רכישה במהלך 24 החודשים האחרונים

select * from Customer;

-- 20 -- 
-- רשימת הלקוחות שביצעו הזמנות, הספרים שהזמינו הגיעו לחנות,
-- החנות יצרה איתם קשר ליידע אותם על זמינות הספר.
-- הקשר נוצר לפני 14 ימים, והלקוחות עדיין לא רכשו הספר.

select SO.Order_id, SO.Amount, SO.Order_Date, SO.Order_Status, CONCAT(c.First_Name, " ", c.Last_Name ) as Customer_Name from Store_Order SO
inner join Book_Copy BC on SO.Copy_id = BC.Copy_id 
inner join book b on b.Book_id = BC.Book_id 
inner join customer c on SO.customer_id = c.customer_id
where SO.Order_Status = "in_Storge"
and SO.Order_Date >= 14-Day(NOW()) AND SO.Order_Date <= NOW();

-- 21 --  .מספר הספרים במחסן בחתך חודשי
select Sum(i.New_Amount) as Amount, YEAR(i.Stored_Date) AS 'year', MONTH(i.Stored_Date) AS 'month'  from inventory i 
where i.Stored_Location = "Stock"
and i.Stored_Date >= "2020-07-01" AND i.Stored_Date <= "2020-08-01";

-- 22 - A -- 
-- כמה ספרים רכשה החנות בין תאריך D1 לתאריך D2 ,ומה היה סך
-- התשלום עבורם.

select Sum(pd.Amount) Books_Total_Amount, Sum(pd.Amount * pd.Price_Per_One) Books_Total_Price from purchasing p
inner join Purchasing_Detail pd on p.Purchase_id = pd.Purchase_id 
where p.Purchasing_Date >= "2020-07-01" AND p.Purchasing_Date <= "2020-08-01";

-- 22 B-- .רווח החנות ממכירות בחודש מסוים הקלט לשאילתה 

select sum((dd.Sell_Price - pd.price_per_one) * dd.Amount) as Profit , YEAR(d.Deal_Date) AS 'year', MONTH(d.Deal_Date) AS 'month'  from Deal d
inner join Deal_Details dd on d.Deal_id = dd.Deal_id
inner join inventory i on dd.Copy_id = i.Copy_id 
inner join Purchasing_Detail pd on dd.Copy_id = pd.Copy_id
inner join purchasing p  on p.Purchase_id = pd.Purchase_id 
where d.Deal_Date >= "2020-07-01" AND d.Deal_Date <= "2020-08-01";


-- 23 --  .ממוצע עסקאות שנתי בחתך חודשי

select avg(d.Total_Cost) Total_Year_Cost, Month(d.Deal_Date) as 'Month', Year(d.Deal_Date)-1 as 'From_Year', Year(d.Deal_Date) as 'To_Year' from Deal d
where d.Deal_Date >= "2019-08-01" AND d.Deal_Date <= "2020-08-01"
GROUP BY MONTH(d.Deal_Date);


-- 24 --  .המשכורת )ברוטו( של עובד Z בחודש מסוים
select CONCAT(W.First_Name, " ", W.Last_Name ) as Worker_Name, (W.Hourly_Salary * SW.Hours) as Bruto_Salary, SW.Month_Val As Month, SW.Year_Val As Year from store_worker W
inner join Summery_Worker SW on w.Worker_id = SW.Worker_id
where W.First_Name = "Jhonatan" and W.Last_Name ="Cubani"
and SW.Month_Val = 2 and SW.Year_Val = 2020 ;

-- 25 -- .מי המוכר עם הכי הרבה עסקאות בחודש X
select count(d.deal_id) Deal_Number, CONCAT(SW.First_Name, " ", SW.Last_Name ) as Worker_Name from Deal d
inner join store_worker SW on SW.Worker_id = d.Worker_id
where d.Deal_Date >= "2020-07-01"  AND d.Deal_Date <= "2020-08-01"
group by SW.Worker_id
limit 1;

-- Login --
select SW.Is_Manager from Store_Worker SW
where SW.User_id = "12345" and SW.User_Password = "Britni123" ;  
