-- ## criação de dummys nota de corte >=4 ## --

CREATE OR REPLACE TABLE `riscorelativo2025.risco_relativo_projeto3.score_risco_final` AS

SELECT
  *,

  -- Criação das dummies
  IF(quartil_age = 1, 1, 0) AS dummy_risco_idade,
  IF(quartil_salary = 1, 1, 0) AS dummy_risco_salario,
  IF(quartil_dependents = 4, 1, 0) AS dummy_risco_dependentes,
  IF(quartil_atraso_30_59 = 4, 1, 0) AS dummy_risco_atraso_30_59,
  IF(quartil_atraso_60_89 = 4, 1, 0) AS dummy_risco_atraso_60_89,
  IF(quartil_overdue_90 = 4, 1, 0) AS dummy_risco_overdue_90,
  IF(quartil_uso_linhas = 4, 1, 0) AS dummy_risco_uso_linhas,
  IF(quartil_debt_ratio = 3, 1, 0) AS dummy_risco_debt_ratio, 
  IF(quartil_total_emprestimos = 1, 1, 0) AS dummy_risco_total_emprestimos,
  IF(quartil_imoveis = 1, 1, 0) AS dummy_risco_imoveis,
  IF(quartil_outros = 1, 1, 0) AS dummy_risco_outros,
  IF(quartil_diversidade_credito = 1, 1, 0) AS dummy_risco_diversidade_credito,

  -- Pontuação total de risco
  (
    IF(quartil_age = 1, 1, 0) +
    IF(quartil_salary = 1, 1, 0) +
    IF(quartil_dependents = 4, 1, 0) +
    IF(quartil_atraso_30_59 = 4, 1, 0) +
    IF(quartil_atraso_60_89 = 4, 1, 0) +
    IF(quartil_overdue_90 = 4, 1, 0) +
    IF(quartil_uso_linhas = 4, 1, 0) +
    IF(quartil_debt_ratio = 3, 1, 0) +
    IF(quartil_total_emprestimos = 1, 1, 0) +
    IF(quartil_imoveis = 1, 1, 0) +
    IF(quartil_outros = 1, 1, 0) +
    IF(quartil_diversidade_credito = 1, 1, 0)
  ) AS score_risco,

  -- Classificação final: 1 = previsto inadimplente, 0 = bom pagador
  IF(
    (
      IF(quartil_age = 1, 1, 0) +
      IF(quartil_salary = 1, 1, 0) +
      IF(quartil_dependents = 4, 1, 0) +
      IF(quartil_atraso_30_59 = 4, 1, 0) +
      IF(quartil_atraso_60_89 = 4, 1, 0) +
      IF(quartil_overdue_90 = 4, 1, 0) +
      IF(quartil_uso_linhas = 4, 1, 0) +
      IF(quartil_debt_ratio = 3, 1, 0) +
      IF(quartil_total_emprestimos = 1, 1, 0) +
      IF(quartil_imoveis = 1, 1, 0) +
      IF(quartil_outros = 1, 1, 0) +
      IF(quartil_diversidade_credito = 1, 1, 0)
    ) >= 4, 1, 0
  ) AS previsao_inadimplente

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`;

-----------------------------------------------------

-- ## criação de dummys nota de corte >=3 ## --

CREATE OR REPLACE TABLE `riscorelativo2025.risco_relativo_projeto3.score_risco_final` AS

SELECT
  *,

  -- Criação das dummies
  IF(quartil_age = 1, 1, 0) AS dummy_risco_idade,
  IF(quartil_salary = 1, 1, 0) AS dummy_risco_salario,
  IF(quartil_dependents = 4, 1, 0) AS dummy_risco_dependentes,
  IF(quartil_atraso_30_59 = 4, 1, 0) AS dummy_risco_atraso_30_59,
  IF(quartil_atraso_60_89 = 4, 1, 0) AS dummy_risco_atraso_60_89,
  IF(quartil_overdue_90 = 4, 1, 0) AS dummy_risco_overdue_90,
  IF(quartil_uso_linhas = 4, 1, 0) AS dummy_risco_uso_linhas,
  IF(quartil_debt_ratio = 3, 1, 0) AS dummy_risco_debt_ratio, 
  IF(quartil_total_emprestimos = 1, 1, 0) AS dummy_risco_total_emprestimos,
  IF(quartil_imoveis = 1, 1, 0) AS dummy_risco_imoveis,
  IF(quartil_outros = 1, 1, 0) AS dummy_risco_outros,
  IF(quartil_diversidade_credito = 1, 1, 0) AS dummy_risco_diversidade_credito,

  -- Pontuação total de risco
  (
    IF(quartil_age = 1, 1, 0) +
    IF(quartil_salary = 1, 1, 0) +
    IF(quartil_dependents = 4, 1, 0) +
    IF(quartil_atraso_30_59 = 4, 1, 0) +
    IF(quartil_atraso_60_89 = 4, 1, 0) +
    IF(quartil_overdue_90 = 4, 1, 0) +
    IF(quartil_uso_linhas = 4, 1, 0) +
    IF(quartil_debt_ratio = 3, 1, 0) +
    IF(quartil_total_emprestimos = 1, 1, 0) +
    IF(quartil_imoveis = 1, 1, 0) +
    IF(quartil_outros = 1, 1, 0) +
    IF(quartil_diversidade_credito = 1, 1, 0)
  ) AS score_risco,

  -- Classificação final com corte em >= 3
  IF(
    (
      IF(quartil_age = 1, 1, 0) +
      IF(quartil_salary = 1, 1, 0) +
      IF(quartil_dependents = 4, 1, 0) +
      IF(quartil_atraso_30_59 = 4, 1, 0) +
      IF(quartil_atraso_60_89 = 4, 1, 0) +
      IF(quartil_overdue_90 = 4, 1, 0) +
      IF(quartil_uso_linhas = 4, 1, 0) +
      IF(quartil_debt_ratio = 3, 1, 0) +
      IF(quartil_total_emprestimos = 1, 1, 0) +
      IF(quartil_imoveis = 1, 1, 0) +
      IF(quartil_outros = 1, 1, 0) +
      IF(quartil_diversidade_credito = 1, 1, 0)
    ) >= 3, 1, 0
  ) AS previsao_inadimplente

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`;


