## Dados sem user_id ##

SELECT DISTINCT base.user_id
FROM `riscorelativo2025.risco_relativo_projeto3.user_info3` AS base
LEFT JOIN (
  SELECT DISTINCT user_id
  FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding2`
) AS loans
ON base.user_id = loans.user_id
WHERE loans.user_id IS NULL;


## Listados em todas as tabelas com o JOIN ##

WITH ids_sem_emprestimo AS (
  SELECT DISTINCT ui.user_id
  FROM `riscorelativo2025.risco_relativo_projeto3.user_info3` AS ui
  LEFT JOIN (
    SELECT DISTINCT user_id
    FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding2`
  ) AS lo
  ON ui.user_id = lo.user_id
  WHERE lo.user_id IS NULL
)

SELECT 
  f.user_id,
  
  -- Dados do perfil do usuário
  ui.age,
  ui.sex,
  ui.last_month_salary,
  ui.default_flag,
  ui.number_dependents,

  -- Dados de comportamento de crédito
  ld.more_90_days_overdue,
  ld.number_times_delayed_payment_loan_30_59_days,
  ld.number_times_delayed_payment_loan_60_89_days,
  ld.using_lines_not_secured_personal_assets,

  -- Coluna lista_loans convertida para inteiro e tratada
  CASE 
    WHEN SAFE_CAST(lo.lista_loans AS INT64) IS NULL OR SAFE_CAST(lo.lista_loans AS INT64) = 0 THEN NULL
    ELSE SAFE_CAST(lo.lista_loans AS INT64)
  END AS lista_loans

FROM ids_sem_emprestimo AS f

LEFT JOIN `riscorelativo2025.risco_relativo_projeto3.user_info3` AS ui
  ON f.user_id = ui.user_id

LEFT JOIN `riscorelativo2025.risco_relativo_projeto3.loans_detail` AS ld
  ON f.user_id = ld.user_id

LEFT JOIN `riscorelativo2025.risco_relativo_projeto3.loans_outstanding2` AS lo
  ON f.user_id = lo.user_id

