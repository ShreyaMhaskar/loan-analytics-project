
# Loan Portfolio Analysis

An end-to-end data analytics project exploring loan portfolio performance, customer behaviour, repayment trends, and default risk using **Python, MySQL, SQL, and Metabase**.

## Project Overview

This project analyses a loan portfolio to identify trends in loan distribution, repayment performance, customer demographics, and default risk.

The objective is to transform raw loan data into meaningful business insights through SQL analysis and dashboard development.

## Tools & Technologies

- **Python:** Dataset generation
- **MySQL:** Database management and data storage
- **SQL:** Data analysis, aggregations, joins, KPI calculations, and trend analysis
- **Metabase:** Data visualization and dashboard creation

## Dataset Overview

The project includes:

- 500 loan records
- 300 customer records
- Loan types, amounts, terms, and statuses
- Payment records, due amounts, and repayment information
- Customer demographics and location details

## Dashboards & Analysis

### 1. Loan Portfolio Overview

![Loan Portfolio Overview](Loan_Portfolio_Repayment_Analysis/Screenshots/Loan%20Portfolio%20Overview.png)

- Total loan value and average loan amount
- Loan distribution by type and city
- Loan status distribution
- Monthly loan issuance trends

### 2. Repayment & Default Analysis

![Repayment and Default Analysis](Loan_Portfolio_Repayment_Analysis/Screenshots/Repayment%20%26%20Default%20Analysis.png)

- Overall repayment rate
- Outstanding and overdue amounts
- Repayment performance by loan type
- Monthly repayment trends

### 3. Customer Analysis

![Customer Analysis](Loan_Portfolio_Repayment_Analysis/Screenshots/Customer%20Analysis.png)

- Customer distribution by city and age group
- Customer tenure analysis
- Loan value by age group
- Top 10 customers by loan value

### 4. Risk & Performance Analysis

![Risk and Performance Analysis](Loan_Portfolio_Repayment_Analysis/Screenshots/Risk%20%26%20Performance%20Analysis.png)

- Default rates by loan type and city
- Defaulted loan value
- Default rates by loan term
- Default patterns across customer age and tenure groups

### 5. Loan Performance & Operational Insights

![Loan Performance and Operational Insights](Loan_Portfolio_Repayment_Analysis/Screenshots/Loan%20Performance%20%26%20Operational%20Insights.png)

- Average loan amount by type and status
- Loan distribution by loan term
- Total loan value by status
- Monthly loan disbursement trends

## Key Findings

- Total loan portfolio value was approximately **₹54.80 crore**.
- Overall default rate was **5.20%**.
- Home loans accounted for the highest defaulted loan value.
- Education loans recorded the highest default rate among loan types.
- Vehicle loans had the highest repayment rate at **47.70%**.
- Active loans represented the largest share of the portfolio.

## Repository Structure

```text
loan-analytics-project/
│
├── README.md
│
└── Loan_Portfolio_Repayment_Analysis/
    ├── generate.py
    ├── Data/
    ├── SQL/
    │   ├── 01_Loan_Portfolio_Overview.sql
    │   ├── 02_Repayment_and_Default_Analysis.sql
    │   ├── 03_Customer_Analysis.sql
    │   ├── 04_Risk_and_Performance_Analysis.sql
    │   └── 05_Loan_Performance_and_Operational_Insights.sql
    │
    ├── Dashboard_PDFs/
    └── Screenshots/
```

## Skills Demonstrated

- SQL querying and data aggregation
- KPI development
- Exploratory data analysis
- Customer and portfolio segmentation
- Repayment and default analysis
- Business insight generation
- Dashboard development and data storytelling

---

**Project Type:** Data Analytics Portfolio Project
