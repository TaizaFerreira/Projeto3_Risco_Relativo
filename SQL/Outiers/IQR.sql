## tabela loans_detail utilizado intervalo interquartil (IQR) para encontrar os outliers ##

-- Etapa 1: Calcula Q1 e Q3 para cada coluna
WITH estatisticas AS (
  SELECT
    APPROX_QUANTILES(more_90_days_overdue, 4)[OFFSET(1)] AS q1_90,
    APPROX_QUANTILES(more_90_days_overdue, 4)[OFFSET(3)] AS q3_90,

    APPROX_QUANTILES(using_lines_not_secured_personal_assets, 4)[OFFSET(1)] AS q1_lines,
    APPROX_QUANTILES(using_lines_not_secured_personal_assets, 4)[OFFSET(3)] AS q3_lines,

    APPROX_QUANTILES(number_times_delayed_payment_loan_30_59_days, 4)[OFFSET(1)] AS q1_30,
    APPROX_QUANTILES(number_times_delayed_payment_loan_30_59_days, 4)[OFFSET(3)] AS q3_30,

    APPROX_QUANTILES(debt_ratio, 4)[OFFSET(1)] AS q1_debt,
    APPROX_QUANTILES(debt_ratio, 4)[OFFSET(3)] AS q3_debt,

    APPROX_QUANTILES(number_times_delayed_payment_loan_60_89_days, 4)[OFFSET(1)] AS q1_60,
    APPROX_QUANTILES(number_times_delayed_payment_loan_60_89_days, 4)[OFFSET(3)] AS q3_60
  FROM `riscorelativo2025.risco_relativo_projeto3.loans_detail`
),

-- Etapa 2: Calcula o IQR e junta com os dados
base AS (
  SELECT 
    ld.*,
    e.q1_90, e.q3_90, e.q3_90 - e.q1_90 AS iqr_90,
    e.q1_lines, e.q3_lines, e.q3_lines - e.q1_lines AS iqr_lines,
    e.q1_30, e.q3_30, e.q3_30 - e.q1_30 AS iqr_30,
    e.q1_debt, e.q3_debt, e.q3_debt - e.q1_debt AS iqr_debt,
    e.q1_60, e.q3_60, e.q3_60 - e.q1_60 AS iqr_60
  FROM `riscorelativo2025.risco_relativo_projeto3.loans_detail` ld
  CROSS JOIN estatisticas e
)

-- Etapa 3: Verifica se está fora do intervalo esperado (outlier)
SELECT
  user_id,
  more_90_days_overdue,
  CASE
    WHEN more_90_days_overdue < (q1_90 - 1.5 * iqr_90) OR more_90_days_overdue > (q3_90 + 1.5 * iqr_90) THEN 'Outlier'
    ELSE 'Normal'
  END AS status_90_days,

  using_lines_not_secured_personal_assets,
  CASE
    WHEN using_lines_not_secured_personal_assets < (q1_lines - 1.5 * iqr_lines) OR using_lines_not_secured_personal_assets > (q3_lines + 1.5 * iqr_lines) THEN 'Outlier'
    ELSE 'Normal'
  END AS status_lines,

  number_times_delayed_payment_loan_30_59_days,
  CASE
    WHEN number_times_delayed_payment_loan_30_59_days < (q1_30 - 1.5 * iqr_30) OR number_times_delayed_payment_loan_30_59_days > (q3_30 + 1.5 * iqr_30) THEN 'Outlier'
    ELSE 'Normal'
  END AS status_30,

  debt_ratio,
  CASE
    WHEN debt_ratio < (q1_debt - 1.5 * iqr_debt) OR debt_ratio > (q3_debt + 1.5 * iqr_debt) THEN 'Outlier'
    ELSE 'Normal'
  END AS status_debt,

  number_times_delayed_payment_loan_60_89_days,
  CASE
    WHEN number_times_delayed_payment_loan_60_89_days < (q1_60 - 1.5 * iqr_60) OR number_times_delayed_payment_loan_60_89_days > (q3_60 + 1.5 * iqr_60) THEN 'Outlier'
    ELSE 'Normal'
  END AS status_60

FROM base;
