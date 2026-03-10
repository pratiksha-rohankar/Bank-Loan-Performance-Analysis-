--All Records in Dataset
SELECT * FROM financial_loan;

--Total Loans Application
SELECT COUNT(*) AS total_loans
FROM financial_loan;

--Total Funded Amount
SELECT SUM(loan_amount) AS total_funded
FROM financial_loan;

--Total Profit
SELECT SUM(total_payment - loan_amount) AS total_profit
FROM financial_loan; 

--Check Average Interest Rate 
SELECT 
ROUND(AVG(int_rate),4) * 100 AS Avg_Interesr_Rate
FROM financial_loan;

-- Preview Loan Issue Date Records
SELECT issue_date 
FROM financial_loan 
LIMIT 5;

--December 2021 Average Interest Rate
SELECT 
ROUND(AVG(int_rate),4) * 100 AS MTD_Avg_Interesr_Rate
FROM financial_loan
WHERE issue_date LIKE '__-12-2021';

--Check Average DTI(Debt-to-Income Ratio) for November 2021
SELECT
ROUND(AVG(dti),4) * 100 AS PMTD_Avg_DTI
FROM financial_loan
WHERE issue_date LIKE '__-11-2021';

--Check Loan Status
SELECT 
loan_status
FROM financial_loan;

--Loan Status Distribution
SELECT
loan_status,
COUNT(*) AS total_loans
FROM financial_loan
GROUP BY loan_status;

--Count Good Loan Applications (Fully Paid + Current)
SELECT
(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)
FROM financial_loan; 

--Count Total Good Loan Applications
SELECT
COUNT(id) AS Good_loan_percentage
FROM financial_loan; 

--Check Good Loan Application Percentage
SELECT
(COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END)*100)
/
COUNT(id) AS Good_loan_percentage
FROM financial_loan;

--Calculate Total Funded Amount for Good Loans
SELECT
SUM(loan_amount) AS Good_Loan_Funded_amount
FROM financial_loan
WHERE loan_status IN ('Fully Paid','Current'); 

--Good Loans Recived Amount
SELECT
SUM(total_payment) AS Good_Loan_amount_recived
FROM financial_loan
WHERE loan_status IN ('Fully Paid','Current');

--Bad Loan Percentage
SELECT
(COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END)*100.0) /
COUNT(id) AS Bad_Loan_Percentage
FROM financial_loan;

--Bad Loab application
SELECT
COUNT(id) AS Bad_Loan_Applications
FROM financial_loan
WHERE loan_status IN ('Charged Off');

--Bad Loan Funded Amount
SELECT
SUM(loan_amount) AS Bad_Loan_Funded_amount
FROM financial_loan
WHERE loan_status IN ('Charged Off');

--Bad Loan Amount Received
SELECT
SUM(total_payment) AS Bad_Loan_amount_received
FROM financial_loan
WHERE loan_status IN ('Charged Off');

--Compare Funded Amount, Payments, Interest Rate and DTI by Loan Status
SELECT
loan_status,
COUNT(id) AS Total_Loan_Applications,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate*100) AS Intrest_Rate,
AVG(dti * 100) AS DTI 
FROM financial_loan
GROUP BY loan_status;

--December Loan Summary by Status
SELECT
loan_status,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM financial_loan
WHERE issue_date LIKE '__-12-____'
GROUP BY loan_status;

--Monthly Loan Performance Summary Report
SELECT 
CASE substr(issue_date, 4, 2)
WHEN '01' THEN 'January'
WHEN '02' THEN 'February'
WHEN '03' THEN 'March'
WHEN '04' THEN 'April'
WHEN '05' THEN 'May'
WHEN '06' THEN 'June'
WHEN '07' THEN 'July'
WHEN '08' THEN 'August'
WHEN '09' THEN 'September'
WHEN '10' THEN 'October'
WHEN '11' THEN 'November'
WHEN '12' THEN 'December'
END AS Month,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Received_Amount
FROM financial_loan
GROUP BY substr(issue_date, 4, 2)
ORDER BY substr(issue_date, 4, 2);

--Regional Analysis By State
SELECT
address_state,
COUNT(id) AS total_Loan_Applicatins,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recieved_Amount
FROM financial_loan
GROUP BY address_state
ORDER BY COUNT(id) DESC;

--Loan Term Analysis
SELECT
term,
COUNT(id) AS total_Loan_Applicatins,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recieved_Amount
FROM financial_loan
GROUP BY term
ORDER BY term;

--Employee Lenght Analysis
SELECT
emp_length,
COUNT(id) AS total_Loan_Applicatins,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recieved_Amount
FROM financial_loan
GROUP BY emp_length
ORDER BY COUNT(id) DESC;
 
--Loan Purpose
SELECT
purpose,
COUNT(id) AS total_Loan_Applicatins,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recieved_Amount
FROM financial_loan
GROUP BY purpose
ORDER BY COUNT(id) DESC;

--Home Ownership Analysis
SELECT
home_ownership,
COUNT(id) AS total_Loan_Applicatins,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Recieved_Amount
FROM financial_loan
GROUP BY home_ownership
ORDER BY COUNT(id) DESC;

