# 3 -Ficha técnica projeto 3 - Risco relativo

Criada em: 18 de junho de 2025 22:37

# **Ficha técnica Projeto 3 Risco relativo**

**Projeto individual**

**Taiza de Souza Santos Ferreira**

**Laboratória Brasil**

## 1. Introdução

O risco relativo é uma medida estatística utilizada em epidemiologia e em diversas outras áreas para avaliar a associação entre a exposição a um fator de risco específico e a ocorrência de um resultado específico, como uma doença ou evento adverso. É calculado como a proporção da incidência do referido desfecho no grupo exposto ao fator de risco em comparação com a incidência no grupo não exposto.

Por outras palavras, o risco relativo fornece uma indicação da probabilidade de ocorrência de um resultado no grupo exposto em comparação com o grupo não exposto. Um risco relativo igual a 1 sugere que não há diferença na incidência entre os dois grupos, enquanto um risco relativo maior que 1 indica um risco maior no grupo exposto, e um risco relativo menor que 1 indica um risco menor no grupo exposto.

## Caso

Num contexto recente, a descida das taxas de juro no mercado desencadeou um aumento notável na demanda por pedidos de crédito. Os clientes viram este movimento do mercado, como uma oportunidade favorável para financiar grandes compras ou consolidar dívidas existentes, o que elevou o fluxo de pedidos de empréstimo no banco “Super Caja”. A equipe de análise de crédito do banco enfrenta um fardo esmagador devido à análise manual necessária para cada solicitação de empréstimo de clientes individuais. Esta metodologia manual resultou num processo ineficiente e atrasado, que afetou negativamente a eficiência e a velocidade com que os pedidos de empréstimo são processados. A situação tornou-se mais crítica devido à preocupação crescente com a taxa de inadimplência, um problema que afeta cada vez mais o setor financeiro, e aumenta a pressão sobre os bancos para identificar e mitigar riscos associados ao crédito.

Para enfrentar esse desafio, a proposta do banco é a automação do processo de análise de crédito usando técnicas de análise avançadas de dados, com o objetivo de melhorar a eficiência, precisão e rapidez na avaliação de pedidos de crédito. Além disso, o banco já tem uma métrica para identificar clientes com pagamento atrasado, o que poderia ser uma ferramenta valiosa para integrar na classificação de risco no novo sistema automatizado.

O objetivo da análise é identificar o perfil de clientes com risco de inadimplência, montar uma pontuação de crédito através da análise de dados e avaliar o risco relativo, possibilitando assim, classificar os clientes e futuros clientes em diferentes categorias de risco com base na sua probabilidade de inadimplência. Esta classificação permitirá ao banco tomar decisões informadas sobre a quem conceder crédito, reduzindo assim o risco de empréstimos não reembolsáveis. Além disso, a integração destas métricas fortalecerá a capacidade do modelo de identificar riscos, contribuindo para a solidez financeira e a eficiência operacional do Banco.

### **Processar e preparar a base de dados**

### **Identificação e Tratamento de Valores Nulos e Outliers**

Objetivo:

Identificar e tratar valores nulos e outliers nas variáveis idade e salário, utilizando comandos SQL e critérios estatísticos.

1. Detecção de Outliers

Foram identificados:

- 10 outliers na variável idade
- 2.209 outliers na variável salário

A detecção foi realizada com base na técnica do intervalo interquartil (IQR), utilizada em boxplots.

### Exemplo aplicado à variável idade:

- Q1 (1º quartil): 25
- Q3 (3º quartil): 40
- IQR = Q3 - Q1 = 15

Cálculo dos limites:

- Limite inferior = Q1 - 1,5 × IQR = 25 - 22,5 = 2,5
- Limite superior = Q3 + 1,5 × IQR = 40 + 22,5 = 62,5

🔹 Conclusão:

Valores de idade abaixo de 2,5 ou acima de 62,5 são considerados outliers estatísticos.

2. Lógica do Código SQL

Foi utilizado CASE WHEN para classificar cada registro:

- **'Outlier' se o valor estiver fora do intervalo normal**
- **'Normal' caso contrário**

Essa abordagem foi aplicada tanto para a variável idade quanto para o salário.

3. Importância da Etapa

A identificação de outliers é essencial para:

- Eliminar possíveis erros ou distorções nos dados
- Revelar perfis extremos de clientes, como salários muito elevados ou baixos, que exigem análise diferenciada

### Identificação de Outliers com Base no Intervalo Interquartil (IQR)

Nesta etapa, o objetivo foi identificar valores extremos (outliers) em variáveis financeiras e comportamentais relevantes da base loans_detail. A técnica estatística utilizada foi o Intervalo Interquartil (IQR), amplamente empregada para detectar valores atípicos com base nos quartis da distribuição.

O IQR é definido como a diferença entre o terceiro quartil (Q3) e o primeiro quartil (Q1). Valores considerados outliers são aqueles que:

- Estão abaixo de Q1 - 1,5 × IQR, ou
- Acima de Q3 + 1,5 × IQR

Essa metodologia foi aplicada às seguintes variáveis:

- **Atrasos superiores a 90 dias (more_90_days_overdue)**
- **Uso de linhas de crédito não garantidas (using_lines_not_secured_personal_assets)**
- Atrasos de 30 a 59 dias
- **Índice de comprometimento da renda (debt_ratio)**
- Atrasos de 60 a 89 dias

### Principais achados:

- 1946 outliers na variável de atrasos acima de 90 dias
- 177 outliers no uso de linhas de crédito
- 5812 outliers em atrasos de 30 a 59 dias
- 7570 outliers no debt ratio
- 1865 outliers nos atrasos de 60 a 89 dias

### Conclusão:

A aplicação do IQR permitiu identificar valores atípicos que podem representar:

- Comportamentos financeiros fora do padrão (como uso excessivo de crédito)
- Indícios de inadimplência grave
- Ou ainda, erros de preenchimento ou registros extremos

Decidiu-se manter os outliers nesta fase, pois podem conter informações valiosas sobre perfis de alto risco. Eles serão explorados mais profundamente nas análises posteriores para verificar sua relevância no modelo de score de inadimplência.

### **Criação de Novas Variáveis e Análise de Consistência**

Nesta etapa, o objetivo foi criar variáveis relacionadas aos tipos de empréstimos ativos por cliente, com foco em diferenciar entre:

- Real Estate (empréstimos imobiliários)
- Other (outros tipos de empréstimos)

Foi gerada uma nova estrutura de dados contendo, para cada usuário:

- A quantidade de empréstimos de cada tipo (real estate e other)
- Uma lista dos IDs de empréstimos ativos agrupados

### **Verificação de Inconsistências**

Durante a construção dessa visualização, foi identificado que a nova tabela apresentava 425 usuários a menos do que a base principal (user_info3), que contém 36.000 clientes.

Para investigar a origem dessa diferença, foi feita uma verificação dos user_id ausentes. O resultado mostrou que esses 425 clientes não possuem nenhum registro de empréstimo ativo na base loans_outstanding. Ou seja, são usuários cadastrados, mas sem contratos de crédito em aberto no momento da coleta de dados.

Esses usuários foram posteriormente cruzados com outras tabelas da base (perfil, comportamento de crédito etc.), confirmando que a ausência de empréstimos se reflete também em colunas nulas relacionadas à lista de empréstimos e às variáveis derivadas.

### **Conclusão**

A criação das variáveis de tipo e quantidade de empréstimo enriquece a análise do perfil de risco de cada cliente, permitindo:

- Identificar o tipo de comprometimento financeiro
- Relacionar o tipo de crédito com a inadimplência
- Segmentar estratégias com base no perfil de crédito

A ausência de dados para 425 clientes foi considerada coerente e esperada, sendo mantida para fins de completude da base. A partir daqui, esses campos passam a fazer parte da análise exploratória e podem ser usados em dashboards e no modelo de score.

### Unir Tabelas

Nesta etapa, o objetivo foi consolidar diferentes fontes de dados em uma única tabela analítica. A integração envolveu informações cadastrais, comportamentais e dados sobre os tipos de empréstimos ativos de cada cliente.

Durante o processo, foi identificada a existência de 425 usuários sem nenhum empréstimo registrado. Como o foco da análise é o desempenho de crédito após a contratação de empréstimos, esses clientes foram excluídos da base principal, uma vez que não apresentam histórico relevante para avaliação de risco. Essa exclusão foi feita utilizando INNER JOIN, garantindo que apenas clientes com empréstimos ativos fossem considerados.

Além disso, foram criadas novas variáveis para enriquecer a análise:

- **total_emprestimos: indica o total de empréstimos por cliente.**
- **qtd_real_estate: total de empréstimos do tipo imobiliário.**
- **qtd_other: total de empréstimos de outros tipos.**
- **diversidade_tipos: número de tipos diferentes de empréstimos por cliente.**

Essas variáveis permitem avaliar o nível de exposição ao crédito e a diversificação das dívidas de cada usuário.

Por fim, optou-se por remover a variável "sexo" da base final, considerando que sua inclusão poderia levar a interpretações ou decisões discriminatórias. Essa decisão reforça o compromisso com ética e responsabilidade no uso de dados.

### Construir Tabelas Auxiliares

Para facilitar a manipulação e análise dos dados, foram utilizadas tabelas auxiliares temporárias por meio de subqueries com o comando WITH. Esse recurso foi essencial para organizar os dados antes da unificação e identificar inconsistências, como os registros nulos de empréstimos.

A abordagem permitiu:

- **Consolidar múltiplas fontes em uma única tabela (risco_relativo_unificada)**
- Diagnosticar registros incompletos (clientes sem empréstimos)
- Criar uma versão definitiva da base, filtrando apenas os usuários relevantes para a análise

A tabela final, chamada risco_relativo_unificada_1, contém 35.575 clientes com histórico de crédito válido, e serviu como base principal para todas as análises posteriores, incluindo a criação do score de risco.

## **Análise Exploratória**

### **Agrupamento de Variáveis Categóricas**

**Nesta etapa, o objetivo foi resumir os dados com base em variáveis categóricas, utilizando tabelas e gráficos no Looker Studio para identificar padrões relevantes relacionados à inadimplência.**

### **➤ Principais análises:**

- **Distribuição de clientes por sexo: Mostra a proporção de homens e mulheres na base.**
- **Número de inadimplentes por faixa de empréstimos: Permite verificar se clientes com mais empréstimos estão mais propensos à inadimplência.**
- **Diversidade de tipos de empréstimo vs inadimplência: Mostra se clientes com mais variedade de empréstimos tendem a ter maior ou menor inadimplência.**

**Para facilitar a análise, foi criada uma nova variável categórica, chamada faixa_emprestimos, com o seguinte agrupamento:**

- **Nenhum: total_emprestimos = 0**
- **1 Empréstimo: total_emprestimos = 1**
- **2 a 3 Empréstimos: total_emprestimos entre 2 e 3**
- **Mais de 3: total_emprestimos > 3**

**Esse agrupamento permitiu comparar o comportamento de diferentes perfis de clientes de forma mais clara e objetiva.**

### **Visualização Gráfica de Variáveis Categóricas**

**Gráficos de barras, pizza e linhas foram utilizados para representar visualmente os dados categóricos e suas relações com inadimplência.**

### **Gráficos produzidos:**

- **Barras simples: número de clientes por sexo.**
- **Barras empilhadas: tipo de empréstimo (real estate vs other) por sexo.**
- **Pizza: distribuição percentual de clientes por faixa de empréstimo.**
- **Barras por faixa: inadimplência média (AVG) em cada grupo de diversidade de empréstimos.**
- **Gráfico de dispersão: salário vs. total de empréstimos, com o tamanho do ponto indicando o atraso (>90 dias).**
- **Linhas ordenadas: clientes com maior atraso em dias, para identificar outliers de inadimplência.**
- **Scorecards: com indicadores como total de clientes, média de empréstimos e % de clientes com atraso superior a 90 dias.**

**Essas visualizações permitiram confirmar hipóteses iniciais e embasar a construção de um modelo preditivo mais eficiente.**

## **Aplicar Medidas de Tendência Central**

**Nesta etapa, o objetivo foi aplicar estatísticas descritivas, como média e mediana, para compreender a distribuição de variáveis numéricas em diferentes perfis de risco de inadimplência.**

### **Segmentação de Risco**

**Foi criado um campo calculado chamado segmentacao_risco_inadimplencia, com base nas variáveis de atraso, para classificar os usuários em quatro perfis distintos:**

- **Sem Risco: não possui histórico de atrasos. Perfil estável, deve ser mantido.**
- **Risco Inicial: atrasos entre 30 e 59 dias. Sinal de alerta; exige monitoramento.**
- **Risco Moderado: atrasos entre 60 e 89 dias. Perfil de atenção; avaliar crédito e intervir.**
- **Risco Alto: atraso superior a 90 dias. Considerado inadimplente; recomenda-se cobrança, bloqueio de crédito e reavaliação do perfil.**

**Essa classificação foi essencial para criar comparações entre grupos de risco e guiar decisões preventivas e corretivas.**

### **Análise de Média e Mediana**

**Com base nessa segmentação, foi construída uma tabela dinâmica com mapa de calor no Looker Studio, destacando as tendências centrais.**

### **Principais conclusões:**

- **Idade: a média e a mediana da idade diminuem conforme o risco aumenta. Clientes mais jovens concentram maior risco.**
- **Salário: usuários com maior risco possuem salários médios e medianos mais baixos, o que pode indicar menor capacidade de pagamento.**
- **Taxa de dívida (debt_ratio): o valor médio varia, mas é mais alto em perfis de risco inicial. A mediana, porém, é mais estável, revelando a presença de outliers.**
- **Linhas de crédito não garantidas: perfis com risco moderado apresentam uso mais intenso dessa linha, sugerindo comprometimento de crédito pessoal.**
- **Bens imóveis e outros bens: a média e a mediana caem nos perfis de maior risco, reforçando que menor patrimônio está associado à inadimplência.**
- **Número de dependentes: apesar de a média ser levemente maior em perfis de risco, a mediana é zero em todos, sugerindo que a maioria dos usuários não possui dependentes.**

**Essas medidas permitiram identificar padrões relevantes de comportamento, contribuindo diretamente para o refinamento do modelo de score de risco.**

## **Ver Distribuição**

**O objetivo dessa etapa foi visualizar a distribuição das variáveis numéricas utilizando histogramas e gráficos boxplot no Looker Studio.**

### **Faixas Etárias**

**Foi criada a variável idade_faixa_etaria, segmentando os usuários em grupos de idade. Com isso, foi possível gerar um histograma de risco de inadimplência por idade, revelando a concentração de risco em faixas mais jovens.**

### **Boxplot e Classificação Numérica de Risco**

**Para gerar boxplots da variável segmentacao_risco_inadimplencia, foi necessário transformá-la em uma variável numérica (segmentacao_risco__inadimplencia_numerico), com os seguintes valores:**

- **0 para Sem Risco**
- **1 para Risco Inicial**
- **2 para Risco Moderado**
- **3 para Risco Alto**

**Essa codificação viabilizou análises visuais mais precisas sobre o comportamento da variável.**

### **Classificação do Endividamento**

**A variável debt_ratio foi classificada em três níveis:**

- **Baixo endividamento: até 30% da renda**
- **Médio endividamento: entre 31% e 50%**
- **Alto endividamento: acima de 50%**

**Esses grupos foram usados para construir boxplots e histogramas que mostram a relação entre nível de endividamento e inadimplência.**

### **Distribuição de Salário e Atrasos**

**Foram criados campos calculados para obter os quartis (Q1, Q3) e a mediana (Q2) das variáveis:**

- **Salário do último mês**
- **Número de atrasos entre 30 e 59 dias**

**Essas métricas foram aplicadas em gráficos boxplot, revelando a presença de outliers significativos e a dispersão assimétrica em variáveis como salário e atrasos — essenciais para o entendimento do comportamento de risco.**

## **Aplicar Medidas de Dispersão (Desvio Padrão)**

**Nesta etapa, o objetivo foi aplicar medidas de dispersão estatística, com foco no desvio padrão, para entender quanto os dados numéricos variam em torno da média. Essa análise complementa as medidas de tendência central (como média e mediana), fornecendo uma visão mais completa sobre a distribuição dos dados.**

### **Utilização no Looker Studio**

**Para isso, foram utilizadas tabelas dinâmicas com mapas de calor no Looker Studio, que permitiram visualizar o desvio padrão de variáveis como:**

- **Idade (age)**
- **Salário do último mês (last_month_salary)**
- **Taxa de dívida (debt_ratio)**
- **Número de dependentes**
- **Atrasos no pagamento (30-59, 60-89, mais de 90 dias)**
- **Uso de linhas de crédito não garantidas**
- **Quantidade de empréstimos e diversidade de tipos**

### **Interpretação**

**O desvio padrão ajuda a responder:**

**Os valores dessa variável estão próximos da média ou estão muito espalhados?**

- **Um desvio padrão alto indica que os valores estão muito distantes da média — ou seja, há alta variabilidade entre os clientes.**
- **Um desvio padrão baixo mostra que os valores estão mais concentrados em torno da média — ou seja, os clientes têm comportamentos mais uniformes naquela variável.**

### **Exemplos e insights observados**

- **Variáveis como salário e uso de linhas de crédito apresentaram alto desvio padrão, indicando uma grande diferença entre os perfis de clientes.**
- **Já variáveis como número de dependentes e idade tiveram desvio padrão menor, sugerindo menor variabilidade entre os indivíduos analisados.**

**Essas informações são valiosas para ajustar as estratégias de segmentação e definir limiares de risco mais assertivos, respeitando a variabilidade natural das características financeiras e comportamentais dos clientes.**

### **Análise dos Desvios Padrão por Variável**

**Com base nas tabelas geradas no Looker Studio, foram observados os seguintes pontos para as variáveis age (idade) e debt_ratio (índice de endividamento):**

### **Idade (age)**

- **Em todos os grupos analisados, o desvio padrão da idade foi zero.**
- **Isso indica que, dentro de cada linha analisada (provavelmente filtros por faixa ou grupo), todos os clientes tinham exatamente a mesma idade, o que justifica a média, mediana, mínimo e máximo iguais.**
- **Interpretação: A variabilidade não foi analisada no conjunto completo, e sim em subconjuntos uniformes. Para avaliar a dispersão real da idade, o ideal seria aplicar o desvio padrão sobre toda a base ou por grupos maiores.**

### **Índice de Endividamento (debt_ratio)**

- **Assim como na variável idade, os subconjuntos analisados mostram desvio padrão igual a zero — ou seja, nenhuma variação interna nos dados daquele grupo.**
- **Por exemplo, um grupo com média, mediana e valor máximo/mínimo igual a 2.850 mostra que todos os indivíduos daquele segmento têm esse mesmo valor de dívida.**
- **Interpretação: Isso reforça que a análise de dispersão está sendo feita sobre segmentos homogêneos. Para uma visão mais ampla da variabilidade do debt_ratio, é recomendado calcular o desvio padrão para o conjunto completo de dados ou usar agrupamentos mais amplos.**

## **Análise de Quartis e Risco Relativo para Variáveis Financeiras**

### **Objetivo**

**Nesta etapa, realizou-se a segmentação dos clientes em quartis, considerando variáveis como idade, atraso em pagamentos entre 30 e 59 dias, salário mensal e uso de linhas de crédito não garantidas por bens pessoais. O objetivo foi identificar padrões de risco de inadimplência relacionados a diferentes faixas etárias e características financeiras.**

### **Variáveis utilizadas**

**Foram selecionadas as seguintes variáveis numéricas para categorização por quartis:**

- **age: Idade**
- **last_month_salary: Salário no último mês**
- **number_dependents: Número de dependentes**
- **more_90_days_overdue: Número de vezes com mais de 90 dias de atraso**
- **number_times_delayed_payment_loan_30_59_days: Quantidade de atrasos entre 30 e 59 dias**
- **number_times_delayed_payment_loan_60_89_days: Quantidade de atrasos entre 60 e 89 dias**
- **using_lines_not_secured_personal_assets: Uso das linhas de crédito não garantidas**
- **debt_ratio: Razão entre dívida e renda (índice de endividamento)**
- **total_emprestimos: Total de tipos de empréstimos**
- **qtd_real_estate: Quantidade de financiamentos imobiliários**
- **qtd_other: Quantidade de outros empréstimos**
- **diversidade_tipos: Diversidade dos tipos de crédito contratados**

### **Metodologia**

**Utilizou-se a função NTILE(4) do BigQuery para distribuir os registros em quatro faixas (quartis) de tamanhos semelhantes, ordenando os valores de cada variável em ordem crescente. Para cada variável, foi criada uma nova coluna identificando o quartil ao qual o usuário pertence:**

- **Q1 (Quartil 1): Valores mais baixos da amostra**
- **Q2 (Quartil 2): Faixa entre Q1 e a mediana**
- **Q3 (Quartil 3): Faixa entre a mediana e o valor do Q4**
- **Q4 (Quartil 4): Valores mais altos da amostra**

### **Resultados**

**A tabela resultante, denominada**

**riscorelativo2025.risco_relativo_projeto3.base_com_quartis,**

**contém todos os registros da base original acrescidos de 12 colunas adicionais com a indicação do quartil correspondente para cada variável.**

**A análise da variável idade demonstrou que:**

- **Clientes mais jovens (Q1 e Q2) apresentam maior risco relativo de inadimplência, com taxas de atraso superiores a 18%, significativamente acima da média geral de 16%.**
- **O segundo quartil de idade (Q2) exibiu o maior risco relativo (1,24 vezes a média geral), indicando maior vulnerabilidade a atrasos.**
- **A partir do terceiro quartil (Q3), observa-se redução progressiva do risco, com o quartil mais velho (Q4) apresentando o menor risco relativo (0,61).**
- **Salário médio e uso da linha de crédito acompanham essa dinâmica, onde grupos mais jovens apresentam maior uso de crédito e salários variados, sugerindo que além da idade, o perfil financeiro também influencia o risco.**

### **Aplicações**

**Os quartis foram utilizados para:**

- **Comparar taxas de inadimplência entre diferentes faixas de valores por variável**
- **Calcular o risco relativo por quartil, identificando perfis de maior ou menor risco**
- **Construir variáveis dummies e scores de risco**
- **Segmentar perfis de clientes com base em comportamentos e características comuns**

### **Referências Técnicas**

- **Os cálculos de quartis e risco relativo foram realizados com consultas SQL no BigQuery, utilizando funções de janela (NTILE) para segmentação e agregações condicionais para o cálculo das proporções e risco relativo.**
- **As consultas estão salvas em views nomeadas calculo_quartil_e_risco_relativo e VW_tabela_temporaria_quartil_risco_relativo_variaveis_numericas.**
- **Essa metodologia permitiu análise integrada das variáveis idade, atrasos em pagamentos, salário e uso de linhas de crédito, suportando a modelagem de risco.**

### **Análise de Correlação entre Variáveis Numéricas**

**Nesta etapa, foi realizada a análise de correlação de Pearson entre variáveis numéricas selecionadas para entender sua relação com a quantidade de atrasos nos pagamentos de empréstimos entre 30 e 59 dias.**

**As variáveis analisadas inicialmente foram: idade, salário do último mês e uso de linhas de crédito não garantidas por bens pessoais. Os resultados indicaram correlações muito baixas ou praticamente nulas, sugerindo que essas variáveis não apresentam relação linear significativa com o número de atrasos nessa faixa.**

**Para ampliar a análise, foram incluídas outras variáveis numéricas, como número de dependentes, histórico de atrasos mais longos (60-89 e acima de 90 dias), índice de endividamento (debt ratio), total de empréstimos, quantidade de imóveis e outros bens, além da diversidade de tipos de crédito. Destacam-se:**

- **Forte correlação positiva com o número de atrasos de 30 a 59 dias para as variáveis relacionadas a atrasos maiores: atraso entre 60 a 89 dias (r=0,63) e mais de 90 dias (r=0,56). Isso indica que clientes com histórico de atrasos prolongados também apresentam maior frequência de atrasos na faixa analisada.**
- **Variáveis como índice de endividamento, diversidade de tipos de crédito, imóveis e outros bens apresentaram correlação muito baixa, indicando pouca relação linear direta com atrasos nessa faixa.**

### **Criação de Categorias para Variáveis-Chave**

**Para facilitar a análise e visualização, foram criados campos categóricos, como:**

- **Faixa de atraso (30-59 dias): categorizando a quantidade de atrasos em grupos (0 atrasos, 1 atraso, 2 atrasos, 3 atrasos e 4 ou mais atrasos).**
- **Distribuição salarial: classificando salários em faixas que vão desde "Não informado", valores possivelmente inválidos, até faixas crescentes de rendimento, incluindo categorias altas como acima de R$100 mil.**
- **Faixa realista do índice de dívida (debt ratio): categorização em grupos que vão desde 0% até faixas superiores a 1000%, destacando outliers e valores extremos.**

### **Interpretação dos Dados**

**A análise da distribuição do índice de dívida revelou concentração maior nas faixas de 21% a 40% e 0% a 20%, indicando que a maioria dos clientes compromete até 40% da renda mensal com dívidas. Há, entretanto, um grupo expressivo com índices muito elevados (acima de 1000%), que podem representar outliers ou distorções nos dados e que demandam tratamento específico.**

**Os resultados reforçam a importância de considerar o histórico de atrasos mais longos como forte indicativo para a análise de risco, enquanto variáveis como salário, número de dependentes e diversidade de crédito apresentam influência limitada quando analisadas isoladamente.**

## **Referências Técnicas**

- **As correlações foram calculadas utilizando a função CORR do BigQuery, aplicando o coeficiente de Pearson para medir a relação linear entre variáveis numéricas.**
- **Campos categóricos foram criados com instruções CASE para facilitar análise descritiva e visualizações no dashboard.**
- **A base utilizada foi riscorelativo2025.risco_relativo_projeto3.risco_relativo_unificada.**

**Os códigos SQL completos estão documentados em consultas nomeadas para rastreabilidade e reprodutibilidade da análise.**

### Risco relativo

Idade

| Quartil de Idade | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 (mais jovem) | 3,06% | 2,33 🟥 (alto risco) |
| Q2 | 2,11% | 1,30 🟨 (risco moderado) |
| Q3 | 1,32% | 0,70 🟩 (baixo risco) |
| Q4 (mais velho) | 0,51% | 0,23 🟩 (baixo risco) |

**Análise por Quartis de Idade**

A população foi dividida em quatro quartis com base na variável age. A análise mostra que os clientes do primeiro quartil (mais jovens) apresentam uma **taxa de inadimplência de 3,06%**, o que representa um **risco relativo de 2,33 vezes** maior em comparação à média dos outros três quartis. Já os clientes mais velhos (Q4) têm uma inadimplência significativamente menor (0,51%), com risco relativo de apenas 0,23.

Isso indica que **quanto menor a idade, maior o risco de inadimplência**, sendo um dos fatores críticos na construção da pontuação de risco.

Salário

| Quartil de Salário | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 (salários mais baixos) | 2,75% | 1,95 🟥 |
| Q2 | 2,00% | 1,20 🟨 |
| Q3 | 1,43% | 0,77 🟩 |
| Q4 (salários mais altos) | 0,81% | 0,39 🟩 |

**Análise de Risco Relativo por Faixa Salarial**

A divisão em quartis do salário mensal (last_month_salary) revela uma tendência clara: **quanto menor o salário, maior o risco de inadimplência**.

- Clientes no 1º quartil (salários mais baixos) têm uma taxa de inadimplência de **2,75%**, com risco **1,95 vezes maior** do que a média dos demais.
- Já os clientes com salários mais altos (Q4) apresentam uma taxa de apenas **0,81%**, com risco relativo de **0,39**, o que os classifica como de **baixo risco**.

Essa análise demonstra que a variável salário deve ser considerada na pontuação de risco como um fator moderadamente forte de inadimplência.

Número dependentes

| Quartil de Dependentes | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 (menos dependentes) | 1,45% | 0,78 🟢 |
| Q2 | 1,44% | 0,78 🟢 |
| Q3 | 1,63% | 0,91 🟢 |
| Q4 (mais dependentes) | 2,47% | 1,64 🟠 |

**Análise de Risco Relativo por Número de Dependentes**

A análise dos quartis de number_dependents mostra que pessoas com mais dependentes apresentam maior risco de inadimplência.

- O grupo do 4º quartil (com mais dependentes) tem **taxa de inadimplência de 2,47%**, o que representa **risco 1,64x maior** em relação à média dos outros grupos.
- Já os grupos com menos dependentes (Q1 e Q2) apresentaram risco **abaixo da média**, com inadimplência inferior a 1,5%.

Conclui-se que o número de dependentes é um fator relevante, especialmente quando acima da mediana, devendo ser considerado na construção da pontuação de risco.

more_90_days_overdue

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 0,21 | 0,09 |
| Q2 | 0,20 | 0,09 |
| Q3 | 0,12 | 0,05 |
| Q4 | 5,46 | 35,88 |

A análise dos quartis da variável *more_90_days_overdue* evidencia uma forte associação entre o número de dias em atraso superior a 90 dias e a inadimplência.

Os resultados mostram que os três primeiros quartis apresentam taxas muito baixas de inadimplência, variando entre 0,12% e 0,21%, com risco relativo inferior a 0,1, indicando que clientes nessas faixas têm um risco significativamente menor do que a média dos demais grupos.

Por outro lado, o quarto quartil apresenta uma taxa de inadimplência de 5,46%, equivalente a um risco relativo 35,88 vezes maior do que a média dos demais grupos, revelando que clientes com altos valores em *more_90_days_overdue* são altamente propensos à inadimplência.

Conclui-se que a variável *more_90_days_overdue* é um indicador robusto de risco, especialmente quando seus valores estão no quartil mais alto. Para a construção da pontuação de risco, recomenda-se atribuir maior peso a essa variável para captar adequadamente o perfil de alto risco.

atraso_30_59

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 0,18 | 0,08 |
| Q2 | 0,19 | 0,08 |
| Q3 | 0,26 | 0,12 |
| Q4 | 5,36 | 30,32 |

A análise dos quartis da variável *atraso de 30 a 59 dias* mostra que a inadimplência é concentrada principalmente no quarto quartil.

Os três primeiros quartis apresentam taxas de inadimplência muito baixas, entre 0,18% e 0,26%, com risco relativo abaixo de 0,13, indicando que clientes nestas faixas têm risco significativamente menor que a média dos demais grupos.

Em contraste, o quarto quartil apresenta uma taxa de inadimplência elevada de 5,36%, equivalente a um risco relativo 30,32 vezes maior que a média dos outros quartis, sinalizando que clientes com maior número de atrasos nessa faixa têm muito maior probabilidade de inadimplência.

Conclui-se que a variável *atraso de 30 a 59 dias* é um indicador forte e relevante para prever inadimplência, especialmente para os clientes no quartil mais alto. Para a construção da pontuação de risco, recomenda-se atribuir peso significativo a essa variável para capturar o perfil de maior risco.

Atraso de 60 a 89 dias

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 0,37 | 0,17 |
| Q2 | 0,37 | 0,17 |
| Q3 | 0,46 | 0,21 |
| Q4 | 5,80 | 14,61 |

A análise dos quartis da variável *atraso de 60 a 89 dias* mostra que os três primeiros quartis apresentam taxas de inadimplência baixas, entre 0,37% e 0,46%, com risco relativo inferior a 0,22. Isso indica que clientes nessas faixas têm risco significativamente menor que a média dos demais grupos.

Por outro lado, o quarto quartil apresenta uma taxa de inadimplência de 5,8%, o que equivale a um risco relativo 14,61 vezes maior que a média dos demais grupos, destacando clientes com maior atraso nessa faixa como grupo de risco elevado.

Conclui-se que o *atraso de 60 a 89 dias* é um indicador relevante para prever inadimplência, especialmente para clientes no quartil mais alto. Recomenda-se que essa variável receba peso significativo na pontuação de risco para melhor identificação dos perfis de maior risco.

using_lines_not_secured_personal_asset

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 0,09 | 0,04 |
| Q2 | 0,07 | 0,00 |
| Q3 | 0,33 | 0,15 |
| Q4 | 6,57 | 46,11 |

A variável *uso de linhas de crédito* mostra uma forte relação com o risco de inadimplência, especialmente no quartil mais alto.

Os três primeiros quartis apresentam taxas de inadimplência muito baixas, entre 0,07% e 0,33%, com risco relativo muito próximo de zero, indicando baixo risco nesses grupos.

No entanto, o quarto quartil apresenta uma taxa de inadimplência significativamente maior, 6,57%, com risco relativo de 46,11, evidenciando que clientes com maior uso de linhas de crédito têm um risco muito elevado de inadimplência.

Portanto, o *uso de linhas de crédito* é um indicador crítico para identificar perfis de alto risco, e deve receber peso elevado na construção da pontuação de risco.

Debt ratio

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 1,39 | 0,75 |
| Q2 | 1,51 | 0,82 |
| Q3 | 2,28 | 1,46 |
| Q4 | 1,81 | 1,05 |

A análise dos quartis da variável *debt ratio* indica que o risco de inadimplência aumenta até o terceiro quartil, atingindo taxa máxima de 2,28% e risco relativo de 1,46.

No entanto, o quarto quartil apresenta uma redução na taxa de inadimplência para 1,81%, com risco relativo 1,05, indicando que o maior endividamento não necessariamente está associado ao maior risco.

Isso sugere que o *debt ratio* tem influência moderada sobre a inadimplência, sendo o terceiro quartil o grupo com maior risco. Para a construção da pontuação de risco, é importante considerar essa variação para evitar superestimativa no quartil mais alto.

Total empréstimos

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 2,90 | 2,13 |
| Q2 | 1,75 | 1,00 |
| Q3 | 1,15 | 0,59 |
| Q4 | 1,19 | 0,62 |

A análise dos quartis da variável *total de empréstimos* revela que o maior risco de inadimplência está concentrado no primeiro quartil, com taxa de 2,90% e risco relativo 2,13, indicando que clientes com menor volume de empréstimos têm maior probabilidade de inadimplência.

Nos quartis intermediários e superior, a taxa de inadimplência e o risco relativo são menores, sugerindo que um maior volume de empréstimos está associado a um risco menor ou moderado.

Este resultado pode indicar que clientes com poucos empréstimos acumulam inadimplência de forma mais concentrada, possivelmente por questões de perfil financeiro ou comportamento de crédito.

Portanto, a variável *total de empréstimos* apresenta um padrão inverso em relação ao risco, que deve ser considerado na construção da pontuação de risco para evitar subestimativas.

Empréstimo imobiliário

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 2,59 | 1,76 |
| Q2 | 1,81 | 1,05 |
| Q3 | 1,37 | 0,73 |
| Q4 | 1,23 | 0,64 |

A análise dos quartis da variável *quantidade de imóveis* indica que o risco de inadimplência é maior nos clientes do primeiro quartil, com taxa de 2,59% e risco relativo de 1,76, mostrando que quem tem menos imóveis apresenta maior probabilidade de inadimplência.

Nos quartis seguintes, tanto a taxa quanto o risco relativo diminuem progressivamente, sugerindo que possuir mais imóveis está associado a um risco menor de inadimplência.

Esse padrão evidencia que a posse de imóveis pode ser um fator de proteção financeira, refletindo estabilidade e capacidade de pagamento.

Portanto, a variável *quantidade de imóveis* deve ser considerada na pontuação de risco como um indicador relevante, com maior peso para clientes nos quartis inferiores.

Empréstimo outros

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 2,69 | 1,87 |
| Q2 | 1,87 | 1,09 |
| Q3 | 1,18 | 0,61 |
| Q4 | 1,26 | 0,66 |

A análise dos quartis da variável *outros bens* revela que o risco de inadimplência é maior no primeiro quartil, com taxa de 2,69% e risco relativo de 1,87, indicando que clientes com menor quantidade de outros bens têm maior probabilidade de inadimplência.

Nos quartis subsequentes, tanto a taxa quanto o risco relativo diminuem, sugerindo que a posse de mais bens está associada a menor risco.

Esse padrão reforça a ideia de que a acumulação de patrimônio, mesmo em categorias diversas, pode ser um fator protetor contra inadimplência.

Portanto, a variável *outros bens* é um indicador importante a ser considerado na construção da pontuação de risco, especialmente para identificar perfis de maior vulnerabilidade.

Diversidade de tipos

| Quartil | Taxa de Inadimplência (%) | Risco Relativo |
| --- | --- | --- |
| Q1 | 2,54 | 1,71 |
| Q2 | 1,82 | 1,06 |
| Q3 | 1,21 | 0,63 |
| Q4 | 1,42 | 0,76 |

A análise dos quartis da variável *diversidade de crédito* indica que os clientes no primeiro quartil apresentam o maior risco de inadimplência, com taxa de 2,54% e risco relativo de 1,71.

Nos quartis seguintes, observa-se uma diminuição progressiva na taxa de inadimplência e no risco relativo, sugerindo que a maior diversidade de crédito está associada a menor risco.

Esse comportamento pode indicar que clientes com maior diversidade de crédito possuem um perfil financeiro mais sólido e melhor gestão de suas obrigações.

Portanto, a variável *diversidade de crédito* deve ser considerada na pontuação de risco como um indicador importante para diferenciar perfis de risco.

## Análise de Risco Relativo por Variável

Este relatório apresenta os principais insights obtidos a partir da análise de risco relativo de inadimplência, segmentando a população em quartis para cada variável relevante. O objetivo é identificar padrões de risco e destacar os fatores que mais influenciam a inadimplência, auxiliando na construção de uma pontuação de risco eficiente e interpretável.

### Idade

Clientes mais jovens (Q1) apresentam uma **taxa de inadimplência de 3,06%** e um **risco 2,33 vezes maior** que os demais. Já os mais velhos (Q4) têm taxa de apenas 0,51% e risco relativo de 0,23.

Conclusão: Idade é um forte preditor de inadimplência. Jovens representam maior risco.

### Salário

Indivíduos no quartil mais baixo têm **2,75% de inadimplência** e **risco 1,95x maior**. Os com salários mais altos (Q4) têm apenas **0,81%**, com **risco relativo de 0,39**.

Conclusão: Salários baixos estão associados a maior inadimplência. Deve ser fator central na pontuação.

### Número de Dependentes

O 4º quartil (mais dependentes) tem **inadimplência de 2,47%** e **risco 1,64x maior**. Já Q1 e Q2 têm taxas inferiores a 1,5%.

Conclusão: Mais dependentes = maior risco. Deve ser incluído como moderador de risco.

### Atrasos acima de 90 dias

Q4 apresenta **5,46% de inadimplência** e **risco relativo altíssimo (35,88x)**. Os demais quartis têm taxas abaixo de 0,21%.

Conclusão: Variável com maior poder de predição. Deve receber o maior peso na pontuação.

### Atrasos de 30 a 59 dias

Q4 apresenta **5,36% de inadimplência** e **risco relativo de 30,32x**, enquanto os demais estão abaixo de 0,26%.

Conclusão: Indicador precoce de inadimplência. Relevante para intervenções preventivas.

### Atrasos de 60 a 89 dias

Inadimplência de **5,8% no Q4**, com **risco 14,61x maior**. Demais quartis abaixo de 0,5%.

Conclusão: Fator de risco importante. Deve ser ponderado com atenção.

### Uso de Linhas de Crédito

Q4 apresenta **6,57% de inadimplência** e **risco 46,11x maior**. Q1 a Q3 têm risco quase nulo.

Conclusão: Extremamente sensível ao risco. Deve ter peso elevado na pontuação.

### Debt Ratio

Maior risco está no Q3 (**2,28% de inadimplência**), não no Q4. O Q4 tem **1,81%** e risco próximo à média.

Conclusão: Variável com efeito não linear. Deve ser usada com cautela, evitando superestimações.

---

### Total de Empréstimos

Q1 apresenta **2,90% de inadimplência** e **risco 2,13x maior**. Q2 a Q4 têm risco menor.

Conclusão: Menor número de empréstimos pode indicar perfil de maior risco. Inversão de expectativa.

---

### Quantidade de Imóveis

Q1 tem **2,59% de inadimplência** e **risco 1,76x maior**. Q4 tem apenas 1,23% e risco 0,64.

Conclusão: Posse de imóveis é fator protetor. Deve ser incluído como redutor de risco.

---

### Outros Bens

Q1 com **2,69% de inadimplência** e **risco 1,87x maior**. Risco reduz à medida que o patrimônio aumenta.

Conclusão: Similar à variável imóveis. Indica estabilidade financeira e menor risco.

---

### Diversidade de Crédito

Q1 apresenta **2,54% de inadimplência** e **risco 1,71x maior**, enquanto Q3 e Q4 têm risco inferior a 1.

Conclusão: Ter mais tipos de crédito pode indicar maturidade financeira. Reduz risco.

## Conclusão Geral

As variáveis com **maior poder de discriminação de risco** (acima de 30x de risco relativo) são:

- using_lines_not_secured_personal_asset
- more_90_days_overdue
- number_times_delayed_payment_loan_30_59_days

Essas devem receber **peso elevado** na pontuação final.

Outras variáveis com influência **moderada a forte**, como age, salary, number_dependents, overdue_60_89, total_loans, diversidade_credito, e patrimônio (imóveis/outros), também são relevantes e devem ser ponderadas de forma proporcional ao risco relativo identificado.

### Criação das variáveis dummys, soma dos riscos para pontuação total e classificação final.

### Objetivo

O objetivo desta etapa foi construir uma **pontuação de risco individual** com base nas variáveis mais relevantes associadas à inadimplência, permitindo a **classificação dos clientes entre bons e maus pagadores**.

### Metodologia

Com base na análise de risco relativo por quartis, foram selecionadas **12 variáveis** com poder discriminativo para prever inadimplência. Para cada variável, foi identificada a faixa (quartil) associada a maior risco. Em seguida, foram criadas **variáveis dummy** (0 ou 1), sinalizando se o cliente pertence à faixa de maior risco.

As variáveis utilizadas foram:

- Idade (Q1 – mais jovens)
- Salário (Q1 – salários mais baixos)
- Número de dependentes (Q4 – mais dependentes)
- Atraso de 30 a 59 dias (Q4)
- Atraso de 60 a 89 dias (Q4)
- Atraso acima de 90 dias (Q4)
- Uso de linhas de crédito (Q4)
- Índice de endividamento – *debt ratio* (Q3)
- Total de empréstimos (Q1 – menos empréstimos)
- Quantidade de imóveis (Q1 – menos imóveis)
- Outros bens (Q1 – menos bens)
- Diversidade de crédito (Q1 – pouca diversidade)

Cada variável de risco soma **1 ponto** à pontuação total.

### Score Final

A **pontuação final (score_risco) varia de 0 a 12**, representando o número de fatores de risco presentes em cada cliente. Quanto maior o score, maior o risco de inadimplência.

### Ponto de Corte

Com base na distribuição da pontuação e nos testes iniciais de performance, foi definido um ponto de corte em **score_risco >= 4** para classificar clientes como:

- **Inadimplente previsto (previsao_inadimplente = 1)**: 4 ou mais fatores de risco
- **Bom pagador previsto (previsao_inadimplente = 0)**: até 3 fatores de risco

Este ponto de corte foi escolhido por equilibrar sensibilidade e especificidade, otimizando o F1 Score nos testes realizados.

### Resultado Esperado

A aplicação deste score possibilita:

- Identificar perfis de alto risco de forma simples e interpretável
- Priorizar ações preventivas e políticas de crédito
- Criar segmentações de clientes com base em múltiplos fatores de risco

### Conclusão

A segmentação por score é uma abordagem eficaz para transformar múltiplos indicadores em uma **ferramenta de decisão unificada**, permitindo que o modelo de inadimplência seja aplicado de forma prática e com forte embasamento estatístico. Essa etapa consolida a análise de risco individual e orienta ações direcionadas ao perfil de cada cliente.

# Matriz de confusão

Para montar a matriz de confusão, selecionei 6 variáveis

| Variável | Nome da Coluna | Quartil de Alto Risco |
| --- | --- | --- |
| Salário | quartil_salario | Q1 (1) |
| Idade | quartil_idade | Q1 (1) |
| Número de dependentes | quartil_dependents | Q4 (4) |
| Atraso de 30 a 59 dias | quartil_atraso_30_59 | Q4 (4) |
| Uso de linhas de crédito | quartil_uso_linhas | Q4 (4) |
| Índice de endividamento | quartil_debt_ratio | Q3 (3) |

Resultado matriz de confusão

|  | Previsto Inadimplente (1) | Previsto Não Inadimplente (0) |
| --- | --- | --- |
| **Real Inadimplente (1)** | Verdadeiro Positivo = 272 | Falso Negativo = 350 |
| **Real Não Inadimplente (0)** | Falso Positivo = 2151 | Verdadeiro Negativo = 32802 |

Cálculo das métricas

![image.png](image.png)

![image.png](image%201.png)

![image.png](image%202.png)

![image.png](image%203.png)

- Total = 272 + 32802 + 2151 + 350 = 35475
- Acurácia:
    
    (272 + 32802) / 35475 ≈ 33074 / 35475 ≈ **0,9315 (93,15%)**
    
- Precisão:
    
    272 / (272 + 2151) = 272 / 2423 ≈ **0,1123 (11,23%)**
    
- Recall:
    
    272 / (272 + 350) = 272 / 622 ≈ **0,4376 (43,76%)**
    
- F1 Score:
    
    2 * (0,1123 * 0,4376) / (0,1123 + 0,4376) ≈ 2 * 0,0492 / 0,5499 ≈ 0,179 (17,9%)
    

Métricas

| Métrica | Valor |
| --- | --- |
| Verdadeiro Positivo | 272 |
| Falso Negativo | 350 |
| Falso Positivo | 2151 |
| Verdadeiro Negativo | 32.802 |
| Total de observações | 35.575 |
| **Acurácia** | 92,97% |
| **Precisão** | 11,23% |
| **Recall** | 43,73% |
| **F1 Score** | 17,87% |

### Variáveis Selecionadas para a Pontuação de Risco

Para a construção do modelo de pontuação de risco, foram selecionadas seis variáveis-chave baseadas na análise de risco relativo por quartis e relevância para a inadimplência:

- **Idade** (quartil 1, clientes mais jovens)
- **Salário mensal** (quartil 1, clientes com salários mais baixos)
- **Número de dependentes** (quartil 4, clientes com maior número de dependentes)
- **Atraso de 30 a 59 dias** (quartil 4, clientes com maior número de atrasos nessa faixa)
- **Uso de linhas de crédito** (quartil 4, clientes com maior uso de linhas de crédito)
- **Índice de endividamento (debt_ratio)** (quartil 3, clientes com endividamento moderado-alto)

Essas variáveis foram transformadas em dummies indicadoras de alto risco e somadas para gerar a pontuação final de risco para cada cliente.

## Modelo  ponto de corte ≥4

Com base na distribuição da pontuação de risco, foi definido o ponto de corte igual a 4. Clientes com pontuação maior ou igual a 4 foram classificados como potenciais inadimplentes, enquanto os demais foram considerados bons pagadores.

### Matriz de Confusão e Métricas de Desempenho

A matriz de confusão avalia o desempenho do modelo de classificação em relação ao indicador real de inadimplência (default_flag):

|  | Previsto Inadimplente | Previsto Não Inadimplente |
| --- | --- | --- |
| **Real Inadimplente** | 272 (Verdadeiro Positivo) | 350 (Falso Negativo) |
| **Real Não Inadimplente** | 2151 (Falso Positivo) | 32.802 (Verdadeiro Negativo) |

Com base nesses valores, as principais métricas calculadas foram:

- **Acurácia:** 92,97%
- **Precisão:** 11,23%
- **Recall (Sensibilidade):** 43,73%
- **F1 Score:** 17,87%

### Interpretação dos Resultados

O modelo apresenta alta acurácia, refletindo a predominância de clientes adimplentes na base de dados. Entretanto, a baixa precisão indica que muitos clientes classificados como inadimplentes pelo modelo não são realmente inadimplentes (alto número de falsos positivos). O recall moderado mostra que menos da metade dos inadimplentes reais são corretamente identificados, evidenciando uma sensibilidade limitada.

O F1 Score baixo reforça a dificuldade em equilibrar a detecção de inadimplentes com a minimização de falsos positivos. Esses resultados sugerem que, embora o modelo seja eficaz para identificar perfis de maior risco, há margem para aprimoramentos, seja por meio do ajuste do ponto de corte, inclusão de novas variáveis ou aplicação de técnicas de modelagem mais complexas.

## Modelo 2 Matriz de Confusão (Ponto de Corte 3)

### Variáveis Utilizadas

Para compor a pontuação de risco, foram usadas as seguintes variáveis transformadas em dummies de alto risco:

- Idade (quartil 1 — mais jovens)
- Salário (quartil 1 — mais baixos)
- Número de dependentes (quartil 4 — mais dependentes)
- Atraso de 30 a 59 dias (quartil 4 — mais atrasos)
- Uso de linhas de crédito (quartil 4 — maior uso)
- Endividamento (debt_ratio, quartil 3 — endividamento moderado)

Resultado:

| Métrica | Valor |
| --- | --- |
| Verdadeiro Positivo | 477 |
| Falso Negativo | 145 |
| Falso Positivo | 6.938 |
| Verdadeiro Negativo | 28.015 |
| Total | 35.575 |
| **Acurácia** | 80,09% |
| **Precisão** | 6,43% |
| **Recall (Sensibilidade)** | 76,69% |
| **F1 Score** | 11,87% |

### Interpretação

O modelo com ponto de corte 3 apresenta:

- **Acurácia moderada (80,09%)**, refletindo que a maior parte dos clientes foi corretamente classificada, sobretudo os adimplentes.
- **Alta sensibilidade (recall 76,69%)**, indicando boa capacidade do modelo em identificar clientes que efetivamente se tornaram inadimplentes.
- **Baixa precisão (6,43%)**, mostrando que muitos clientes foram classificados como inadimplentes, mas na verdade são adimplentes (falsos positivos).
- O **F1 Score baixo (11,87%)** revela o desafio em equilibrar a precisão e recall com esse ponto de corte.

Esse ponto de corte favorece a captura dos inadimplentes, reduzindo o risco de perda por crédito, mas gera um número considerável de falsos positivos, o que pode aumentar custos de análise ou de cobrança indevida.

### Considerações Finais

A escolha do ponto de corte deve considerar o trade-off entre risco de inadimplência e custo operacional para tratar falsos positivos. Se a prioridade for evitar perdas com inadimplência, esse corte pode ser adequado. Para reduzir falsos positivos, é recomendável analisar pontos de corte mais altos ou aprimorar o modelo com novas variáveis ou técnicas.

### Análise de performance da pontuação de risco

| Score (score_risco_6vars) | Total de Clientes | Total Inadimplentes | Taxa de Inadimplência (%) |
| --- | --- | --- | --- |
| 0 | 8.714 | 0 | 0.00% |
| 1 | 10.750 | 15 | 0.14% |
| 2 | 8.696 | 130 | 1.49% |
| 3 | 4.992 | 205 | 4.11% |
| 4 | 1.930 | 179 | 9.27% |
| 5 | 435 | 74 | 17.01% |
| 6 | 58 | 19 | 32.76% |

## **Construção do Dashboard**

### **Representação por Scorecards (Indicadores Resumo)**

Criei **scorecards** com indicadores principais do banco de dados, com o objetivo de apresentar uma visão geral da base. Os campos calculados incluíram:

- **Score médio de risco**
- **Renda média dos inadimplentes**
- **Renda média dos adimplentes**
- **Total de inadimplentes**
- **Total de adimplentes**
- **Percentual de inadimplência**

Esses indicadores permitem compreender rapidamente o perfil financeiro da base e o desempenho geral do modelo de risco.

### **Gráficos Univariados**

Adicionei **gráficos de pizza e barras** para representar a distribuição de clientes por:

- Score de risco (classificado em Baixo, Moderado, Alto e Crítico)
- Situação de inadimplência (Adimplente ou Inadimplente)

Esses gráficos ajudam a visualizar de forma simples a proporção de clientes em cada categoria, facilitando a interpretação da base e da classificação por risco.

### **Gráficos Bivariados e Multivariados**

Para enriquecer a análise, construí **gráficos de barras comparando variáveis de perfil com inadimplência**, como:

- Faixa de uso de linhas de crédito vs inadimplência
- Faixa etária vs inadimplência
- Faixa salarial vs inadimplência
- Quantidade de atrasos de 30 a 59 dias vs inadimplência

Além disso, criei um **mapa de calor multivariado** para cruzar faixa salarial, faixa etária e proporção de inadimplentes. Isso permite identificar perfis mais propensos à inadimplência com maior profundidade.

### **Aplicação de Filtros Interativos**

Implementei **filtros de controle de dados** no painel para permitir a interação e segmentação dos dados. Os filtros disponíveis incluem:

- Score de risco
- Faixa etária
- Faixa salarial
- Situação (Adimplente / Inadimplente)

Esses filtros tornam o dashboard dinâmico, permitindo que diferentes perfis de risco sejam analisados de forma prática e personalizada.

Finalização do dashboard foi montado da seguinte maneira.

## **1. Cabeçalho - Indicadores Principais**

- **Clientes**: 35.575 analisados
- **Média de idade**: 52,53 anos
- **Média de salário**: R$ 6.699,06
- **Inadimplentes**: 622 (≈ 1,7%)

**Insight**: Perfil maduro e classe média. Baixa taxa de inadimplência total.

## **2. Gráficos de Atraso (Pizza)**

### Atraso 30–59 dias:

- **16,4% inadimplentes** → maioria recupera pagamento

### Atraso 60–89 dias:

- **32,9% inadimplentes**

### Atraso >90 dias:

- **36,7% inadimplentes**

**Insight**: Quanto maior o atraso, maior o risco. Atrasos >60 dias indicam clientes críticos.

## **3. Gráfico de Idade (linha)**

- Pico de clientes entre **36 e 55 anos**
- Depois cai um pouco em 65+

 **Insight**: Clientes em idade economicamente ativa predominam, ideal para produtos de crédito.

## **4. Faixa Salarial**

- Maior volume entre **R$ 4.001 e R$ 6.000**
- Poucos clientes com renda acima de R$ 10.000

**Insight**: Público de renda intermediária → foco em crédito pessoal, consignado ou cartão.

## **5. Matriz de Confusão – Modelo de Risco**

| Situação Real / Previsão | Previsto Inadimplente | Previsto Adimplente |
| --- | --- | --- |
| **Inadimplente** | **622** (VP) | **83** (FN) |
| **Adimplente** | **158** (FP) | **35.675** (VN) |

 **Interpretação**:

- O modelo acerta **a maioria dos bons pagadores (VN)**.
- Erra pouco em prever inadimplentes (FN = 83).
- Está **mais conservador**, o que **protege contra risco**, mesmo com alguns falsos positivos (FP).

## **6. Distribuição por Score de Risco**

- Score 1 e 2 concentram mais clientes.
- Score 4 a 6 são **grupos de alto risco com menos clientes**, mas **alta inadimplência**.

**Insight**: Score está bem calibrado. Clientes com score 4+ devem ser **monitorados de perto ou barrados em concessão**.

## **7. Bons x Maus Pagadores**

- 34.953 bons pagadores
- 622 maus pagadores

**Taxa geral de inadimplência ≈ 1,7%**

Excelente base com qualidade. O modelo ajuda a manter isso controlado.

## **Conclusão e Decisões Estratégicas**

| Área | Ação recomendada |
| --- | --- |
| **Concessão de crédito** | Cortar em score ≥ 3 ou exigir garantia |
| **Relacionamento com cliente** | Monitorar atrasos desde 30 dias |
| **Campanhas de marketing** | Focar em faixa etária 36–55 com salário entre 4k–6k |
| **Ajustes no modelo** | Reavaliar falsos positivos (FP = 158) para reduzir negativações injustas |

A análise realizada permitiu desenvolver um modelo de **pontuação de risco de crédito** com base em seis variáveis críticas, relacionadas a perfil sociodemográfico, uso de crédito e histórico de pagamento. Com os dados tratados e transformados em indicadores de risco, foi possível calcular um **score de 0 a 6 para cada cliente**, representando a soma dos fatores de alto risco identificados.

A partir da análise exploratória e da performance do modelo, foi adotada a **nota de corte em score ≥ 3** para classificar clientes como **"potencialmente inadimplentes"**. Esse ponto de corte foi definido com base no crescimento expressivo da taxa de inadimplência a partir dessa faixa, superando os 6%, e chegando a mais de 30% nos scores mais altos (5 e 6).

O dashboard desenvolvido apresenta, de forma clara e interativa:

A **distribuição dos clientes por score de risco**,

A relação entre variáveis como **faixa etária, salário, atrasos e inadimplência**,

E os **indicadores gerais da base**, como renda média, idade média e proporção de inadimplentes.

A **matriz de confusão** demonstra que o modelo tem bom desempenho na identificação dos inadimplentes reais, com **baixa taxa de falsos negativos** (clientes inadimplentes classificados como bons pagadores). Isso é essencial para reduzir perdas financeiras. A taxa de falsos positivos também foi aceitável, favorecendo uma **postura mais conservadora**, o que é adequado em estratégias de crédito preventivo.

Com isso, o modelo proposto e visualizado no dashboard permite:

- **Apoiar decisões automatizadas** na concessão de crédito;
- **Identificar clientes com risco elevado** e priorizar ações de mitigação;
- Fornecer **indicadores claros para gestores**, analistas e stakeholders.

**Conclusão final**:

A análise mostrou que o score de risco é eficaz em prever inadimplência a partir da nota de corte ≥ 3. O uso do dashboard facilita a interpretação dos dados, apoia decisões estratégicas e reforça a importância do uso de dados na gestão do risco de crédito.

## **Apresentar resultados**

**Nesta etapa eu tenho por objetivo criar** uma apresentação limpa e coerente que expresse a lógica usada no marco 1.

**Contexto e Lógica Utilizada**

A partir da hipótese de que determinados perfis de clientes estariam mais propensos à inadimplência, realizei uma análise exploratória e construí um modelo de pontuação de risco com base em **seis variáveis estratégicas**:

- Faixa de salário
- Faixa etária
- Número de dependentes
- Uso de linhas de crédito
- Índice de comprometimento da renda (debt ratio)
- Histórico de atrasos de 30 a 59 dias

Essas variáveis foram transformadas em **indicadores binários de risco**, agrupando os clientes em faixas de maior ou menor vulnerabilidade. A **pontuação final de risco** foi construída como a **soma dos fatores de alto risco**, gerando scores de 0 a 6.

Com base nessa lógica, defini como **nota de corte score ≥ 3** para classificar clientes como de **alto risco de inadimplência**.

### **Visualização dos Resultados no Dashboard**

Para apresentar os resultados de forma intuitiva, montei um **dashboard interativo no Looker Studio**, com os seguintes componentes:

- **Scorecards** com indicadores gerais (total de clientes, idade média, renda média, percentual de inadimplência);
- **Gráficos univariados e bivariados** para mostrar a distribuição da inadimplência por score, idade, faixa salarial e atrasos;
- **Mapa de calor** cruzando faixa etária, renda e proporção de inadimplentes;
- **Matriz de confusão** validando a performance do modelo com base nas previsões feitas;
- **Filtros interativos** que permitem segmentar os dados por score, idade, renda e situação do cliente.

Essas visualizações foram organizadas para **refletir o raciocínio analítico**, facilitar a leitura dos dados e apoiar decisões estratégicas.

### **Conclusão Visual da Análise**

A apresentação mostrou que, a partir do score de risco ≥ 3, há um aumento expressivo da inadimplência, o que valida o ponto de corte escolhido. A matriz de confusão indicou boa performance do modelo, com baixos índices de erro.

A organização visual e os filtros tornam o painel **uma ferramenta útil para gestão de risco**, análise de perfis e tomada de decisões baseadas em dados.

### Apresentar resultados com conclusões e recomendações

**Nesta etapa tenho por objetivo a**presentar, além dos resultados, conclusões referentes aos achados encontrados no marco 1

### Conclusão e Recomendações Estratégicas

Com base na análise de dados e na criação do modelo de pontuação de risco (com nota de corte definida em score ≥ 3), foi possível identificar perfis distintos de inadimplência e propor estratégias segmentadas para diferentes áreas do banco.

Na **concessão de crédito**, recomenda-se manter o corte em score ≥ 3 para classificar clientes como de maior risco. Para esses perfis, o crédito deve ser condicionado a garantias, valores reduzidos ou alternativas como cartões pré-pagos. Já clientes com score entre 0 e 2 (baixo risco) devem receber ofertas com taxas mais competitivas e maiores limites.

No **relacionamento com o cliente**, observou-se forte associação entre atrasos iniciais (a partir de 30 dias) e inadimplência futura. Assim, é fundamental implementar ações de monitoramento precoce e renegociação preventiva para evitar agravamento do risco.

Em **campanhas e produtos personalizados**, recomenda-se a segmentação baseada no score de risco:

- **Score 0 a 2 (baixo risco):** ofertas com taxas atrativas e maior limite.
- **Score 3 a 4 (risco intermediário):** crédito moderado, com condições personalizadas.
- **Score ≥ 5 (alto risco):** crédito com valor reduzido, exigência de garantias ou modelos pré-pagos.

Além disso, clientes entre 36 e 55 anos, com renda entre R$4.000 e R$6.000, demonstraram boa performance e devem ser priorizados em ações de marketing e fidelização.

Para **redução da inadimplência e recuperação de clientes**, é estratégico oferecer condições especiais de renegociação, associadas a campanhas de reeducação financeira. Também é essencial revisar os “falsos positivos”, clientes classificados como inadimplentes que, na prática, pagam em dia, atualizando cadastros e orientando sobre como melhorar seu score.

No que se refere ao **aprimoramento contínuo do modelo**, recomenda-se:

- Testar novos pontos de corte, conforme os objetivos estratégicos do banco (crescimento vs. segurança).
- Treinar o modelo com novos dados reais, a partir do comportamento de pagamento dos clientes.
- Monitorar a matriz de confusão periodicamente e ajustar os pesos das variáveis conforme os resultados observados.

Essas ações integradas tornam o modelo mais robusto, a gestão de crédito mais eficaz e contribuem para decisões mais justas, estratégicas e baseadas em evidências.

A estratégia adotada permitiu identificar com maior precisão os perfis de maior risco de inadimplência, utilizando variáveis comportamentais e financeiras. Com a definição do corte no score ≥ 3, foi possível equilibrar a segurança do banco com a concessão de crédito. O modelo gerado serve como base para decisões mais eficientes, campanhas personalizadas e melhorias contínuas no processo de análise de risco.

## Gráficos e tabelas do projeto

![image.png](image%204.png)

![image.png](image%205.png)

![image.png](image%206.png)

![image.png](image%207.png)

![image.png](image%208.png)

![image.png](image%209.png)

![image.png](image%2010.png)

![image.png](image%2011.png)

![image.png](image%2012.png)

![image.png](image%2013.png)

![image.png](image%2014.png)

![image.png](image%2015.png)

![image.png](image%2016.png)

![image.png](image%2017.png)

## Links úteis

### Vídeo de apresentação

[https://www.loom.com/share/6d0ef59077974017a60e958632ebce2a?sid=9092c65f-38ed-464d-b621-f5a52e6e8dbf](https://www.loom.com/share/6d0ef59077974017a60e958632ebce2a?sid=9092c65f-38ed-464d-b621-f5a52e6e8dbf)

### Colab (criação gráfico matriz de confusão)

[https://colab.research.google.com/drive/1eWvp64m3i0UNQiOkUMGE5IW3GryFXI36?usp=sharing](https://colab.research.google.com/drive/1eWvp64m3i0UNQiOkUMGE5IW3GryFXI36?usp=sharing)

### Dashboard Looker Studio

[https://lookerstudio.google.com/reporting/68916e40-4e36-45db-a731-0298c252f0ae](https://lookerstudio.google.com/reporting/68916e40-4e36-45db-a731-0298c252f0ae)