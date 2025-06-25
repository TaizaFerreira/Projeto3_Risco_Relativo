## Construindo tabelas auxiliares##

-- Etapa 1: Agregando dados de empréstimos
WITH emprestimos_agrupados AS (
  SELECT
    user_id,
    COUNT(*) AS total_emprestimos,
    SUM(CASE WHEN LOWER(TRIM(tipo_emprestimo_padronizado)) = 'real estate' THEN 1 ELSE 0 END) AS qtd_real_estate,
    SUM(CASE WHEN LOWER(TRIM(tipo_emprestimo_padronizado)) = 'other' THEN 1 ELSE 0 END) AS qtd_other,
    COUNT(DISTINCT LOWER(TRIM(tipo_emprestimo_padronizado))) AS diversidade_tipos
  FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding1`
  GROUP BY user_id
)

-- Etapa 2: Unificando com outras tabelas
SELECT 
  ui.user_id,
  ui.age,
  ui.sex,
  ui.last_month_salary,
  ui.default_flag,
  ui.number_dependents,
  
  ld.more_90_days_overdue,
  ld.number_times_delayed_payment_loan_30_59_days,
  ld.number_times_delayed_payment_loan_60_89_days,
  ld.using_lines_not_secured_personal_assets,
  ld.debt_ratio,

  ea.total_emprestimos,
  ea.qtd_real_estate,
  ea.qtd_other,
  ea.diversidade_tipos

FROM `riscorelativo2025.risco_relativo_projeto3.user_info3` AS ui
LEFT JOIN `riscorelativo2025.risco_relativo_projeto3.loans_detail` AS ld
  ON ui.user_id = ld.user_id
LEFT JOIN emprestimos_agrupados AS ea
  ON ui.user_id = ea.user_id;