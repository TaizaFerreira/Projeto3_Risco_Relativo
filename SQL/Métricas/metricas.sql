-- Cálculo das Metricas modelo 1 matriz de confusão, corte >=4 --

WITH matriz_confusao AS (
  SELECT
    272 AS verdadeiro_positivo,
    350 AS falso_negativo,
    2151 AS falso_positivo,
    32802 AS verdadeiro_negativo
),

metricas AS (
  SELECT
    verdadeiro_positivo,
    falso_negativo,
    falso_positivo,
    verdadeiro_negativo,
    -- Total de observações
    (verdadeiro_positivo + falso_negativo + falso_positivo + verdadeiro_negativo) AS total,
    
    -- Acurácia
    ROUND( (verdadeiro_positivo + verdadeiro_negativo) * 1.0 / (verdadeiro_positivo + falso_negativo + falso_positivo + verdadeiro_negativo), 4) AS acuracia,
    
    -- Precisão
    ROUND( verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_positivo), 0), 4) AS precisao,
    
    -- Recall (Sensibilidade)
    ROUND( verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_negativo), 0), 4) AS recall,
    
    -- F1 Score
    ROUND( 2 * ( (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_positivo), 0)) * (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_negativo), 0)) ) / 
           NULLIF( ( (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_positivo), 0)) + (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_negativo), 0)) ), 0), 4) AS f1_score
  FROM
    matriz_confusao
)

SELECT * FROM metricas;

----------------------------------------------------

-- Cálculo das Metricas modelo 2 matriz de confusão, corte >=3 --

WITH matriz_confusao AS (
  SELECT
    477 AS verdadeiro_positivo,
    145 AS falso_negativo,
    6938 AS falso_positivo,
    28015 AS verdadeiro_negativo
),

metricas AS (
  SELECT
    verdadeiro_positivo,
    falso_negativo,
    falso_positivo,
    verdadeiro_negativo,
    -- Total de observações
    (verdadeiro_positivo + falso_negativo + falso_positivo + verdadeiro_negativo) AS total,
    
    -- Acurácia
    ROUND( (verdadeiro_positivo + verdadeiro_negativo) * 1.0 / (verdadeiro_positivo + falso_negativo + falso_positivo + verdadeiro_negativo), 4) AS acuracia,
    
    -- Precisão
    ROUND( verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_positivo), 0), 4) AS precisao,
    
    -- Recall (Sensibilidade)
    ROUND( verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_negativo), 0), 4) AS recall,
    
    -- F1 Score
    ROUND( 2 * ( (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_positivo), 0)) * (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_negativo), 0)) ) / 
           NULLIF( ( (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_positivo), 0)) + (verdadeiro_positivo * 1.0 / NULLIF((verdadeiro_positivo + falso_negativo), 0)) ), 0), 4) AS f1_score
  FROM
    matriz_confusao
)

SELECT * FROM metricas;