use BankDB

/*creating tables*/


CREATE TABLE Transaction_Type (
  transaction_type_id INT NOT NULL PRIMARY KEY,
  transaction_type_name VARCHAR(100) NOT NULL,
  is_debit char NOT NULL,
  is_credit char NOT NULL,
  is_internal char NOT NULL,
  is_external char NOT NULL,
    Lastupdate date default '1950-01-01',
);

CREATE TABLE Customers (
  Customer_id INT NOT NULL PRIMARY KEY,
  customer_name NVARCHAR(50),
  address NVARCHAR(100),
  phone NVARCHAR(20),
  zipcode NVARCHAR(10),
  dob DATE,
  gender CHAR(1),
  occupation NVARCHAR(50),
  annual_income FLOAT,
    Lastupdate date default '1950-01-01',
);

CREATE TABLE Branch (
  branch_id INT NOT NULL PRIMARY KEY,
  branch_name NVARCHAR(50),
  zip_code NVARCHAR(10),
  Location NVARCHAR(50),
    Lastupdate date default '1950-01-01',
);

CREATE TABLE Account (
  account_id INT NOT NULL PRIMARY KEY,
  customer_id INT NOT NULL,
  branch_id INT NOT NULL,
  creation_date DATETime NOT NULL,
  account_balance FLOAT NOT NULL,
  account_type VARCHAR(100) NOT NULL,
    Lastupdate date default '1950-01-01',
  CONSTRAINT FK_Customers_Accounts FOREIGN KEY (customer_id) REFERENCES Customers(Customer_id),
  CONSTRAINT FK_Branch_Accounts FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Credit_Card (
  credit_card_number bigint NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  start_date DATETIME NOT NULL,
  Expiration_date DATE NOT NULL,
  interest_rate FLOAT NOT NULL,
  credit_type VARCHAR(100) NOT NULL,
  credit_limit FLOAT NOT NULL,
  annual_fee FLOAT NOT NULL,
  CONSTRAINT FK_Account_CreditCards FOREIGN KEY (account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_Branch_CreditCards FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

drop table Credit_Card;

CREATE TABLE Loan (
  loan_id INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME NOT NULL,
  interest_rate FLOAT NOT NULL,
  loan_type VARCHAR(100) NOT NULL,
  loan_amount FLOAT NOT NULL,
    Lastupdate date default '1950-01-01',
  CONSTRAINT FK_Account_Loans FOREIGN KEY (account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_Branch_Loans FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Transactions (
  transaction_id INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  transaction_type_id INT NOT NULL,
  transaction_date DATETIME NOT NULL,
  interest_rate FLOAT NOT NULL,
    Lastupdate date default '1950-01-01',
  CONSTRAINT FK_Account_Transactions FOREIGN KEY (account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_TransactionType_Transactions FOREIGN KEY (transaction_type_id) REFERENCES Transaction_Type(transaction_type_id)
);

ALTER TABLE Transactions
ADD Transaction_state bit;


create table Treasury_Products(
product_id int NOT NUll PRIMARY KEY,
account_id int NOT NULL FOREIGN KEY REFERENCES Account(account_id),
Product_Name varchar(100) Not null,
product_type varchar(100) Not null,
interest_rate float not null,
Minimum_Balance float not null,
Maximum_Balance float not null,
fees float not null,
  Lastupdate date default '1950-01-01',
Availability varchar(100) Not null,
Terms varchar(100) Not null
);


ALTER TABLE Treasury_Products
DROP COLUMN Subcategory;


CREATE TABLE Withdrawal (
  Withdrawal_ID INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  Withdrawal_date DATETIME NOT NULL,
  Withdrawal_method VARCHAR(150) NOT NULL,
  Withdrawal_amount FLOAT NOT NULL,
    Lastupdate date default '1950-01-01',
  CONSTRAINT FK_Account_Withdrawals FOREIGN KEY (account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_Branch_Withdrawals FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);


CREATE TABLE Payment (
  Payment_ID INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  Payment_date DATETIME NOT NULL,
  Payment_method VARCHAR(150) NOT NULL,
  Payment_amount FLOAT NOT NULL,
  Lastupdate date default '1950-01-01',
  CONSTRAINT FK_Account_Payments FOREIGN KEY (account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_Branch_Payments FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);
CREATE TABLE Transfer (
  Transfer_ID INT NOT NULL PRIMARY KEY,
  From_account_id INT NOT NULL,
  To_account_id INT NOT NULL,
  branch_id INT NOT NULL,
  Transfer_date DATETIME NOT NULL,
  Transfer_method VARCHAR(150) NOT NULL,
  Transfer_amount FLOAT NOT NULL,
   Lastupdate date default '1950-01-01',
  CONSTRAINT FK_From_Account_Transfers FOREIGN KEY (From_account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_To_Account_Transfers FOREIGN KEY (To_account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_Branch_Transfers FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);


CREATE TABLE Deposit (
  Deposit_ID INT NOT NULL PRIMARY KEY,
  account_id INT NOT NULL,
  branch_id INT NOT NULL,
  deposit_date DATETIME NOT NULL,
  deposit_method VARCHAR(150) NOT NULL,
  deposit_amount FLOAT NOT NULL,
  Lastupdate date default '1950-01-01',
  CONSTRAINT FK_Account_Deposits FOREIGN KEY (account_id) REFERENCES Account(account_id),
  CONSTRAINT FK_Branch_Deposits FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

/*inserting data*/

-- Altering Transaction_Type table
ALTER TABLE Transaction_Type
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Customers table
ALTER TABLE Customers
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Branch table
ALTER TABLE Branch
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Account table
ALTER TABLE Account
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Credit_Card table
ALTER TABLE Credit_Card
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Loan table
ALTER TABLE Loan
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Transactions table
ALTER TABLE Transactions
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Treasury_Products table
ALTER TABLE Treasury_Products
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Withdrawal table
ALTER TABLE Withdrawal
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Payment table
ALTER TABLE Payment
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Transfer table
ALTER TABLE Transfer
ADD Lastupdate DATE DEFAULT '1950-01-01';

-- Altering Deposit table
ALTER TABLE Deposit
ADD Lastupdate DATE DEFAULT '1950-01-01';
