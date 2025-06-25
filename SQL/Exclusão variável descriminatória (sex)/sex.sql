## exclusão de variável sex por ser descriminatória ##
CREATE OR REPLACE TABLE `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada_1` AS
SELECT *
EXCEPT (sex)
 FROM `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada`