Create schema DWH
GO

CREATE TABLE DWH.Dim_Date (
    Full_Date DATETIME ,
    Day_Of_Week VARCHAR(20) ,
    Day_Of_Month INT ,
    Day_Of_Year INT ,
    Week_Of_Year INT ,
    Month_Name VARCHAR(20) ,
    Month_Number INT ,
    Quarter_Number INT ,
    Year_Number INT
);

DECLARE @StartDate DATE = '1950-01-01';
DECLARE @EndDate DATE = '2025-12-31';
DECLARE @CurrentDate DATE = @StartDate;

WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO DWH.Dim_Date (Full_Date, Day_Of_Week, Day_Of_Month, Day_Of_Year, Week_Of_Year, Month_Name, Month_Number, Quarter_Number, Year_Number)
    VALUES (
        @CurrentDate,
        DATENAME(WEEKDAY, @CurrentDate),
        DATEPART(DAY, @CurrentDate),
        DATEPART(DAYOFYEAR, @CurrentDate),
        DATEPART(WEEK, @CurrentDate),
        DATENAME(MONTH, @CurrentDate),
        DATEPART(MONTH, @CurrentDate),
        DATEPART(QUARTER, @CurrentDate),
        DATEPART(YEAR, @CurrentDate)
    );
    
    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END


CREATE TABLE DWH.DIM_Customers (  
  Customer_id INT PRIMARY KEY ,
  customer_name NVARCHAR(50),
  address NVARCHAR(100),
  phone NVARCHAR(20),
  zipcode NVARCHAR(10),
  dob DATE,
  gender CHAR(1),
  occupation NVARCHAR(50),
  annual_income FLOAT
);
CREATE TABLE DWH.DIM_Branch (
  branch_id INT PRIMARY KEY ,
  branch_name NVARCHAR(50),
  zip_code NVARCHAR(10),
  Location NVARCHAR(50)
);
CREATE TABLE DWH.DIM_Account (
  account_id INT PRIMARY KEY ,
  customer_id INT ,
  branch_id INT ,
  creation_date DATETime ,
  account_balance FLOAT ,
  account_type VARCHAR(100) ,
  CONSTRAINT FK_Customers_Accounts FOREIGN KEY (customer_id) REFERENCES DWH.DIM_Customers(Customer_id),
  CONSTRAINT FK_Branch_Accounts FOREIGN KEY (branch_id) REFERENCES DWH.DIM_Branch(branch_id)
);
CREATE TABLE DWH.Fact_Loan(
    loan_id INT ,
	branch_name NVARCHAR(50),
    Location NVARCHAR(50),
    loan_amount FLOAT , -- This is the measure
	loan_type VARCHAR(100),
	Full_Date DATETIME ,
    Week_Of_Year INT ,
    Month_Name VARCHAR(20) ,
    Month_Number INT ,
    Quarter_Number INT ,
    Year_Number INT
	CONSTRAINT FK_Loan_Fact_Loan FOREIGN KEY (loan_id) REFERENCES DWH.DIM_Loan(loan_id)

);

CREATE TABLE DWH.DIM_Loan (
  loan_id INT PRIMARY KEY ,
  account_id INT ,
  branch_id INT ,
  start_date DATETIME ,
  end_date DATETIME ,
  interest_rate FLOAT ,
  loan_type VARCHAR(100) ,
  loan_amount FLOAT ,
  CONSTRAINT FK_Account_Loans FOREIGN KEY (account_id) REFERENCES DWH.DIM_Account(account_id),
  CONSTRAINT FK_Branch_Loans FOREIGN KEY (branch_id) REFERENCES DWH.DIM_Branch(branch_id)
);
CREATE TABLE DWH.DIM_Transaction_Type (
  transaction_type_id INT PRIMARY KEY,
  transaction_type_name VARCHAR(100) ,
  is_debit char ,
  is_credit char ,
  is_internal char ,
  is_external char 

);

CREATE TABLE DWH.Fact_Transactions(
   transaction_id INT,
   transaction_type_name VARCHAR(100) ,
   is_debit char ,
   is_credit char ,
   is_internal char ,
   is_external char ,
   interest_rate FLOAT ,


   Full_Date DATETIME ,
   Month_Name VARCHAR(20) ,
   Month_Number INT ,
   Quarter_Number INT ,
   Year_Number INT
    CONSTRAINT FK_tranctionfact FOREIGN KEY (transaction_id) REFERENCES DWH.DIM_Transactions (transaction_id),
);


CREATE TABLE DWH.DIM_Transactions (
  transaction_id INT   PRIMARY KEY,
  account_id INT ,
  transaction_type_id INT ,
  transaction_date DATETIME ,
  interest_rate FLOAT ,
  CONSTRAINT FK_Account_Transactions FOREIGN KEY (account_id) REFERENCES DWH.DIM_Account(account_id),
  CONSTRAINT FK_TransactionType_Transactions FOREIGN KEY (transaction_type_id) REFERENCES DWH.DIM_Transaction_Type(transaction_type_id)
);

create table DWH.DIM_Treasury_Products(
product_id int PRIMARY KEY ,
account_id int FOREIGN KEY REFERENCES DWH.DIM_Account(account_id),
Product_Name varchar(100) ,
product_type varchar(100) ,
interest_rate float ,
Minimum_Balance float ,
Maximum_Balance float ,
fees float,
Availability varchar(100) ,
buy_Date DATETIME,
Terms varchar(100) ,
);

CREATE TABLE DWH.DIM_Withdrawal (
  Withdrawal_ID INT  PRIMARY KEY ,
  account_id INT ,
  branch_id INT ,
  Withdrawal_date DATETIME ,
  Withdrawal_method VARCHAR(150) ,
  Withdrawal_amount FLOAT ,
  CONSTRAINT FK_Account_Withdrawals FOREIGN KEY (account_id) REFERENCES DWH.DIM_Account(account_id),
  CONSTRAINT FK_Branch_Withdrawals FOREIGN KEY (branch_id) REFERENCES DWH.DIM_Branch(branch_id)
);
CREATE TABLE DWH.DIM_Payment (
  Payment_ID INT  PRIMARY KEY,
  account_id INT ,
  branch_id INT ,
  Payment_date DATETIME ,
  Payment_method VARCHAR(150) ,
  Payment_amount FLOAT ,
  CONSTRAINT FK_Account_Payments FOREIGN KEY (account_id) REFERENCES DWH.DIM_Account(account_id),
  CONSTRAINT FK_Branch_Payments FOREIGN KEY (branch_id) REFERENCES DWH.DIM_Branch(branch_id)
);
CREATE TABLE DWH.DIM_Transfer (
  Transfer_ID INT PRIMARY KEY ,
  From_account_id INT ,
  To_account_id INT ,
  branch_id INT ,
  Transfer_date DATETIME ,
  Transfer_method VARCHAR(150) ,
  Transfer_amount FLOAT ,
  CONSTRAINT FK_From_Account_Transfers FOREIGN KEY (From_account_id) REFERENCES DWH.DIM_Account(account_id),
  CONSTRAINT FK_To_Account_Transfers FOREIGN KEY (To_account_id) REFERENCES DWH.DIM_Account(account_id),
  CONSTRAINT FK_Branch_Transfers FOREIGN KEY (branch_id) REFERENCES DWH.DIM_Branch(branch_id)
);
CREATE TABLE DWH.DIM_Deposit (
  Deposit_ID INT PRIMARY KEY,
  account_id INT ,
  branch_id INT ,
  deposit_date DATETIME ,
  deposit_method VARCHAR(150) ,
  deposit_amount FLOAT ,
  CONSTRAINT FK_Account_Deposits FOREIGN KEY (account_id) REFERENCES DWH.DIM_Account(account_id),
  CONSTRAINT FK_Branch_Deposits FOREIGN KEY (branch_id) REFERENCES DWH.DIM_Branch(branch_id),
);
create table DWH.DIM_Treasury_Products(
product_id int PRIMARY KEY ,
account_id int FOREIGN KEY REFERENCES DWH.DIM_Account(account_id),
Product_Name varchar(100) ,
product_type varchar(100) ,
interest_rate float ,
Minimum_Balance float ,
Maximum_Balance float ,
fees float,
Availability varchar(100) ,
Terms varchar(100) ,
);

CREATE TABLE DWH.Fact_Treasury_Products(
product_id int FOREIGN KEY REFERENCES DWH.DIM_Treasury_Products(product_id),
product_name varchar(100) ,
product_type varchar(100) ,
interest_rate float ,
Minimum_Balance float ,
Maximum_Balance float ,
--***************************
fees float,
Availability varchar(100) ,
account_id int ,
branch_id INT ,
Full_Date DATETIME ,
Month_Name VARCHAR(20) ,
Month_Number INT ,
Quarter_Number INT ,
Year_Number INT
);
CREATE TABLE DWH.Fact_Payment (
  Payment_ID INT  PRIMARY KEY,
  Payment_method VARCHAR(150) ,
  --***************************
  Payment_amount FLOAT ,
  branch_name NVARCHAR(50) ,
  Location  NVARCHAR(50) ,
  Full_Date DATETIME ,
  Month_Name VARCHAR(20) ,
  Month_Number INT ,
  Quarter_Number INT ,
  Year_Number INT,
  CONSTRAINT FK_Branch_Paymentss FOREIGN KEY (payment_id) REFERENCES DWH.DIM_Payment(Payment_ID)
);
drop table DWH.Fact_Payment


DELETE FROM DWH.DIM_Treasury_Products;
DELETE FROM DWH.DIM_Withdrawal;
DELETE FROM DWH.DIM_Payment;
DELETE FROM DWH.DIM_Transfer;
DELETE FROM DWH.DIM_Deposit;
DELETE FROM DWH.DIM_Transactions;
DELETE FROM DWH.DIM_Transaction_Type;
DELETE FROM DWH.DIM_Loan;
DELETE FROM DWH.DIM_Account;
DELETE FROM DWH.DIM_Customers;
DELETE FROM DWH.DIM_Branch;
DELETE FROM DWH.Fact_Loan
DELETE FROM DWH.Fact_Transactions
DELETE FROM DWH.Fact_Treasury_Products
DELETE FROM DWH.Fact_Payment 


SELECT * FROM DWH.DIM_Customers;
SELECT * FROM DWH.DIM_Branch;
SELECT * FROM DWH.DIM_Account;
SELECT * FROM DWH.DIM_Loan;
SELECT * FROM DWH.DIM_Transaction_Type;
SELECT * FROM DWH.DIM_Transactions;
SELECT * FROM DWH.DIM_Treasury_Products;
SELECT * FROM DWH.DIM_Withdrawal;
SELECT * FROM DWH.DIM_Payment;
SELECT * FROM DWH.DIM_Transfer;
SELECT * FROM DWH.DIM_Deposit;



Select * from DWH.Fact_Loan
select *  from DWH.Fact_Transactions
select *  from DWH.Fact_Treasury_Products
select *  from DWH.Fact_Payment 

