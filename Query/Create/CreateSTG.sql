Create schema STG
GO
CREATE TABLE STG.Customers (
  Customer_id INT NOT NULL PRIMARY KEY,
  customer_name NVARCHAR(50),
  address NVARCHAR(100),
  phone NVARCHAR(20),
  zipcode NVARCHAR(10),
  dob DATE,
  gender CHAR(1),
  occupation NVARCHAR(50),
  annual_income FLOAT,
  SrcUpdatedate date 
);
CREATE TABLE STG.Branch (
  branch_id INT NOT NULL PRIMARY KEY,
  branch_name NVARCHAR(50),
  zip_code NVARCHAR(10),
  Location NVARCHAR(50),
   SrcUpdatedate date 

);
CREATE TABLE STG.Account (
  account_id INT NOT NULL PRIMARY KEY,
  customer_id INT NOT NULL,
  branch_id INT NOT NULL,
  creation_date DATETime NOT NULL,
  account_balance FLOAT NOT NULL,
  account_type VARCHAR(100) NOT NULL,
    SrcUpdatedate date 
  CONSTRAINT FK_Customers_Accounts FOREIGN KEY (customer_id) REFERENCES STG.Customers(Customer_id),
  CONSTRAINT FK_Branch_Accounts FOREIGN KEY (branch_id) REFERENCES STG.Branch(branch_id)
);


CREATE TABLE STG.Loan (
  loan_id INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME NOT NULL,
  interest_rate FLOAT NOT NULL,
  loan_type VARCHAR(100) NOT NULL,
  loan_amount FLOAT NOT NULL,
    SrcUpdatedate date 

  CONSTRAINT FK_Account_Loans FOREIGN KEY (account_id) REFERENCES STG.Account(account_id),
  CONSTRAINT FK_Branch_Loans FOREIGN KEY (branch_id) REFERENCES STG.Branch(branch_id)
);
CREATE TABLE STG.Transaction_Type (
  transaction_type_id INT NOT NULL PRIMARY KEY,
  transaction_type_name VARCHAR(100) NOT NULL,
  is_debit char NOT NULL,
  is_credit char NOT NULL,
  is_internal char NOT NULL,
  is_external char NOT NULL,
    SrcUpdatedate date 

);
CREATE TABLE STG.Transactions (
  transaction_id INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  transaction_type_id INT NOT NULL,
  transaction_date DATETIME NOT NULL,
  interest_rate FLOAT NOT NULL,
    SrcUpdatedate date 

  CONSTRAINT FK_Account_Transactions FOREIGN KEY (account_id) REFERENCES STG.Account(account_id),
  CONSTRAINT FK_TransactionType_Transactions FOREIGN KEY (transaction_type_id) REFERENCES STG.Transaction_Type(transaction_type_id)
);
create table STG.Treasury_Products(
product_id int NOT NUll PRIMARY KEY,
account_id int NOT NULL FOREIGN KEY REFERENCES STG.Account(account_id),
Product_Name varchar(100) Not null,
product_type varchar(100) Not null,
interest_rate float not null,
Minimum_Balance float not null,
Maximum_Balance float not null,
fees float not null,
buy_Date DATETIME,
Availability varchar(100) Not null,
Terms varchar(100) Not null,
  SrcUpdatedate date 

);

CREATE TABLE STG.Withdrawal (
  Withdrawal_ID INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  Withdrawal_date DATETIME NOT NULL,
  Withdrawal_method VARCHAR(150) NOT NULL,
  Withdrawal_amount FLOAT NOT NULL,
    SrcUpdatedate date 

  CONSTRAINT FK_Account_Withdrawals FOREIGN KEY (account_id) REFERENCES STG.Account(account_id),
  CONSTRAINT FK_Branch_Withdrawals FOREIGN KEY (branch_id) REFERENCES STG.Branch(branch_id)
);
CREATE TABLE STG.Payment (
  Payment_ID INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  Payment_date DATETIME NOT NULL,
  Payment_method VARCHAR(150) NOT NULL,
  Payment_amount FLOAT NOT NULL,
    SrcUpdatedate date 

  CONSTRAINT FK_Account_Payments FOREIGN KEY (account_id) REFERENCES STG.Account(account_id),
  CONSTRAINT FK_Branch_Payments FOREIGN KEY (branch_id) REFERENCES STG.Branch(branch_id)
);
CREATE TABLE STG.Transfer (
  Transfer_ID INT NOT NULL PRIMARY KEY,
  From_account_id INT NOT NULL,
  To_account_id INT NOT NULL,
  branch_id INT NOT NULL,
  Transfer_date DATETIME NOT NULL,
  Transfer_method VARCHAR(150) NOT NULL,
  Transfer_amount FLOAT NOT NULL,
   SrcUpdatedate date 

  CONSTRAINT FK_From_Account_Transfers FOREIGN KEY (From_account_id) REFERENCES STG.Account(account_id),
  CONSTRAINT FK_To_Account_Transfers FOREIGN KEY (To_account_id) REFERENCES STG.Account(account_id),
  CONSTRAINT FK_Branch_Transfers FOREIGN KEY (branch_id) REFERENCES STG.Branch(branch_id)
);
CREATE TABLE STG.Deposit (
  Deposit_ID INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  deposit_date DATETIME NOT NULL,
  deposit_method VARCHAR(150) NOT NULL,
  deposit_amount FLOAT NOT NULL,
    SrcUpdatedate date 

  CONSTRAINT FK_Account_Deposits FOREIGN KEY (account_id) REFERENCES STG.Account(account_id),
  CONSTRAINT FK_Branch_Deposits FOREIGN KEY (branch_id) REFERENCES STG.Branch(branch_id)
);



CREATE TABLE STG.Config (
  Table_Name varchar(50) primary key, 
  Last_Date Date
);



insert into STG.Config (Table_Name,Last_Date)
values ('Customers','1945-01-01'),('Branch','1945-01-01'),('Deposit','1945-01-01'),('Transfer','1945-01-01'),('Treasury_Products','1945-01-01'),('Payment','1945-01-01'),
('Withdrawal','1945-01-01'),('Transactions','1945-01-01'),('Transaction_Type','1945-01-01'),('Loan','1945-01-01'),('Account','1945-01-01');

delete from STG.Config

select * from STG.Config


-- Delete all records from all tables in the STG schema
DELETE FROM STG.Withdrawal;
DELETE FROM STG.Payment;
DELETE FROM STG.Transfer;
DELETE FROM STG.Deposit;
DELETE FROM STG.Treasury_Products;
DELETE FROM STG.Transactions;
DELETE FROM STG.Transaction_Type;
DELETE FROM STG.Loan;
DELETE FROM STG.Account;
DELETE FROM STG.Customers;
DELETE FROM STG.Branch;


-- Select all records from all tables in the STG schema
SELECT * FROM STG.Customers;
SELECT * FROM STG.Branch;
SELECT * FROM STG.Account;
SELECT * FROM STG.Loan;
SELECT * FROM STG.Transaction_Type;
SELECT * FROM STG.Transactions;
SELECT * FROM STG.Treasury_Products;
SELECT * FROM STG.Withdrawal;
SELECT * FROM STG.Payment;
SELECT * FROM STG.Transfer;
SELECT * FROM STG.Deposit;
