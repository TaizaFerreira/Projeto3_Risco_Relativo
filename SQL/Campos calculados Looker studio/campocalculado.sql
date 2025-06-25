--## criação de campos calculados no Looker Studio para criação de variáveis ##--

--## faixa_emprestimo##
CASE
  WHEN total_emprestimos = 0 THEN "Nenhum"
  WHEN total_emprestimos = 1 THEN "1 Empréstimo"
  WHEN total_emprestimos BETWEEN 2 AND 3 THEN "2 a 3 Empréstimos"
  ELSE "Mais de 3"
END

-------------------------------------
--## variáveis de atraso campo calculado de sem risco, risco moderado, risco inicial e risco alto ##

CASE 
  WHEN more_90_days_overdue > 0 THEN "Risco Alto"
  WHEN number_times_delayed_payment_loan_60_89_days > 0 THEN "Risco Moderado"
  WHEN number_times_delayed_payment_loan_30_59_days > 0 THEN "Risco Inicial"
  ELSE "Sem Risco"
END

-------------------------------------
--## faixa etária ##

CASE
  WHEN age <= 25 THEN "25"
  WHEN age <= 35 THEN "26-35"
  WHEN age <= 45 THEN "36-45"
  WHEN age <= 55 THEN "46-55"
  WHEN age <= 65 THEN "56-65"
  ELSE "65+"
END

-----------------------------------
--## risco_inadimplencia_numérico ##

CASE 
  WHEN segmentacao_de_risco_inadimplencia = "Sem Risco" THEN 0
  WHEN segmentacao_de_risco_inadimplencia = "Risco Inicial" THEN 1
  WHEN segmentacao_de_risco_inadimplencia = "Risco Moderado" THEN 2
  WHEN segmentacao_de_risco_inadimplencia = "Risco Alto" THEN 3
END

-------------------------------------
--## nínel de endividamento ##

CASE
  WHEN debt_ratio <= 0.3 THEN "Baixo"
  WHEN debt_ratio <= 0.5 THEN "Médio"
  ELSE "Alto"
END

--------------------------------
--## para criação do gráfico boxplot foi criado percentile das variáveis para a divisão do quartil no gráfico ##

#last_month_salary ##
PERCENTILE(last_month_salary,25)
PERCENTILE(last_month_salary,75)

## number_times_delayed_payment_loan_30_59_days ##
PERCENTILE(number_times_delayed_payment_loan_30_59_days,25)
PERCENTILE(number_times_delayed_payment_loan_30_59_days,75)

## user_id ##
PERCENTILE(user_id,25)
PERCENTILE(user_id,75)


------------------------------------
--## atraso_30_59 ##--

CASE
  WHEN number_times_delayed_payment_loan_30_59_days = 0 THEN '0 atrasos'
  WHEN number_times_delayed_payment_loan_30_59_days = 1 THEN '1 atraso'
  WHEN number_times_delayed_payment_loan_30_59_days = 2 THEN '2 atrasos'
  WHEN number_times_delayed_payment_loan_30_59_days = 3 THEN '3 atrasos'
  ELSE '4 ou mais atrasos'
END

--------------------------------
--## distribuição de salário ##--

CASE
  WHEN last_month_salary = 0 THEN 'Não informado'
  WHEN last_month_salary <= 50 THEN 'Valor possivelmente inválido'
  WHEN last_month_salary <= 2000 THEN 'Até R$2 mil'
  WHEN last_month_salary <= 4000 THEN 'R$2–4 mil'
  WHEN last_month_salary <= 8000 THEN 'R$4–8 mil'
  WHEN last_month_salary <= 15000 THEN 'R$8–15 mil'
  WHEN last_month_salary <= 30000 THEN 'R$15–30 mil'
  WHEN last_month_salary <= 60000 THEN 'R$30–60 mil'
  WHEN last_month_salary <= 100000 THEN 'R$60–100 mil'
  ELSE 'Acima de R$100 mil'
END

---------------------------------
--## faixa realista indice de dívida ##--
CASE
  WHEN debt_ratio = 0 THEN '0%'
  WHEN debt_ratio > 0 AND debt_ratio <= 0.2 THEN '0–20%'
  WHEN debt_ratio <= 0.4 THEN '21–40%'
  WHEN debt_ratio <= 0.6 THEN '41–60%'
  WHEN debt_ratio <= 0.8 THEN '61–80%'
  WHEN debt_ratio <= 1.0 THEN '81–100%'
  WHEN debt_ratio <= 2.0 THEN '101–200%'
  WHEN debt_ratio <= 5.0 THEN '201–500%'
  WHEN debt_ratio <= 10.0 THEN '501–1000%'
  ELSE 'Acima de 1000%'
END

--------------------------------

--Previsão inadimplência--
CASE WHEN score_risco >= 3 THEN 1 ELSE 0 END

-----------------------------------

--Verdadeiro Positivo --
CASE WHEN default_flag = 1 AND previsao_inadimplencia2 = 1 THEN 1 ELSE 0 END


----------------------------------

-- falso positivo --
CASE WHEN default_flag = 0 AND previsao_inadimplencia2 = 1 THEN 1 ELSE 0 END

--------------------------------

--Falso Negativo --
CASE WHEN default_flag = 1 AND previsao_inadimplencia2 = 0 THEN 1 ELSE 0 END

-----------------------------------

-- Verdadeiro Negativo --
CASE WHEN default_flag = 0 AND previsao_inadimplencia2 = 0 THEN 1 ELSE 0 END

----------------------------------

-- Prbabilidade de inadimplência --
ROUND(score_risco / 6.0 * 100, 1) AS probabilidade_inadimplencia_percent

--------------------------------

--score médio de risco --
AVG(score_risco1)

-- renda média dos inadimplentes --
AVG(CASE WHEN inadimplente = 1 THEN last_month_salary ELSE NULL END)


-- renda média dos adimplentes --
AVG(CASE WHEN inadimplente = 0 THEN last_month_salary ELSE NULL END)

--total inadimplentes --  
COUNT(IF(inadimplente = 1, 1, NULL))

-- total adimplentes --
COUNT(IF(inadimplente = 0, 1, NULL))

-- percentual de inadimplentes --
COUNT(IF(inadimplente = 1, 1, NULL)) / COUNT(*)

-- distribuição score de risco --
CASE 
  WHEN score_risco1 <= 1 THEN "Baixo (0-1)"
  WHEN score_risco1 = 2 THEN "Moderado (2)"
  WHEN score_risco1 = 3 THEN "Alto (3)"
  WHEN score_risco1 >= 4 THEN "Crítico (4+)"
END

-- definição de legenda adimplentente e inadimplente --
CASE 
  WHEN inadimplente = 1 THEN "Inadimplente"
  WHEN inadimplente = 0 THEN "Adimplente"
END


-- definição do rótulo do gráfico de barras --
CASE
  WHEN score_risco1 = 0 OR score_risco1 = 1 THEN "Baixo (0-1)"
  WHEN score_risco1 = 2 THEN "Moderado (2)"
  WHEN score_risco1 = 3 THEN "Alto (3)"
  WHEN score_risco1 >= 4 THEN "Crítico (4+)"
END


-- uso de linhas de créditos vs inadimplência --
CASE
  WHEN using_lines_not_secured_personal_assets < 0.5 THEN "0-0.5"
  WHEN using_lines_not_secured_personal_assets < 1 THEN "0.5-1"
  WHEN using_lines_not_secured_personal_assets < 2 THEN "1-2"
  ELSE "2+"
END

-- faixa idade de risco --  
CASE
  WHEN age < 30 THEN "Até 29"
  WHEN age < 40 THEN "30-39"
  WHEN age < 50 THEN "40-49"
  WHEN age < 60 THEN "50-59"
  ELSE "60+"
END


-- salário vs inadimplência --
CASE
  WHEN last_month_salary < 3000 THEN "Até R$3mil"
  WHEN last_month_salary < 6000 THEN "R$3mil–6mil"
  WHEN last_month_salary < 10000 THEN "R$6mil–10mil"
  ELSE "R$10mil+"
END


-- atraso 30-59 dias vs inadimplência --
CASE
  WHEN number_times_delayed_payment_loan_30_59_days = 0 THEN "0"
  WHEN number_times_delayed_payment_loan_30_59_days = 1 THEN "1"
  WHEN number_times_delayed_payment_loan_30_59_days <= 3 THEN "2-3"
  ELSE "4+"
END

-- proporção inadimplencia -- 
100 * COUNT(CASE WHEN inadimplente = 1 THEN 1 END) / COUNT(inadimplente)
