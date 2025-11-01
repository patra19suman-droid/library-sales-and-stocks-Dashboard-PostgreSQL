# 📖 Bookstore Sales Analysis in PostgreSQL

This project involves a comprehensive sales analysis of a fictional bookstore, `XYZ_BOOKS_STORE`. Using PostgreSQL, this project demonstrates setting up a relational database, importing data from external CSV files, and executing 20 distinct analytical queries to uncover business insights.

The queries cover key business areas:
* Inventory Management
* Sales & Revenue Tracking
* Customer Behavior Analysis

## 🛠️ Tools & Technologies

* **Database:** PostgreSQL
* **Language:** SQL

## 🗂️ Database Schema

The database consists of three main tables:

1.  **`Books`**
    * `Book_ID` (INT, PRIMARY KEY): Unique identifier for each book.
    * `Title` (VARCHAR): Title of the book.
    * `Author` (VARCHAR): Author of the book.
    * `Genre` (VARCHAR): Genre of the book.
    * `Published_Year` (INT): Year the book was published.
    * `Price` (NUMERIC): Sale price of the book.
    * `Stock` (INT): Current quantity in stock.

2.  **`Customers`**
    * `Customer_ID` (INT, PRIMARY KEY): Unique identifier for each customer.
    * `Name` (VARCHAR): Customer's name.
    * `Email` (VARCHAR): Customer's email.
    * `Phone` (VARCHAR): Customer's phone number.
    * `City` (VARCHAR): City where the customer resides.
    * `Country` (VARCHAR): Country where the customer resides.

3.  **`Orders`**
    * `Order_ID` (INT, PRIMARY KEY): Unique identifier for each order.
    * `Customer_ID` (INT, FOREIGN KEY): References `Customers(Customer_ID)`.
    * `Book_ID` (INT, FOREIGN KEY): References `Books(Book_ID)`.
    * `Order_Date` (DATE): Date the order was placed.
    * `Quantity` (INT): Number of books purchased in the order.
    * `Total_Amount` (NUMERIC): Total cost of the order.

## 🚀 How to Use

1.  **Setup Database:** Ensure PostgreSQL is installed. Create a new database named `XYZ_BOOKS_STORE`.
2.  **Create Tables:** Run the `CREATE TABLE` statements from the `.sql` file to create the `Books`, `Customers`, and `Orders` tables.
3.  **Prepare Data:** You will need three CSV files: `Books.csv`, `Customers.csv`, and `Orders.csv`.
4.  **Import Data:**
    * Open the `Books sales analysis.sql` file.
    * **Important:** You must modify the `COPY` command's `FROM` path to match the location of your CSV files on your local machine.
    ```sql
    COPY Books(Book_ID, Title, Author, Genre, Published_Year, Price, Stock)
    FROM 'YOUR_LOCAL_FILE_PATH\Books.csv' -- <-- CHANGE THIS PATH
    DELIMITER ','
    CSV HEADER;

    -- Repeat for Customers.csv and Orders.csv
    ```
5.  **Run Queries:** Once the data is loaded, you can run the 20 analytical queries provided in the file to explore the data.

## 📊 Analytical Questions Answered

The 20 queries in this project answer a variety of business questions, including:

### 📚 Inventory & Book Analysis
* What books are available in the 'Fiction' genre?
* Which books were published after 1950?
* What is the total stock of all books?
* What are the details of the most expensive book?
* What are all the unique genres available?
* Which book has the lowest stock?
* What is the average price of 'Fantasy' books?
* What are the top 3 most expensive 'Fantasy' books?
* What is the remaining stock for each book after all orders are fulfilled?

### 💰 Sales & Revenue Analysis
* Which orders were placed in November 2023?
* Which orders had a total amount over $20?
* What is the total revenue generated from all orders?
* What is the total number of books sold for each genre?
* What is the total quantity of books sold by each author?

### 🧑‍💼 Customer & Order Analysis
* Which customers are from Canada?
* Which orders involved a quantity greater than 1?
* Which customers have placed at least 2 orders?
* What is the most frequently ordered book?
* What cities do customers who spent over $30 live in?
* Which customer has spent the most money?
