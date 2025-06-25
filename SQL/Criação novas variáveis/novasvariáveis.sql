## criando novas variáveis qtd_real_state e qtd_other ##

SELECT
  user_id,
  STRING_AGG(CAST(loan_id AS STRING), ', ') AS lista_id_emprestimo,
  SUM(CASE WHEN tipo_emprestimo_padronizado = 'real estate' THEN 1 ELSE 0 END) AS qtd_real_estate,
  SUM(CASE WHEN tipo_emprestimo_padronizado = 'other' THEN 1 ELSE 0 END) AS qtd_other
FROM `riscorelativo2025.risco_relativo_projeto3.loans_outstanding1`
GROUP BY user_id;


