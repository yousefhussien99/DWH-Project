--Total Balance by Product Type and Year:
SELECT product_type, Year_Number, SUM(Maximum_Balance) AS Total_Balance
FROM DWH.Fact_Treasury_Products
GROUP BY product_type, Year_Number
ORDER BY Year_Number, product_type;

--Average Interest Rate by Product Type:
SELECT product_type, AVG(interest_rate) AS Average_Interest_Rate
FROM DWH.Fact_Treasury_Products
GROUP BY product_type
ORDER BY Average_Interest_Rate DESC;

--Total Fees by Year:
SELECT Year_Number, SUM(fees) AS Total_Fees
FROM DWH.Fact_Treasury_Products
GROUP BY Year_Number
ORDER BY Year_Number;

--Product Availability Count:
SELECT Availability, COUNT(product_id) AS Product_Count
FROM DWH.Fact_Treasury_Products
GROUP BY Availability
ORDER BY Product_Count DESC;


-- NEEDED BRANCH NAME INSTEAD OF ID--------------------------------------------
--Total Balance by Branch and Month:
SELECT branch_id, Month_Name, SUM(Maximum_Balance) AS Total_Balance
FROM DWH.Fact_Treasury_Products
GROUP BY branch_id, Month_Name, Month_Number
ORDER BY branch_id, Month_Number;

--Average Fees by Product Type and Year:
SELECT product_type, Year_Number, AVG(fees) AS Average_Fees
FROM DWH.Fact_Treasury_Products
GROUP BY product_type, Year_Number
ORDER BY Year_Number, product_type;

--Total Balance by Account and Year:
SELECT account_id, Year_Number, SUM(Maximum_Balance) AS Total_Balance
FROM DWH.Fact_Treasury_Products
GROUP BY account_id, Year_Number
ORDER BY Year_Number, account_id;


--Total Treasury Products by Month in a Specific Year (e.g., 1950):
SELECT Month_Name, COUNT(product_id) AS Total_Products
FROM DWH.Fact_Treasury_Products
WHERE Year_Number = 1950
GROUP BY Month_Name, Month_Number
ORDER BY Month_Number;