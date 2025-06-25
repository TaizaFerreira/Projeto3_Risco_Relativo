Risco relativo - Super Caja
Projeto de análise de crédito através do risco relativo do banco Super Caja.

Ferramentas e tecnologias
Google Cloud (BigQuery)
Google Colab
Looker Studio
Python
SQL
Noção para gestão das etapas do projeto e documentação técnica.

Objetivo
Desenvolver e implementar um modelo automatizado de pontuação de crédito baseado em técnicas avançadas de análise de dados, capaz de classificar os solicitantes de empréstimo do banco “Super Caja” em diferentes categorias de risco, considerando a probabilidade de inadimplência.

Projeto individual
Taiza de Souza Santos Ferreira

# Caso: Análise de Crédito no Banco Super Caja

## Contexto

Recentemente, a queda nas taxas de juros no mercado resultou em um aumento expressivo na demanda por crédito. Os clientes viram neste cenário uma oportunidade para financiar grandes compras ou consolidar dívidas, o que elevou significativamente o número de pedidos de empréstimo no banco **Super Caja**.

No entanto, a equipe de análise de crédito do banco enfrenta um desafio crescente: a análise manual de cada solicitação tornou o processo lento e ineficiente, comprometendo a agilidade e qualidade das decisões.

Além disso, a crescente **taxa de inadimplência** intensificou a preocupação com a sustentabilidade financeira, exigindo que o banco adote estratégias mais eficazes para identificar e mitigar os riscos de crédito.

##  Proposta

Para lidar com essa situação, o banco propõe a **automação do processo de análise de crédito**, por meio do uso de **técnicas avançadas de análise de dados**, com os seguintes objetivos:

- Aumentar a **eficiência e a precisão** na análise de crédito;
- Reduzir o tempo de processamento dos pedidos;
- Integrar métricas de inadimplência já existentes ao sistema automatizado;
- Melhorar a **identificação de riscos** de crédito.

## Objetivo da Análise

- Identificar o **perfil de clientes com risco de inadimplência**;
- Criar uma **pontuação de crédito** com base em dados históricos;
- Avaliar o **risco relativo** entre diferentes perfis de clientes;
- **Classificar** os clientes em **categorias de risco** conforme sua probabilidade de inadimplência.

## Benefícios Esperados

- Tomada de decisão mais **rápida e assertiva** sobre concessão de crédito;
- **Redução de empréstimos não reembolsáveis**;
- Fortalecimento da **solidez financeira** do banco;
- Maior **eficiência operacional** e escalabilidade da análise de crédito.

# Projeto: Análise de Risco de Inadimplência

##  Processamento e Preparação da Base de Dados

###  Identificação e Tratamento de Valores Nulos e Outliers

### Objetivo

Detectar e tratar valores extremos (outliers) e nulos nas variáveis **idade** e **salário**, utilizando SQL e critérios estatísticos com base no intervalo interquartil (IQR).

### Etapas Realizadas

**1. Detecção de Outliers**

- Idade: 10 outliers
- Salário: 2.209 outliers

Técnica: IQR (boxplot)

**Exemplo aplicado à idade:**

- Q1 = 25, Q3 = 40
- IQR = 15
- Limites: Inferior = 2,5 | Superior = 62,5

**2. Código SQL**
Uso do `CASE WHEN` para classificação de valores como "Outlier" ou "Normal".

**3. Importância**

- Corrigir distorções
- Identificar perfis extremos de risco

---

##  Outliers em Variáveis Financeiras e Comportamentais

| Variável | Outliers |
| --- | --- |
| Atrasos > 90 dias | 1.946 |
| Uso de crédito não garantido | 177 |
| Atrasos 30-59 dias | 5.812 |
| Debt ratio | 7.570 |
| Atrasos 60-89 dias | 1.865 |

**Conclusão:** Manutenção temporária para investigação de perfis de alto risco.

---

##  Criação de Variáveis e Análise de Consistência

Variáveis criadas:

- `qtd_real_estate`, `qtd_other`, `total_emprestimos`, `diversidade_tipos`

**Inconsistências identificadas:** 425 usuários sem empréstimos ativos (confirmado com outras tabelas).

---

##  Integração de Tabelas

- Realizado `INNER JOIN`
- Exclusão dos 425 sem crédito
- Variável `sexo` removida por questões éticas

---

##  Tabelas Auxiliares com WITH

- Subconsultas para organizar e consolidar dados
- Criação da `risco_relativo_unificada_1` com 35.575 clientes válidos

---

##  Análise Exploratória

### Agrupamento de Variáveis Categóricas

Análises no Looker Studio:

- Distribuição por sexo
- Inadimplência por faixa de empréstimos
- Diversidade de tipos vs inadimplência

**Variável categórica criada:** `faixa_emprestimos`

- Nenhum, 1, 2 a 3, >3

### Visualizações Criadas

- Barras, pizza, linhas, dispersão, scorecards

---

##  Medidas de Tendência Central

**Classificação de Risco por Atraso:**

- Sem Risco, Risco Inicial (30-59), Moderado (60-89), Alto (>90)

**Principais insights:**

- Jovens têm maior risco
- Salários mais baixos = mais risco
- Debt ratio varia com risco
- Bens e dependentes têm relação fraca

---

##  Distribuição e Boxplots

- Faixas etárias (idade_faixa_etaria)
- Variáveis transformadas em números para boxplot
- Debt ratio classificado em 3 níveis
- Quartis, mediana e outliers mapeados

---

##  Medidas de Dispersão (Desvio Padrão)

**Análise por variável:**

- Salário e uso de crédito: alta variabilidade
- Idade e dependentes: baixa variabilidade

**Idade e debt_ratio com desvio zero em grupos homogêneos.**

---

##  Análise de Quartis e Risco Relativo

### Variáveis categorizadas por quartis:

- Idade, salário, dependentes, atrasos, uso de crédito, empréstimos, diversidade de crédito

**Função NTILE(4) aplicada** para criar colunas de quartis.

**Resultados:**

- Jovens (Q1 e Q2) = maior risco
- Quartil 2 com maior risco relativo (1,24x)
- Quartil 4 (mais velho) com menor risco (0,61)

**Tabela final:** `base_com_quartis`

---

##  Correlação entre Variáveis

- Correlação forte entre atrasos (30-59 vs 60-89 / >90)
- Correlação fraca com salário, dependentes, diversidade de crédito

---

##  Criação de Categorias para Variáveis-Chave

- Faixas de atraso (30-59 dias)
- Faixas salariais (inclui "Não informado")
- Faixas de debt ratio (até >1000%)

**Conclusão:** Histórico de atrasos é o principal fator de risco. Variáveis como salário e dependentes têm impacto mais limitado isoladamente.

---

##  Referências e Consultas SQL

- Views: `calculo_quartil_e_risco_relativo`, `VW_tabela_temporaria_quartil_risco_relativo_variaveis_numericas`
- Base final: `riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada`
- Função CORR e instruções CASE utilizadas para análise e visualização

---

##  Criação do Score de Risco com Dummies

### Objetivo

Construir uma pontuação de risco individual baseada nas variáveis mais associadas à inadimplência, classificando clientes entre bons e maus pagadores.

### Metodologia

Com base nos quartis com maior risco, foram selecionadas 12 variáveis. Para cada uma, criou-se uma **variável dummy de risco** (1 = cliente pertence ao quartil de maior risco; 0 = caso contrário). As variáveis foram:

- Idade (Q1)
- Salário (Q1)
- Dependentes (Q4)
- Atraso 30-59 dias (Q4)
- Atraso 60-89 dias (Q4)
- Atraso >90 dias (Q4)
- Uso de linhas de crédito (Q4)
- Debt ratio (Q3)
- Total de empréstimos (Q1)
- Imóveis (Q1)
- Outros bens (Q1)
- Diversidade de crédito (Q1)

Cada dummy soma 1 ponto ao `score_risco`, que varia de 0 a 12.

### Pontuação Final e Corte

- Clientes com `score_risco >= 4` são classificados como **inadimplentes previstos**
- Clientes com `score_risco < 4` são classificados como **bons pagadores previstos**

---

##  Análise de Performance do Modelo

### Modelo com ponto de corte = 4

### Matriz de Confusão

|  | Previsto Inadimplente | Previsto Não Inadimplente |
| --- | --- | --- |
| **Real Inadimplente** | 272 (VP) | 350 (FN) |
| **Real Não Inadimplente** | 2.151 (FP) | 32.802 (VN) |

### Métricas

- Acurácia: 92,97%
- Precisão: 11,23%
- Recall: 43,73%
- F1 Score: 17,87%

**Interpretação:** modelo conservador, com menor quantidade de falsos positivos. Indicado quando o custo de erro do tipo I (falsos positivos) é alto.

---

### Modelo com ponto de corte = 3

### Matriz de Confusão

|  | Previsto Inadimplente | Previsto Não Inadimplente |
| --- | --- | --- |
| **Real Inadimplente** | 477 (VP) | 145 (FN) |
| **Real Não Inadimplente** | 6.938 (FP) | 28.015 (VN) |

### Métricas

- Acurácia: 80,09%
- Precisão: 6,43%
- Recall: 76,69%
- F1 Score: 11,87%

**Interpretação:** modelo mais sensível, captura mais inadimplentes reais, mas com aumento expressivo de falsos positivos.

---

##  Considerações Finais

A escolha do ponto de corte deve considerar o trade-off entre sensibilidade e especificidade:

- Se o objetivo for evitar inadimplência, o corte 3 é mais adequado.
- Se o foco for reduzir custos de cobrança ou evitar rejeição indevida, o corte 4 é preferível.

O modelo é baseado em lógica simples e interpretável, podendo ser ajustado com novas variáveis ou técnicas para aumento de performance futura.
