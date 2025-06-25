## tabela temporária quartil ##

WITH base AS (
  SELECT
    user_id,
    age,
    last_month_salary,
    number_times_delayed_payment_loan_30_59_days,
    using_lines_not_secured_personal_assets,
    CASE 
      WHEN number_times_delayed_payment_loan_30_59_days > 0 THEN 1 
      ELSE 0 
    END AS atraso_30_59
  FROM
    `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada` 
),

quartis_idade AS (
  SELECT
    *,
    NTILE(4) OVER (ORDER BY age) AS faixa_etaria
  FROM
    base
),

grupo_risco AS (
  SELECT
    faixa_etaria,
    COUNT(*) AS total_clientes,
    SUM(atraso_30_59) AS total_maus_pagadores,
    AVG(CAST(atraso_30_59 AS FLOAT64)) AS proporcao_mau_pagador,
    ROUND(AVG(last_month_salary), 2) AS media_salario,
    ROUND(AVG(using_lines_not_secured_personal_assets), 2) AS media_linha_credito
  FROM
    quartis_idade
  GROUP BY
    faixa_etaria
),

risco_total AS (
  SELECT
    AVG(CAST(CASE 
      WHEN number_times_delayed_payment_loan_30_59_days > 0 THEN 1 
      ELSE 0 
    END AS FLOAT64)) AS proporcao_geral_mau_pagador
  FROM
    `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada` 
)

SELECT
  g.faixa_etaria,
  g.total_clientes,
  g.total_maus_pagadores,
  ROUND(g.proporcao_mau_pagador, 4) AS proporcao_mau_pagador,
  ROUND(r.proporcao_geral_mau_pagador, 4) AS proporcao_geral_mau_pagador,
  ROUND(SAFE_DIVIDE(g.proporcao_mau_pagador, r.proporcao_geral_mau_pagador), 4) AS risco_relativo,
  g.media_salario,
  g.media_linha_credito
FROM
  grupo_risco g
CROSS JOIN
  risco_total r
ORDER BY
  risco_relativo DESC;
