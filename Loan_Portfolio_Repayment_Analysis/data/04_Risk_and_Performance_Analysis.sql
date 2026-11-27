-- PAGE 4: RISK & PERFORMANCE ANALYSIS

-- KPI 1: Total Defaulted Loans
SELECT
    COUNT(*) AS total_defaulted_loans
FROM Loans
WHERE Loan_Status = 'Defaulted';

-- KPI 2: Total Defaulted Loan Value
SELECT
    ROUND(SUM(Loan_Amount), 2) AS total_defaulted_loan_value
FROM Loans
WHERE Loan_Status = 'Defaulted';

-- KPI 3: Overall Default Rate
SELECT
    ROUND(
        SUM(CASE
            WHEN Loan_Status = 'Defaulted' THEN 1
            ELSE 0
        END) / COUNT(*) * 100,
        2
    ) AS overall_default_rate
FROM Loans;

-- KPI 4: Average Defaulted Loan Amount
SELECT
    ROUND(AVG(Loan_Amount), 2) AS average_defaulted_loan_amount
FROM Loans
WHERE Loan_Status = 'Defaulted';

-- CHART 1: Default Rate by Loan Type
SELECT
    Loan_Type,
    COUNT(*) AS total_loans,
    SUM(CASE
        WHEN Loan_Status = 'Defaulted' THEN 1
        ELSE 0
    END) AS defaulted_loans,
    ROUND(
        SUM(CASE
            WHEN Loan_Status = 'Defaulted' THEN 1
            ELSE 0
        END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM Loans
GROUP BY Loan_Type
ORDER BY default_rate DESC;

-- CHART 2: Default Rate by Customer City
SELECT
    c.City,
    COUNT(l.Loan_ID) AS total_loans,
    SUM(
        CASE
            WHEN l.Loan_Status = 'Defaulted' THEN 1
            ELSE 0
        END
    ) AS defaulted_loans,
    ROUND(
        SUM(
            CASE
                WHEN l.Loan_Status = 'Defaulted' THEN 1
                ELSE 0
            END
        ) / COUNT(l.Loan_ID) * 100,
        2
    ) AS default_rate
FROM Loans l
JOIN Customers c
    ON l.Customer_ID = c.Customer_ID
GROUP BY c.City
ORDER BY default_rate DESC;

-- CHART 3: Defaulted Loan Value by Loan Type
SELECT
    Loan_Type,
    COUNT(Loan_ID) AS defaulted_loans,
    ROUND(SUM(Loan_Amount), 2) AS defaulted_loan_value
FROM Loans
WHERE Loan_Status = 'Defaulted'
GROUP BY Loan_Type
ORDER BY defaulted_loan_value DESC;

-- CHART 4: Default Rate by Loan Term
SELECT
    CASE
        WHEN Loan_Term_Months <= 12 THEN 'Up to 12 Months'
        WHEN Loan_Term_Months <= 36 THEN '13–36 Months'
        WHEN Loan_Term_Months <= 60 THEN '37–60 Months'
        ELSE 'Above 60 Months'
    END AS loan_term_group,
    COUNT(*) AS total_loans,
    SUM(CASE
        WHEN Loan_Status = 'Defaulted' THEN 1
        ELSE 0
    END) AS defaulted_loans,
    ROUND(
        SUM(CASE
            WHEN Loan_Status = 'Defaulted' THEN 1
            ELSE 0
        END) / COUNT(*) * 100,
        2
    ) AS default_rate
FROM Loans
GROUP BY loan_term_group
ORDER BY default_rate DESC;

-- CHART 5: Default Rate by Customer Age Group
SELECT
    CASE
        WHEN c.Age < 25 THEN 'Below 25'
        WHEN c.Age BETWEEN 25 AND 34 THEN '25–34'
        WHEN c.Age BETWEEN 35 AND 44 THEN '35–44'
        WHEN c.Age BETWEEN 45 AND 54 THEN '45–54'
        ELSE '55+'
    END AS age_group,
    COUNT(l.Loan_ID) AS total_loans,
    SUM(CASE
        WHEN l.Loan_Status = 'Defaulted' THEN 1
        ELSE 0
    END) AS defaulted_loans,
    ROUND(
        SUM(CASE
            WHEN l.Loan_Status = 'Defaulted' THEN 1
            ELSE 0
        END) / COUNT(l.Loan_ID) * 100,
        2
    ) AS default_rate
FROM Loans l
JOIN Customers c
    ON l.Customer_ID = c.Customer_ID
WHERE c.Age IS NOT NULL
GROUP BY age_group
ORDER BY default_rate DESC;

-- CHART 6: Default Rate by Customer Tenure
SELECT
    CASE
        WHEN TIMESTAMPDIFF(MONTH, c.Customer_Since, CURDATE()) < 12
            THEN 'Less than 1 Year'
        WHEN TIMESTAMPDIFF(MONTH, c.Customer_Since, CURDATE()) <= 36
            THEN '1–3 Years'
        WHEN TIMESTAMPDIFF(MONTH, c.Customer_Since, CURDATE()) <= 72
            THEN '4–6 Years'
        ELSE 'Above 6 Years'
    END AS customer_tenure_group,
    COUNT(l.Loan_ID) AS total_loans,
    SUM(CASE
        WHEN l.Loan_Status = 'Defaulted' THEN 1
        ELSE 0
    END) AS defaulted_loans,
    ROUND(
        SUM(CASE
            WHEN l.Loan_Status = 'Defaulted' THEN 1
            ELSE 0
        END) / COUNT(l.Loan_ID) * 100,
        2
    ) AS default_rate
FROM Loans l
JOIN Customers c
    ON l.Customer_ID = c.Customer_ID
WHERE c.Customer_Since IS NOT NULL
GROUP BY customer_tenure_group
ORDER BY default_rate DESC;