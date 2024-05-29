--Total Payment Amount by Year:
SELECT Year_Number, SUM(Payment_amount) AS Total_Payment_Amount
FROM DWH.Fact_Payment
GROUP BY Year_Number
ORDER BY Year_Number;

-- in power bi
--Average Payment Amount by Payment Method:
SELECT Payment_method, AVG(Payment_amount) AS Average_Payment_Amount
FROM DWH.Fact_Payment
GROUP BY Payment_method
ORDER BY Average_Payment_Amount DESC;

--Total Payment Amount by Branch and Month:
SELECT branch_name, Month_Name, SUM(Payment_amount) AS Total_Payment_Amount
FROM DWH.Fact_Payment
GROUP BY branch_name, Month_Name, Month_Number
ORDER BY branch_name, Month_Number;

--Number of Payments by Quarter and Year:
SELECT Year_Number, Quarter_Number, COUNT(Payment_ID) AS Number_Of_Payments
FROM DWH.Fact_Payment
GROUP BY Year_Number, Quarter_Number
ORDER BY Year_Number, Quarter_Number;

--Total Payment Amount by Location and Year:
SELECT Location, Year_Number, SUM(Payment_amount) AS Total_Payment_Amount
FROM DWH.Fact_Payment
GROUP BY Location, Year_Number
ORDER BY Location, Year_Number;


--in power bi
--Top 5 Branches by Total Payment Amount:
SELECT top 5  branch_name, SUM(Payment_amount) AS Total_Payment_Amount
FROM DWH.Fact_Payment
GROUP BY branch_name
ORDER BY Total_Payment_Amount DESC

--in power bi
--Total Payment Amount by Month Name:
SELECT Month_Name, SUM(Payment_amount) AS Total_Payment_Amount
FROM DWH.Fact_Payment
GROUP BY Month_Name, Month_Number
ORDER BY Month_Number;

--Total Payment Amount for Each Month in a Specific Year (e.g., 2003):
SELECT Month_Name, SUM(Payment_amount) AS Total_Payment_Amount
FROM DWH.Fact_Payment
WHERE Year_Number = 2003
GROUP BY Month_Name, Month_Number
ORDER BY Month_Number;