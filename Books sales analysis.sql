--Create Database

CREATE DATABASE XYZ_BOOKS_STORE;

--Switch to the Database

\c XYZ_BOOKS_STORE;

-- Create Tables

DROP TABLE IF EXISTS Books;
CREATE TABLE Books(
		Book_ID INT PRIMARY KEY,
		Title VARCHAR(100),
		Author VARCHAR(100),
		Genre VARCHAR(70),
		Published_Year INT,
		Price NUMERIC(10,2),
		Stock INT
);

DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers(
		Customer_ID INT PRIMARY KEY,
		Name VARCHAR(100),
		Email VARCHAR(100),
		Phone VARCHAR(12),
		City VARCHAR(50),
		Country VARCHAR(150)
);

DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders(
		Order_ID INT PRIMARY KEY,
		Customer_ID INT REFERENCES Customers(Customer_ID),
		Book_ID INT REFERENCES Books(Book_ID),
		Order_Date DATE,
		Quantity INT,
		Total_Amount NUMERIC(20,2)

);

-- Import CSV data in Database Tables

--Books

COPY Books(Book_ID, Title, Author, Genre, Published_Year,	Price,	Stock)
FROM 'C:\Program Files\PostgreSQL\16\SQL Project Data\Books.csv'
DELIMITER ','
CSV HEADER;

--Customers

COPY Customers(Customer_ID, Name, Email, Phone, City, Country)
FROM 'C:\Program Files\PostgreSQL\16\SQL Project Data\Customers.csv'
DELIMITER ','
CSV HEADER;

--Orders

COPY Orders(Order_ID, Customer_ID, Book_ID, Order_Date, Quantity, Total_Amount)
FROM 'C:\Program Files\PostgreSQL\16\SQL Project Data\Orders.csv'
DELIMITER ','
CSV HEADER;

--Display Table Structure/Data

SELECT * FROM Books;
SELECT * FROM Customers;
SELECT * FROM Orders;

-- 1) Retrieve all books in the "Fiction" genre:

SELECT * FROM Books
WHERE genre='Fiction';

-- 2) Find books published after the year 1950:

SELECT * FROM Books
WHERE published_year > 1950;

-- 3) List all customers from the Canada:

SELECT * FROM Customers
WHERE country='Canada';

-- 4) Show orders placed in November 2023:

SELECT * FROM Orders
WHERE order_date BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:

SELECT SUM(stock) AS Total_Stock 
FROM Books;

-- 6) Find the details of the most expensive book:

SELECT * FROM Books
ORDER BY price DESC LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:

SELECT * FROM Orders
WHERE quantity > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:

SELECT * FROM Orders
WHERE total_amount > 20 
--ORDER BY total_amount DESC;

-- 9) List all genres available in the Books table:

SELECT DISTINCT genre from Books ;

-- 10) Find the book with the lowest stock:

SELECT * FROM Books
ORDER BY stock LIMIT 10;

-- 11) Calculate the total revenue generated from all orders:

SELECT SUM(total_amount) AS Revenue 
FROM Orders;


-- 12) Retrieve the total number of books sold for each genre:

SELECT * FROM Orders;

SELECT b.genre, SUM(o.quantity) AS Total_Books_Sold
FROM Orders o
JOIN Books b
ON o.book_id=b.book_id
GROUP BY b.genre;

-- 13) Find the average price of books in the "Fantasy" genre:

SELECT AVG(price) AS Average_Price
FROM Books
WHERE genre='Fantasy';

-- 14) List customers who have placed at least 2 orders:
 
 SELECT o.customer_id ,c.name, COUNT(o.order_id) AS Order_Count
 FROM Orders o
 JOIN customers c
 ON c.customer_id=o.customer_id
 GROUP BY o.customer_id, c.name
 HAVING COUNT(o.order_id)>=2 ;
 

-- 15) Find the most frequently ordered book:

SELECT o.book_id,b.title,b.author,b.genre, COUNT(o.order_id) AS Order_Count
FROM Orders o
JOIN Books b
ON o.book_id=b.book_id
GROUP BY o.book_id, b.title,b.author,b.genre
ORDER BY (Order_count) DESC;

-- 16) Show the top 3 most expensive books of 'Fantasy' Genre :

Select * From Books
WHERE genre='Fantasy'
ORDER BY price DESC LIMIT 3;

-- 17) Retrieve the total quantity of books sold by each author:

SELECT b.author,SUM(o.quantity) as Total_Books_Sold
FROM Orders o
Join Books b
ON b.Book_id=o.book_id
GROUP BY b.author;

-- 18) List the cities where customers who spent over $30 are located:

SELECT DISTINCT c.city,total_amount
FROM Orders o
Join Customers c
ON o.customer_id=c.customer_id
WHERE o.total_amount>30
ORDER BY o.total_amount DESC;

-- 19) Find the customer who spent the most on orders:

SELECT c.name ,C.customer_ID, SUM(o.total_amount) AS Total_spend
FROM Orders o
JOIN Customers c
ON c.customer_id=o.customer_id
GROUP BY c.name ,C.customer_ID
ORDER BY Total_spend DESC LIMIT 10;

--20) Calculate the stock remaining after fulfilling all orders:

SELECT b.book_id, b.title, b.stock, COALESCE(SUM(o.quantity),0) AS Order_quantity,
b.stock - COALESCE(SUM(o.quantity),0) AS remaining_quantity
From Books b
LEFT JOIN Orders o
ON b.book_id=o.book_id
GROUP BY b.book_id 
ORDER BY remaining_quantity ;
