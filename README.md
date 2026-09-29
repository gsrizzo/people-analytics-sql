# People Analytics com SQL — Análise de Turnover

## 📌 Sobre o projeto

Este projeto tem como objetivo analisar dados de funcionários utilizando SQL para identificar padrões relacionados ao turnover e gerar insights que possam apoiar decisões de gestão de pessoas.

O projeto parte da preparação e validação dos dados e avança para análises relacionadas a desligamentos, perfil dos funcionários e indicadores de People Analytics.

## 🎯 Problema de negócio

Uma empresa deseja compreender melhor os desligamentos de funcionários e identificar padrões que possam auxiliar na análise da rotatividade de funcionários.

A análise buscará responder perguntas como:

- Quais departamentos apresentam maior taxa de turnover?
- Quais cargos possuem maior número de desligamentos?
- Qual é o tempo médio de permanência dos funcionários?
- Existem diferenças salariais entre funcionários ativos e desligados?
- Funcionários com menor satisfação ou engajamento apresentam maior frequência de desligamento?
- Quais são os principais motivos de desligamento?
- Existem padrões relacionados a desempenho, atrasos ou outras características dos funcionários?

## 📊 Dataset

O projeto utiliza o **Human Resources Data Set**, um conjunto de dados sintético desenvolvido para estudos de métricas e analytics de Recursos Humanos.

Arquivo utilizado na análise:

`HRDataset_v13.csv`

A interpretação das variáveis foi baseada no codebook oficial da versão 13 disponibilizado pelo autor do dataset.

- [Human Resources Data Set — Kaggle](https://www.kaggle.com/datasets/rhuebner/human-resources-data-set)
- [Codebook — HR Dataset v13](https://rstudio-pubs-static.s3.amazonaws.com/533656_c5f4745185604cf2a8774f9688c5b9f1.html)

## 🔎 Etapas do projeto

### 1. Limpeza e validação dos dados

A etapa inicial incluiu:

- Verificação da quantidade de registros;
- Identificação e remoção de registros completamente vazios;
- Verificação de funcionários duplicados;
- Identificação de valores ausentes;
- Investigação dos valores ausentes com base no contexto das variáveis;
- Tratamento de valores ausentes quando havia informação suficiente para realizar a correção;
- Preservação de valores nulos quando não havia evidência para substituí-los;
- Validação final da base após os tratamentos.

As consultas estão disponíveis em:

`sql/01_limpeza_validacao.sql`

## 🛠️ Tecnologias

- SQL Server
- SQL
- Git
- GitHub

## 📁 Estrutura do projeto

```text
people-analytics-sql/
│
├── data/
│   └── HRDataset_v13.csv
│
├── sql/
│   └── 01_limpeza_validacao.sql
│
└── README.md
```

## 🚧 Status do projeto

Em desenvolvimento.

- [x] Importação dos dados
- [x] Limpeza e validação
- [ ] Análise exploratória
- [ ] Análise de turnover
- [ ] Análises avançadas
- [ ] Conclusões e insights