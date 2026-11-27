-- PAGE 2: REPAYMENT & DEFAULT ANALYSIS

-- KPI 1: Total Overdue Amount
SELECT
    ROUND(SUM(Amount_Due - Amount_Paid), 2) AS total_overdue_amount
FROM Payments_Cleaned
WHERE Payment_Status = 'Overdue';

-- KPI 2: Overall Repayment Rate
SELECT
    ROUND(
        SUM(Amount_Paid) / NULLIF(SUM(Amount_Due), 0) * 100,
        2
    ) AS overall_repayment_rate
FROM Payments_Cleaned;

-- KPI 3: Total Outstanding Amount
SELECT
    ROUND(SUM(Amount_Due - Amount_Paid), 2) AS total_outstanding_amount
FROM Payments_Cleaned;

-- KPI 4: Total Overdue Payment Records
SELECT
    COUNT(Payment_ID) AS total_overdue_records
FROM Payments_Cleaned
WHERE Payment_Status = 'Overdue';

-- CHART 1: Outstanding Amount by Payment Status
SELECT
    Payment_Status,
    ROUND(SUM(Amount_Due - Amount_Paid), 2) AS outstanding_amount
FROM Payments_Cleaned
GROUP BY Payment_Status
ORDER BY outstanding_amount DESC;

-- CHART 2: Overdue Amount by Loan Type
SELECT
    l.Loan_Type,
    ROUND(SUM(p.Amount_Due - p.Amount_Paid), 2) AS overdue_amount
FROM Payments_Cleaned p
JOIN Loans l
    ON p.Loan_ID = l.Loan_ID
WHERE p.Payment_Status = 'Overdue'
GROUP BY l.Loan_Type
ORDER BY overdue_amount DESC;

-- CHART 3: Repayment Rate by Loan Type
SELECT
    l.Loan_Type,
    ROUND(SUM(p.Amount_Paid), 2) AS total_amount_paid,
    ROUND(SUM(p.Amount_Due), 2) AS total_amount_due,
    ROUND(
        SUM(p.Amount_Paid) / NULLIF(SUM(p.Amount_Due), 0) * 100,
        2
    ) AS repayment_rate
FROM Payments_Cleaned p
JOIN Loans l
    ON p.Loan_ID = l.Loan_ID
GROUP BY l.Loan_Type
ORDER BY repayment_rate DESC;

-- CHART 4: Overdue Payment Records by Loan Type
SELECT
    l.Loan_Type,
    COUNT(p.Payment_ID) AS overdue_payment_records
FROM Payments_Cleaned p
JOIN Loans l
    ON p.Loan_ID = l.Loan_ID
WHERE p.Payment_Status = 'Overdue'
GROUP BY l.Loan_Type
ORDER BY overdue_payment_records DESC;

-- CHART 5: Monthly Repayment Trend
SELECT
    DATE_FORMAT(Payment_Date, '%Y-%m') AS payment_month,
    ROUND(SUM(Amount_Paid), 2) AS total_amount_paid
FROM Payments_Cleaned
WHERE Amount_Paid > 0
GROUP BY DATE_FORMAT(Payment_Date, '%Y-%m')
ORDER BY payment_month;

-- CHART 6: Payment Record Distribution by Status
SELECT
    Payment_Status,
    COUNT(Payment_ID) AS total_payment_records
FROM Payments_Cleaned
GROUP BY Payment_Status
ORDER BY total_payment_records DESC;