## duplicados tabela user_info##
 SELECT 
    user_id,
    COUNT(*) AS count
FROM `riscorelativo2025.risco_relativo_projeto3.user_info3`
GROUP BY user_id,
age,
sex,
last_month_salary,
default_flag,
number_dependents
HAVING COUNT(*) > 1;

## duplicados tabela loans_detail ##
 SELECT 
    user_id,
    COUNT(*) AS count
FROM `riscorelativo2025.risco_relativo_projeto3.loans_detail` 
GROUP BY user_id,
more_90_days_overdue,
number_times_delayed_payment_loan_30_59_days,
number_times_delayed_payment_loan_60_89_days,
using_lines_not_secured_personal_assets,
debt_ratio
HAVING COUNT(*) > 1;

## duplicados tabela loans_outstanding ##
 SELECT 
    user_id,
    COUNT(*) AS count
FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding` 
GROUP BY user_id,
loan_id,
loan_type
HAVING COUNT(*) > 1;

## duplicados default_flag tabela user_info ##
 SELECT 
    user_id,
    COUNT(*) AS count
FROM `riscorelativo2025.risco_relativo_projeto3.default`
GROUP BY user_id,
default_flag
HAVING COUNT(*) > 1;