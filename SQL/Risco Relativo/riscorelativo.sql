## Risco relativo idade ##

SELECT

  -- Taxa de inadimplência do Quartil 1
  ROUND(
    SUM(CASE WHEN quartil_age = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_age = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  -- Taxa de inadimplência do Quartil 2
  ROUND(
    SUM(CASE WHEN quartil_age = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_age = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  -- Taxa de inadimplência do Quartil 3
  ROUND(
    SUM(CASE WHEN quartil_age = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_age = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  -- Taxa de inadimplência do Quartil 4
  ROUND(
    SUM(CASE WHEN quartil_age = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_age = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo do Q1
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_age = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_age IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  -- Risco relativo do Q2
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_age = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_age IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  -- Risco relativo do Q3
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_age = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_age IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  -- Risco relativo do Q4
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_age = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_age IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_age IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_age IS NOT NULL
  AND default_flag IS NOT NULL;


***************************************
## Salário ##

SELECT

  -- Taxa de inadimplência por quartil de salário
  ROUND(
    SUM(CASE WHEN quartil_salary = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_salary = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_salary = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_salary = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_salary = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_salary = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_salary = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_salary = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil (comparado com os demais)
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_salary = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_salary IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_salary = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_salary IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_salary = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_salary IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_salary = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_salary IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_salary IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_salary IS NOT NULL
  AND default_flag IS NOT NULL;

****************************************

## Número de dependentes ##

SELECT

  -- Taxa de inadimplência por quartil de dependentes
  ROUND(
    SUM(CASE WHEN quartil_dependents = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_dependents = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_dependents = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_dependents = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_dependents = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_dependents = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_dependents = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_dependents = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_dependents = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_dependents IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_dependents = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_dependents IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_dependents = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_dependents IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_dependents = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_dependents IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_dependents IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_dependents IS NOT NULL
  AND default_flag IS NOT NULL;

*****************************************

## atraso mais que 90 dias ##

SELECT 

  -- Taxa de inadimplência por quartil de atraso acima de 90 dias
  ROUND(
    SUM(CASE WHEN quartil_overdue_90 = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_overdue_90 = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_overdue_90 = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_overdue_90 = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_overdue_90 = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_overdue_90 = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_overdue_90 = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_overdue_90 = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_overdue_90 = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_overdue_90 IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_overdue_90 = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_overdue_90 IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_overdue_90 = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_overdue_90 IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_overdue_90 = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_overdue_90 IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_overdue_90 IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_overdue_90 IS NOT NULL
  AND default_flag IS NOT NULL;

******************************************

## atraso de 30 a 59 dias ##

SELECT 

  -- Taxa de inadimplência por quartil de atraso de 30 a 59 dias
  ROUND(
    SUM(CASE WHEN quartil_atraso_30_59 = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_atraso_30_59 = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_atraso_30_59 = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_atraso_30_59 = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_30_59 = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_30_59 IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_30_59 = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_30_59 IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_30_59 = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_30_59 IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_30_59 = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_30_59 IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_30_59 IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_atraso_30_59 IS NOT NULL
  AND default_flag IS NOT NULL;

*******************************************

## atraso de 60 a 89 dias ##

SELECT 

  -- Taxa de inadimplência por quartil de atraso de 60 a 89 dias
  ROUND(
    SUM(CASE WHEN quartil_atraso_60_89 = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_atraso_60_89 = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_atraso_60_89 = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_atraso_60_89 = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_60_89 = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_60_89 IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_60_89 = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_60_89 IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_60_89 = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_60_89 IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_atraso_60_89 = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_atraso_60_89 IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_atraso_60_89 IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_atraso_60_89 IS NOT NULL
  AND default_flag IS NOT NULL;

*******************************************

## uso de linhas de créditos não seguras ##

SELECT 

  -- Taxa de inadimplência por quartil de uso de linhas de crédito
  ROUND(
    SUM(CASE WHEN quartil_uso_linhas = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_uso_linhas = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_uso_linhas = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_uso_linhas = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_uso_linhas = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_uso_linhas = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_uso_linhas = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_uso_linhas = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_uso_linhas = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_uso_linhas IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_uso_linhas = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_uso_linhas IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_uso_linhas = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_uso_linhas IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_uso_linhas = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_uso_linhas IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_uso_linhas IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_uso_linhas IS NOT NULL
  AND default_flag IS NOT NULL;

*******************************************

## debt_ratio ##

SELECT 

  -- Taxa de inadimplência por quartil de debt_ratio
  ROUND(
    SUM(CASE WHEN quartil_debt_ratio = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_debt_ratio = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_debt_ratio = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_debt_ratio = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_debt_ratio = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_debt_ratio = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_debt_ratio = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_debt_ratio = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_debt_ratio = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_debt_ratio IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_debt_ratio = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_debt_ratio IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_debt_ratio = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_debt_ratio IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_debt_ratio = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_debt_ratio IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_debt_ratio IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_debt_ratio IS NOT NULL
  AND default_flag IS NOT NULL;

*******************************************

## total de empréstimos ##

SELECT 

  -- Taxa de inadimplência por quartil de total de empréstimos
  ROUND(
    SUM(CASE WHEN quartil_total_emprestimos = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_total_emprestimos = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_total_emprestimos = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_total_emprestimos = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_total_emprestimos = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_total_emprestimos IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_total_emprestimos = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_total_emprestimos IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_total_emprestimos = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_total_emprestimos IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_total_emprestimos = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_total_emprestimos IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_total_emprestimos IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_total_emprestimos IS NOT NULL
  AND default_flag IS NOT NULL;

****************************************

## empréstimo imobiliário ##

SELECT 

  -- Taxa de inadimplência por quartil de imóveis
  ROUND(
    SUM(CASE WHEN quartil_imoveis = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_imoveis = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_imoveis = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_imoveis = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_imoveis = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_imoveis = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_imoveis = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_imoveis = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_imoveis = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_imoveis IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_imoveis = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_imoveis IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_imoveis = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_imoveis IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_imoveis = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_imoveis IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_imoveis IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_imoveis IS NOT NULL
  AND default_flag IS NOT NULL;

 ******************************************

## empréstimos outros ##

SELECT 

  -- Taxa de inadimplência por quartil de outros bens
  ROUND(
    SUM(CASE WHEN quartil_outros = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_outros = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_outros = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_outros = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_outros = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_outros = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_outros = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_outros = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_outros = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_outros IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_outros = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_outros IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_outros = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_outros IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_outros = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_outros IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_outros IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_outros IS NOT NULL
  AND default_flag IS NOT NULL;

*************************************

## diversidade de tipos ##

SELECT 

  -- Taxa de inadimplência por quartil de diversidade de crédito
  ROUND(
    SUM(CASE WHEN quartil_diversidade_credito = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 1 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q1,

  ROUND(
    SUM(CASE WHEN quartil_diversidade_credito = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 2 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q2,

  ROUND(
    SUM(CASE WHEN quartil_diversidade_credito = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 3 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q3,

  ROUND(
    SUM(CASE WHEN quartil_diversidade_credito = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 100 /
    NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 4 THEN 1 ELSE 0 END), 0), 2
  ) AS taxa_inadimplencia_q4,

  -- Risco relativo por quartil
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_diversidade_credito = 1 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 1 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_diversidade_credito IN (2, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito IN (2, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q1,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_diversidade_credito = 2 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 2 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_diversidade_credito IN (1, 3, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito IN (1, 3, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q2,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_diversidade_credito = 3 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 3 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_diversidade_credito IN (1, 2, 4) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito IN (1, 2, 4) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q3,

  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN quartil_diversidade_credito = 4 AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito = 4 THEN 1 ELSE 0 END), 0),
      SUM(CASE WHEN quartil_diversidade_credito IN (1, 2, 3) AND default_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
      NULLIF(SUM(CASE WHEN quartil_diversidade_credito IN (1, 2, 3) THEN 1 ELSE 0 END), 0)
    ), 2
  ) AS risco_relativo_q4

FROM
  `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_quartil`
WHERE
  quartil_diversidade_credito IS NOT NULL
  AND default_flag IS NOT NULL;


