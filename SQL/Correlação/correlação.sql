## calculando correlação entre as variáveis numéricas ##

SELECT
  CORR(age, number_times_delayed_payment_loan_30_59_days) AS corr_idade,
  CORR(last_month_salary, number_times_delayed_payment_loan_30_59_days) AS corr_salario,
  CORR(using_lines_not_secured_personal_assets, number_times_delayed_payment_loan_30_59_days) AS corr_linha_credito
FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada`
WHERE
  number_times_delayed_payment_loan_30_59_days IS NOT NULL
  AND last_month_salary IS NOT NULL
  AND age IS NOT NULL
  AND using_lines_not_secured_personal_assets IS NOT NULL;

**********************************
  SELECT
  CORR(number_dependents, number_times_delayed_payment_loan_30_59_days) AS corr_dependentes,
  CORR(more_90_days_overdue, number_times_delayed_payment_loan_30_59_days) AS corr_90dias,
  CORR(number_times_delayed_payment_loan_60_89_days, number_times_delayed_payment_loan_30_59_days) AS corr_60_89,
  CORR(debt_ratio, number_times_delayed_payment_loan_30_59_days) AS corr_debt_ratio,
  CORR(total_emprestimos, number_times_delayed_payment_loan_30_59_days) AS corr_total_emprestimos,
  CORR(qtd_real_estate, number_times_delayed_payment_loan_30_59_days) AS corr_imoveis,
  CORR(qtd_other, number_times_delayed_payment_loan_30_59_days) AS corr_outros,
  CORR(diversidade_tipos, number_times_delayed_payment_loan_30_59_days) AS corr_diversidade
FROM
  sua_tabela
WHERE
  number_times_delayed_payment_loan_30_59_days IS NOT NULL
  AND more_90_days_overdue IS NOT NULL
  AND number_times_delayed_payment_loan_60_89_days IS NOT NULL
  AND debt_ratio IS NOT NULL
  AND total_emprestimos IS NOT NULL
  AND qtd_real_estate IS NOT NULL
  AND qtd_other IS NOT NULL
  AND diversidade_tipos IS NOT NULL;
