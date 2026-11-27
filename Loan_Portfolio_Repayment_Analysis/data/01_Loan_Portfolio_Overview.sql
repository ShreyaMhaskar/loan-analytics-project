-- PAGE 1: LOAN PORTFOLIO OVERVIEW
-- KPI: Total Loan Value
SELECT
    ROUND(SUM(Loan_Amount), 2) AS total_loan_value
FROM Loans;

SELECT COUNT(*) AS total_loans
FROM Loans;

SELECT
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount
FROM Loans;

SELECT
    COUNT(DISTINCT Customer_ID) AS unique_borrowers
FROM Loans;

SELECT
    COUNT(*) AS active_loans
FROM Loans
WHERE Loan_Status = 'Active';

SELECT
    COUNT(*) AS closed_loans
FROM Loans
WHERE Loan_Status = 'Closed';

SELECT
    COUNT(*) AS defaulted_loans
FROM Loans
WHERE Loan_Status = 'Defaulted';

SELECT
    ROUND(
        100.0 * SUM(
            CASE WHEN Loan_Status = 'Defaulted' THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS default_rate
FROM Loans;

-- CHART 1: Loan Distribution by Loan Type

SELECT
    Loan_Type,
    COUNT(*) AS total_loans
FROM Loans
WHERE 1=1
[[AND {{loan_type}}]]
GROUP BY Loan_Type
ORDER BY total_loans DESC;

-- CHART 2: Portfolio Value by Loan Type

SELECT
    Loan_Type,
    ROUND(SUM(Loan_Amount), 2) AS total_loan_value
FROM Loans
GROUP BY Loan_Type
ORDER BY total_loan_value DESC;

-- CHART 3: Loan Status Distribution

SELECT
    Loan_Status,
    COUNT(*) AS total_loans
FROM Loans
GROUP BY Loan_Status
ORDER BY total_loans DESC;

-- CHART 4: Loan Distribution by City

SELECT
    c.City,
    COUNT(l.Loan_ID) AS total_loans
FROM Loans l
JOIN Customers c
    ON l.Customer_ID = c.Customer_ID
GROUP BY c.City
ORDER BY total_loans DESC;

-- CHART 5: Monthly Loan Issuance Trend

SELECT
    DATE_FORMAT(Loan_Date, '%Y-%m') AS loan_month,
    COUNT(*) AS total_loans,
    ROUND(SUM(Loan_Amount), 2) AS total_loan_value
FROM Loans
GROUP BY DATE_FORMAT(Loan_Date, '%Y-%m')
ORDER BY loan_month;