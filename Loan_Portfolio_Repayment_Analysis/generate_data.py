from pathlib import Path
import pandas as pd
import random
from datetime import datetime, timedelta

random.seed(42)

# Generate 300 customers

first_names = [
    "Aarav", "Priya", "Rohan", "Ananya", "Rahul",
    "Sneha", "Karan", "Isha", "Aditya", "Neha",
    "Vikram", "Pooja", "Arjun", "Meera", "Kabir"
]

last_names = [
    "Sharma", "Patel", "Mehta", "Desai", "Kulkarni",
    "Joshi", "Shah", "Verma", "Nair", "Reddy",
    "Gupta", "Iyer", "Malhotra", "Singh", "Pillai"
]

cities = [
    "Mumbai", "Pune", "Navi Mumbai", "Thane",
    "Bengaluru", "Delhi", "Hyderabad", "Chennai",
    "Ahmedabad", "Kolkata", "Nagpur", "Nashik"
]

customers = []

for i in range(1, 301):
    customer = {
        "Customer_ID": f"C{i:03d}",
        "Customer_Name": f"{random.choice(first_names)} {random.choice(last_names)}",
        "City": random.choice(cities),
        "Age": random.randint(21, 65),
        "Customer_Since": (
            datetime(2022, 1, 1) +
            timedelta(days=random.randint(0, 1700))
        ).date()
    }

    customers.append(customer)

customers_df = pd.DataFrame(customers)

#customers_df.to_csv("data/customers.csv", index=False)
project_folder = Path(__file__).resolve().parent
data_folder = project_folder / "data"
customers_df.to_csv(data_folder / "customers.csv", index=False)

print("Customers dataset generated successfully!")
print(customers_df.head())
print("Total customers:", len(customers_df))

# Generate 500 loans

loan_types = ["Personal", "Home", "Business", "Vehicle", "Education"]

loan_amount_ranges = {
    "Personal": (20000, 300000),
    "Home": (500000, 5000000),
    "Business": (100000, 2000000),
    "Vehicle": (100000, 1500000),
    "Education": (50000, 1000000)
}

interest_rates = {
    "Personal": (10, 18),
    "Home": (7, 10),
    "Business": (11, 17),
    "Vehicle": (8, 14),
    "Education": (6, 12)
}

loan_terms = [12, 24, 36, 60, 120, 240]

loan_statuses = ["Active", "Closed", "Defaulted"]

customer_dates = dict(zip(
    customers_df["Customer_ID"],
    customers_df["Customer_Since"]
))

loans = []

start_date = datetime(2025, 11, 26)
end_date = datetime(2026, 11, 25)

for i in range(1, 501):

    customer_id = random.choice(list(customer_dates.keys()))

    loan_type = random.choice(loan_types)

    min_amount, max_amount = loan_amount_ranges[loan_type]
    min_rate, max_rate = interest_rates[loan_type]

    earliest_date = max(
        start_date,
        datetime.combine(customer_dates[customer_id], datetime.min.time())
    )

    loan_date = earliest_date + timedelta(
        days=random.randint(0, (end_date - earliest_date).days)
    )

    loan = {
        "Loan_ID": f"L{i:03d}",
        "Customer_ID": customer_id,
        "Loan_Type": loan_type,
        "Loan_Amount": round(random.uniform(min_amount, max_amount), 2),
        "Interest_Rate": round(random.uniform(min_rate, max_rate), 2),
        "Loan_Date": loan_date.date(),
        "Loan_Term_Months": random.choice(loan_terms),
        "Loan_Status": random.choices(
            loan_statuses,
            weights=[75, 20, 5]
        )[0]
    }

    loans.append(loan)

loans_df = pd.DataFrame(loans)

loans_df.to_csv(data_folder / "loans.csv", index=False)

print("\nLoans dataset generated successfully!")
print(loans_df.head())
print("Total loans:", len(loans_df))

# Generate 1,200 payment records

payments = []

as_of_date = datetime(2026, 11, 25)

for i in range(1, 1201):

    loan = random.choice(loans)

    loan_date = datetime.combine(
        loan["Loan_Date"], datetime.min.time()
    )

    # Generate an installment number
    installment = random.randint(1, 12)

    due_date = loan_date + timedelta(days=30 * installment)

    # Calculate approximate monthly installment (EMI)
    principal = loan["Loan_Amount"]
    monthly_rate = loan["Interest_Rate"] / 1200
    months = loan["Loan_Term_Months"]

    if monthly_rate > 0:
        emi = (
            principal * monthly_rate *
            (1 + monthly_rate) ** months
        ) / ((1 + monthly_rate) ** months - 1)
    else:
        emi = principal / months

    amount_due = round(emi, 2)

    # Assign payment status based on due date
    if due_date > as_of_date:
        status = "Pending"
    else:
        status = random.choices(
            ["Paid", "Partial", "Overdue"],
            weights=[70, 15, 15]
        )[0]

    if status == "Paid":
        amount_paid = amount_due
        payment_date = due_date + timedelta(
            days=random.randint(-5, 15)
        )

    elif status == "Partial":
        amount_paid = round(
            amount_due * random.uniform(0.2, 0.8), 2
        )
        payment_date = due_date + timedelta(
            days=random.randint(-3, 15)
        )

    else:
        amount_paid = 0
        payment_date = None

    # Prevent payment dates from going beyond the reporting date
    if payment_date and payment_date > as_of_date:
        payment_date = as_of_date

    payment = {
        "Payment_ID": f"P{i:04d}",
        "Loan_ID": loan["Loan_ID"],
        "Due_Date": due_date.date(),
        "Payment_Date": payment_date.date() if payment_date else None,
        "Amount_Due": amount_due,
        "Amount_Paid": amount_paid,
        "Payment_Status": status
    }

    payments.append(payment)

payments_df = pd.DataFrame(payments)

payments_df.to_csv(data_folder / "payments.csv", index=False)

print("\nPayments dataset generated successfully!")
print(payments_df.head())
print("Total payments:", len(payments_df))
print("\nPayment status distribution:")
print(payments_df["Payment_Status"].value_counts())

# Dataset validation

print("\n--- DATASET VALIDATION ---")

print("Customers:", len(customers_df))
print("Loans:", len(loans_df))
print("Payments:", len(payments_df))

print("\nMissing values:")
print("Customers:", customers_df.isnull().sum().sum())
print("Loans:", loans_df.isnull().sum().sum())
print("Payments:", payments_df.isnull().sum().sum())

print("\nUnique IDs:")
print("Customers:", customers_df["Customer_ID"].nunique())
print("Loans:", loans_df["Loan_ID"].nunique())
print("Payments:", payments_df["Payment_ID"].nunique())

print("\nRelationship checks:")
print(
    "Loans with invalid customers:",
    (~loans_df["Customer_ID"].isin(customers_df["Customer_ID"])).sum()
)
print(
    "Payments with invalid loans:",
    (~payments_df["Loan_ID"].isin(loans_df["Loan_ID"])).sum()
)
print("\nUnique IDs:")
print("Customers:", customers_df["Customer_ID"].nunique())
print("Loans:", loans_df["Loan_ID"].nunique())
print("Payments:", payments_df["Payment_ID"].nunique())

print("\nPayment dates by status:")
print(
    payments_df.groupby("Payment_Status")["Payment_Date"]
    .apply(lambda x: x.isnull().sum())
)