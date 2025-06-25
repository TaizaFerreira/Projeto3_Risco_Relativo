-- MODELO 1 - Matriz de confusão nota de corte >=4 --

WITH dados_para_score_base AS (
  SELECT
    user_id,
    default_flag,

    -- Dummies de alto risco
    IF(quartil_salary = 1, 1, 0) AS dummy_salario_q1,
    IF(quartil_age = 1, 1, 0) AS dummy_idade_q1,
    IF(quartil_dependents = 4, 1, 0) AS dummy_dependents_q4,
    IF(quartil_atraso_30_59 = 4, 1, 0) AS dummy_atraso_30_59_q4,
    IF(quartil_uso_linhas = 4, 1, 0) AS dummy_uso_linhas_q4,
    IF(quartil_debt_ratio = 3, 1, 0) AS dummy_debt_ratio_q3

  FROM
    `riscorelativo2025.risco_relativo_projeto3.score_risco_final`
  WHERE
    default_flag IS NOT NULL
),

score_por_cliente AS (
  SELECT
    *,
    (
      dummy_salario_q1 +
      dummy_idade_q1 +
      dummy_dependents_q4 +
      dummy_atraso_30_59_q4 +
      dummy_uso_linhas_q4 +
      dummy_debt_ratio_q3
    ) AS score_risco
  FROM
    dados_para_score_base
),

previsao_por_cliente AS (
  SELECT
    *,
    CASE
      WHEN score_risco >= 4 THEN 1
      ELSE 0
    END AS previsao_inadimplente
  FROM
    score_por_cliente
),

matriz_confusao AS (
  SELECT
    default_flag AS real_inadimplente,
    previsao_inadimplente,
    COUNT(*) AS quantidade_clientes
  FROM
    previsao_por_cliente
  GROUP BY
    real_inadimplente, previsao_inadimplente
)

SELECT
  MAX(CASE WHEN real_inadimplente = 1 AND previsao_inadimplente = 1 THEN quantidade_clientes END) AS verdadeiro_positivo,
  MAX(CASE WHEN real_inadimplente = 1 AND previsao_inadimplente = 0 THEN quantidade_clientes END) AS falso_negativo,
  MAX(CASE WHEN real_inadimplente = 0 AND previsao_inadimplente = 1 THEN quantidade_clientes END) AS falso_positivo,
  MAX(CASE WHEN real_inadimplente = 0 AND previsao_inadimplente = 0 THEN quantidade_clientes END) AS verdadeiro_negativo
FROM
  matriz_confusao;


  -----------------------------------------------------------------

  -- MODELO 2 - Matriz de confusão nota de corte >=3 --

  WITH dados_para_score_base AS (
  SELECT
    user_id,
    default_flag,

    -- Dummies de alto risco
    IF(quartil_salary = 1, 1, 0) AS dummy_salario_q1,
    IF(quartil_age = 1, 1, 0) AS dummy_idade_q1,
    IF(quartil_dependents = 4, 1, 0) AS dummy_dependents_q4,
    IF(quartil_atraso_30_59 = 4, 1, 0) AS dummy_atraso_30_59_q4,
    IF(quartil_uso_linhas = 4, 1, 0) AS dummy_uso_linhas_q4,
    IF(quartil_debt_ratio = 3, 1, 0) AS dummy_debt_ratio_q3

  FROM
    `riscorelativo2025.risco_relativo_projeto3.score_risco_final`
  WHERE
    default_flag IS NOT NULL
),

score_por_cliente AS (
  SELECT
    *,
    (
      dummy_salario_q1 +
      dummy_idade_q1 +
      dummy_dependents_q4 +
      dummy_atraso_30_59_q4 +
      dummy_uso_linhas_q4 +
      dummy_debt_ratio_q3
    ) AS score_risco
  FROM
    dados_para_score_base
),

previsao_por_cliente AS (
  SELECT
    *,
    CASE
      WHEN score_risco >= 3 THEN 1
      ELSE 0
    END AS previsao_inadimplente
  FROM
    score_por_cliente
),

matriz_confusao AS (
  SELECT
    default_flag AS real_inadimplente,
    previsao_inadimplente,
    COUNT(*) AS quantidade_clientes
  FROM
    previsao_por_cliente
  GROUP BY
    real_inadimplente, previsao_inadimplente
)

SELECT
  MAX(CASE WHEN real_inadimplente = 1 AND previsao_inadimplente = 1 THEN quantidade_clientes END) AS verdadeiro_positivo,
  MAX(CASE WHEN real_inadimplente = 1 AND previsao_inadimplente = 0 THEN quantidade_clientes END) AS falso_negativo,
  MAX(CASE WHEN real_inadimplente = 0 AND previsao_inadimplente = 1 THEN quantidade_clientes END) AS falso_positivo,
  MAX(CASE WHEN real_inadimplente = 0 AND previsao_inadimplente = 0 THEN quantidade_clientes END) AS verdadeiro_negativo
FROM
  matriz_confusao;