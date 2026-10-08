# People Analytics com SQL — Análise de Turnover

## 📌 Sobre o projeto

Este projeto tem como objetivo analisar dados de funcionários utilizando SQL para identificar padrões relacionados aos desligamentos e gerar insights que possam apoiar decisões de gestão de pessoas.

O projeto contempla a preparação e validação dos dados, análise exploratória de indicadores de People Analytics e investigação das fontes e custos de recrutamento.

## 🎯 Problema de negócio

Uma empresa deseja compreender melhor os desligamentos de funcionários, identificar diferenças entre grupos e avaliar informações relacionadas ao recrutamento.

A análise busca responder perguntas como:

- Quais departamentos apresentam maior proporção de funcionários desligados?
- Quais são os principais motivos de desligamento?
- Existem diferenças de satisfação, engajamento, desempenho e remuneração entre funcionários desligados e não desligados?
- Qual é o tempo médio de permanência dos funcionários desligados?
- Quais fontes de recrutamento apresentam maiores proporções de desligamento?
- Como os custos registrados de recrutamento variam entre as fontes?

Os resultados são interpretados considerando as limitações da base, sem estabelecer relações de causa a partir de associações observadas.

## 📊 Dataset

O projeto utiliza o **Human Resources Data Set**, um conjunto de dados sintético desenvolvido para estudos de métricas e analytics de Recursos Humanos.

As análises utilizam os seguintes arquivos:

- `HRDataset_v13.csv`: informações dos funcionários, incluindo departamentos, remuneração, desempenho, satisfação, recrutamento e desligamentos.
- `recruiting_costs.csv`: custos de recrutamento registrados por fonte.

A interpretação das variáveis foi baseada no codebook da versão 13 do dataset.

- [Human Resources Data Set — Kaggle](https://www.kaggle.com/datasets/rhuebner/human-resources-data-set)
- [Codebook — HR Dataset v13](https://rstudio-pubs-static.s3.amazonaws.com/533656_c5f4745185604cf2a8774f9688c5b9f1.html)

## 🔎 Etapas do projeto

### 1. Limpeza e validação dos dados

Foram realizadas verificações e tratamentos nas bases de funcionários e custos de recrutamento, incluindo:

- Identificação e remoção de 91 registros completamente vazios da base de funcionários, mantendo 310 registros válidos;
- Verificação de identificadores duplicados e valores ausentes;
- Investigação e tratamento de informações ausentes quando havia evidência suficiente;
- Preservação de valores nulos sem justificativa para substituição;
- Correção das escalas de `EngagementSurvey` e `PayRate`, afetadas pela importação;
- Validação dos tipos de dados e da consistência dos desligamentos;
- Correção de divergências entre os custos mensais e os totais registrados;
- Verificação da correspondência entre as fontes de recrutamento das duas bases.

As tabelas originais foram preservadas, e as tabelas de trabalho são recriadas para permitir a reprodução dos tratamentos.

**Arquivo:** `sql/01_limpeza_validacao.sql`

### 2. Análise exploratória dos dados

Foram desenvolvidas 11 análises para compreender o perfil da base e investigar padrões relacionados aos desligamentos.

As análises abordaram:

- Distribuição dos funcionários por status e departamento;
- Proporção e tipos de desligamento por departamento;
- Principais motivos de desligamento voluntário;
- Satisfação e engajamento por status de desligamento;
- Satisfação por motivo de desligamento;
- Desempenho e remuneração por status de desligamento;
- Tempo médio de permanência até o desligamento.

**Principais resultados:**

- Foram identificados 103 funcionários desligados entre os 310 registros válidos;
- O departamento Production apresentou 83 desligamentos entre 208 funcionários (39,90%);
- A satisfação média e o engajamento médio foram semelhantes entre os grupos de desligados e não desligados;
- A remuneração média registrada foi de US$ 27,00 por hora entre os desligados e US$ 33,41 entre os não desligados;
- O tempo médio de permanência dos funcionários desligados foi de aproximadamente 25,12 meses.

As proporções de desligamento representam os registros históricos da base, não taxas de turnover calculadas para um período específico.

**Arquivo:** `sql/02_analise_exploratoria.sql`

### 3. Análise de recrutamento — em andamento

Esta etapa investiga as fontes de recrutamento e os custos registrados, utilizando consultas com agregações e relacionamento entre tabelas.

**Análises realizadas:**

1. Quantidade de funcionários, desligamentos e percentual de desligamento por fonte de recrutamento;
2. Custos totais registrados por fonte de recrutamento;
3. Custo registrado por funcionário recrutado, utilizando `LEFT JOIN` entre as tabelas.

**Resultados preliminares:**

- `Employee Referral` apresentou 31 funcionários e proporção de desligamento de 12,90%;
- `Search Engine - Google Bing Yahoo` apresentou 60,00% de desligamentos entre 25 funcionários;
- `Diversity Job Fair` apresentou 55,17% entre 29 funcionários;
- `Careerbuilder` apresentou custo registrado de US$ 7.790,00 para um funcionário;
- `Indeed` não possui correspondência na tabela de custos de recrutamento.

Os custos registrados não necessariamente representam todas as despesas reais de recrutamento. O custo por funcionário é tratado como indicador exploratório, pois não foi confirmada a correspondência temporal entre custos e contratações.

**Arquivo:** `sql/03_analise_recrutamento.sql`

## 🛠️ Tecnologias

- SQL Server
- SQL (T-SQL)
- Git
- GitHub

## 📁 Estrutura do projeto

```text
people-analytics-sql/
│
├── data/
│   ├── HRDataset_v13.csv
│   └── recruiting_costs.csv
│
├── sql/
│   ├── 01_limpeza_validacao.sql
│   ├── 02_analise_exploratoria.sql
│   └── 03_analise_recrutamento.sql
│
└── README.md
```

## 🚧 Status do projeto

**Em desenvolvimento.**

- [x] Importação dos dados
- [x] Limpeza e validação
- [x] Análise exploratória
- [ ] Análise de recrutamento e custos — em andamento
- [ ] Consolidação dos resultados e conclusões finais