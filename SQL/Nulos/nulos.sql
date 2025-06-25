## nulos idade ##
SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.user_info` 
 WHERE age IS NULL

## debt_ratio ##
SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.loans_detail` 
 WHERE debt_ratio IS NULL

## last_month_salary ##
SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.user_info`
 WHERE last_month_salary IS NULL

 ## loan_id ##
 SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding` 
 WHERE loan_id IS NULL

 ## loan_type ##
 SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding` 
 WHERE loan_type IS NULL

 ## more_90_days_overdue
 SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.loans_detail` 
 WHERE more_90_days_overdue IS NULL

 ## number_dependents ##
 SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.user_info`
 WHERE number_dependents IS NULL

 ## number_times_delayed_payment_loan_30_59_days ##
 SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.loans_detail` 
 WHERE number_times_delayed_payment_loan_30_59_days IS NULL

 ## number_times_delayed_payment_loan_60_89_days ##
 SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.loans_detail` 
 WHERE number_times_delayed_payment_loan_60_89_days IS NULL

## sex ##
SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.user_info`
 WHERE sex IS NULL

## user_id ##
SELECT *
 FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding` 
 WHERE user_id IS NULL