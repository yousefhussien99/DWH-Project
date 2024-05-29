--Total Number of Transactions by Year:
SELECT Year_Number, COUNT(transaction_id) AS Total_Transactions
FROM DWH.Fact_Transactions
GROUP BY Year_Number
ORDER BY Year_Number;

--Total Interest Earned by Year:
SELECT Year_Number, MAX(interest_rate) AS Total_Interest
FROM DWH.Fact_Transactions
WHERE is_credit = 1
GROUP BY Year_Number
ORDER BY Year_Number;


---Average Interest Rate by Transaction Type:
SELECT transaction_type_name, AVG(interest_rate) AS Average_Interest_Rate
FROM DWH.Fact_Transactions
GROUP BY transaction_type_name
ORDER BY Average_Interest_Rate DESC;


--Total Transactions by Month in a Specific Year (e.g., 2023):
SELECT Month_Name, COUNT(transaction_id) AS Total_Transactions
FROM DWH.Fact_Transactions
WHERE Year_Number = 2014
GROUP BY Month_Name, Month_Number
ORDER BY Month_Number;



---Number of Debit vs. Credit Transactions:
SELECT 
    SUM(CASE WHEN is_debit = 1 THEN 1 ELSE 0 END) AS Debit_Transactions,
    SUM(CASE WHEN is_credit = 1 THEN 1 ELSE 0 END) AS Credit_Transactions
FROM DWH.Fact_Transactions;


--Total External vs. Internal Transactions:
SELECT 
    SUM(CASE WHEN is_external = 1 THEN 1 ELSE 0 END) AS External_Transactions,
    SUM(CASE WHEN is_internal = 1 THEN 1 ELSE 0 END) AS Internal_Transactions
FROM DWH.Fact_Transactions;


--Total Transactions by Quarter:

SELECT Year_Number AS Year, Quarter_Number, COUNT(transaction_id) AS Total_Transactions
FROM DWH.Fact_Transactions
GROUP BY Year_Number, Quarter_Number
ORDER BY Year_Number, Quarter_Number;

--Transactions Distribution by Month Name:
SELECT Month_Name, COUNT(transaction_id) AS Total_Transactions
FROM DWH.Fact_Transactions
GROUP BY Month_Name, Month_Number
ORDER BY Month_Number;