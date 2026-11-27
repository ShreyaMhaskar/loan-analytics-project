-- PAGE 3: CUSTOMER ANALYSIS

-- KPI 1: Total Customers
SELECT
    COUNT(DISTINCT Customer_ID) AS total_customers
FROM Customers;

-- KPI 2: Average Customer Age
SELECT
    ROUND(AVG(Age), 2) AS average_customer_age
FROM Customers
WHERE Age IS NOT NULL;

-- KPI 3: Average Customer Tenure
SELECT
    ROUND(
        AVG(TIMESTAMPDIFF(MONTH, Customer_Since, CURDATE())) / 12,
        2
    ) AS average_customer_tenure_years
FROM Customers
WHERE Customer_Since IS NOT NULL;

-- KPI 4: Total Loan Value
SELECT
    ROUND(SUM(Loan_Amount), 2) AS total_loan_value
FROM Loans;

-- CHART 1: Customer Distribution by City
SELECT
    City,
    COUNT(Customer_ID) AS total_customers
FROM Customers
GROUP BY City
ORDER BY total_customers DESC;

-- CHART 2: Customer Distribution by Age Group
SELECT
    CASE
        WHEN Age < 25 THEN 'Below 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and Above'
    END AS age_group,
    COUNT(Customer_ID) AS total_customers
FROM Customers
WHERE Age IS NOT NULL
GROUP BY age_group
ORDER BY MIN(Age);

-- CHART 3: Customer Distribution by Tenure
SELECT
    CASE
        WHEN TIMESTAMPDIFF(YEAR, Customer_Since, CURDATE()) < 1 THEN 'Less than 1 year'
        WHEN TIMESTAMPDIFF(YEAR, Customer_Since, CURDATE()) BETWEEN 1 AND 3 THEN '1-3 years'
        WHEN TIMESTAMPDIFF(YEAR, Customer_Since, CURDATE()) BETWEEN 4 AND 6 THEN '4-6 years'
        ELSE '7+ years'
    END AS customer_tenure,
    COUNT(Customer_ID) AS total_customers
FROM Customers
WHERE Customer_Since IS NOT NULL
GROUP BY customer_tenure
ORDER BY MIN(TIMESTAMPDIFF(YEAR, Customer_Since, CURDATE()));

-- CHART 4: Loan Value by Customer Age Group
SELECT
    CASE
        WHEN Age < 25 THEN 'Below 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and Above'
    END AS age_group,
    COUNT(Customer_ID) AS total_customers
FROM Customers
WHERE Age IS NOT NULL
GROUP BY age_group
ORDER BY MIN(Age);

-- CHART 5: Top 10 Customers by Loan Value
SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(l.Loan_ID) AS total_loans,
    ROUND(SUM(l.Loan_Amount), 2) AS total_loan_value
FROM Customers c
JOIN Loans l
    ON c.Customer_ID = l.Customer_ID
GROUP BY
    c.Customer_ID,
    c.Customer_Name
ORDER BY total_loan_value DESC
LIMIT 10;

-- CHART 6: Average Loan Amount by Age Group
SELECT
    CASE
        WHEN c.Age < 25 THEN 'Below 25'
        WHEN c.Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN c.Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN c.Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and Above'
    END AS age_group,
    COUNT(l.Loan_ID) AS total_loans,
    ROUND(AVG(l.Loan_Amount), 2) AS average_loan_amount
FROM Customers c
JOIN Loans l
    ON c.Customer_ID = l.Customer_ID
WHERE c.Age IS NOT NULL
GROUP BY age_group
ORDER BY MIN(c.Age);