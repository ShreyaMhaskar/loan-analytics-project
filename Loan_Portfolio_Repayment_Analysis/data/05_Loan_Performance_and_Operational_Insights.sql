-- PAGE 5: LOAN PERFORMANCE & OPERATIONAL INSIGHTS

-- KPI 1: Total Disbursed Loan Value
SELECT
    ROUND(SUM(Loan_Amount), 2) AS total_disbursed_value
FROM Loans;

-- KPI 2: Average Loan Term
SELECT
    ROUND(AVG(Loan_Term_Months), 2) AS average_loan_term_months
FROM Loans;

-- KPI 3: Average Monthly Disbursement Value
SELECT
    ROUND(AVG(monthly_value), 2) AS average_monthly_disbursement
FROM (
    SELECT
        SUM(Loan_Amount) AS monthly_value
    FROM Loans
    GROUP BY YEAR(Loan_Date), MONTH(Loan_Date)
) AS monthly_disbursements;

-- KPI 4: Average Monthly Loans Disbursed
SELECT
    ROUND(AVG(monthly_count), 2) AS average_monthly_loans
FROM (
    SELECT
        COUNT(Loan_ID) AS monthly_count
    FROM Loans
    GROUP BY YEAR(Loan_Date), MONTH(Loan_Date)
) AS monthly_disbursements;

-- CHART 1: Average Loan Amount by Loan Type
SELECT
    Loan_Type,
    COUNT(Loan_ID) AS total_loans,
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount
FROM Loans
GROUP BY Loan_Type
ORDER BY average_loan_amount DESC;

-- CHART 2: Loan Distribution by Loan Term
SELECT
    Loan_Term_Months,
    COUNT(Loan_ID) AS total_loans,
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount
FROM Loans
GROUP BY Loan_Term_Months
ORDER BY Loan_Term_Months;

-- CHART 3: Average Loan Amount by Loan Status
SELECT
    Loan_Status,
    COUNT(Loan_ID) AS total_loans,
    ROUND(AVG(Loan_Amount), 2) AS average_loan_amount
FROM Loans
GROUP BY Loan_Status
ORDER BY average_loan_amount DESC;

-- CHART 4: Total Loan Value by Loan Status
SELECT
    Loan_Status,
    COUNT(Loan_ID) AS total_loans,
    ROUND(SUM(Loan_Amount), 2) AS total_loan_value
FROM Loans
GROUP BY Loan_Status
ORDER BY total_loan_value DESC;

-- CHART 5: Monthly Loan Disbursement Value
SELECT
    DATE_FORMAT(Loan_Date, '%Y-%m') AS loan_month,
    COUNT(Loan_ID) AS total_loans,
    ROUND(SUM(Loan_Amount), 2) AS total_disbursed_value
FROM Loans
GROUP BY loan_month
ORDER BY loan_month;

-- CHART 6: Monthly Loan Disbursement Count
SELECT
    DATE_FORMAT(Loan_Date, '%Y-%m') AS loan_month,
    COUNT(Loan_ID) AS total_loans
FROM Loans
GROUP BY loan_month
ORDER BY loan_month;