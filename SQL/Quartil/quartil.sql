---Criando quartis das variáveis numéricas---

CREATE OR REPLACE TABLE `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil` AS
SELECT
  *,
  
  -- Quartis
  NTILE(4) OVER (ORDER BY age) AS quartil_age,
  NTILE(4) OVER (ORDER BY last_month_salary) AS quartil_salary,
  NTILE(4) OVER (ORDER BY number_dependents) AS quartil_dependents,
  NTILE(4) OVER (ORDER BY more_90_days_overdue) AS quartil_overdue_90,
  NTILE(4) OVER (ORDER BY number_times_delayed_payment_loan_30_59_days) AS quartil_atraso_30_59,
  NTILE(4) OVER (ORDER BY number_times_delayed_payment_loan_60_89_days) AS quartil_atraso_60_89,
  NTILE(4) OVER (ORDER BY using_lines_not_secured_personal_assets) AS quartil_uso_linhas,
  NTILE(4) OVER (ORDER BY debt_ratio) AS quartil_debt_ratio,
  NTILE(4) OVER (ORDER BY total_emprestimos) AS quartil_total_emprestimos,
  NTILE(4) OVER (ORDER BY qtd_real_estate) AS quartil_imoveis,
  NTILE(4) OVER (ORDER BY qtd_other) AS quartil_outros,
  NTILE(4) OVER (ORDER BY diversidade_tipos) AS quartil_diversidade_credito

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada`
WHERE
  age IS NOT NULL
  AND last_month_salary IS NOT NULL
  AND number_dependents IS NOT NULL
  AND more_90_days_overdue IS NOT NULL
  AND number_times_delayed_payment_loan_30_59_days IS NOT NULL
  AND number_times_delayed_payment_loan_60_89_days IS NOT NULL
  AND using_lines_not_secured_personal_assets IS NOT NULL
  AND debt_ratio IS NOT NULL
  AND total_emprestimos IS NOT NULL
  AND qtd_real_estate IS NOT NULL
  AND qtd_other IS NOT NULL
  AND diversidade_tipos IS NOT NULL;
  
  
  
  
  
  
  
  