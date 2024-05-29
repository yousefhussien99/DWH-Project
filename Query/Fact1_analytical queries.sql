--Total Loan Amount by Year:
SELECT Year_Number, SUM(loan_amount) AS Total_Loan_Amount
FROM DWH.Fact_Loan
GROUP BY Year_Number
ORDER BY Total_Loan_Amount DESC;

--Average Loan Amount by Loan Type:
SELECT loan_type, AVG(loan_amount) AS Average_Loan_Amount
FROM DWH.Fact_Loan
GROUP BY loan_type
ORDER BY Average_Loan_Amount DESC;

--Total Loan Amount by Branch and Month:
SELECT branch_name, Month_Name, SUM(loan_amount) AS Total_Loan_Amount
FROM DWH.Fact_Loan
GROUP BY branch_name, Month_Name
ORDER BY branch_name, Month_Name;


--Number of Loans Issued by Quarter and Year:
SELECT Year_Number, Quarter_Number, COUNT(loan_id) AS Number_Of_Loans
FROM DWH.Fact_Loan
GROUP BY Year_Number, Quarter_Number
ORDER BY Year_Number, Quarter_Number;

--Total Loan Amount by Location and Year:
SELECT Location, Year_Number, SUM(loan_amount) AS Total_Loan_Amount
FROM DWH.Fact_Loan
GROUP BY Location, Year_Number
ORDER BY Location, Year_Number;

--Top 5 Branches by Total Loan Amount:
SELECT TOP 5 branch_name, SUM(loan_amount) AS Total_Loan_Amount
FROM DWH.Fact_Loan
GROUP BY branch_name
ORDER BY Total_Loan_Amount DESC;



--Loan Amount Distribution by Week of Year:
SELECT Week_Of_Year, SUM(loan_amount) AS Total_Loan_Amount
FROM DWH.Fact_Loan
GROUP BY Week_Of_Year
ORDER BY Week_Of_Year;
