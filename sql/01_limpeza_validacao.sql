-- =====================================================
-- 01. LIMPEZA E VALIDAÇÃO DOS DADOS
-- Projeto: People Analytics com SQL
-- Banco de dados: SQL Server
--
-- Objetivo: identificar registros vazios, verificar
-- duplicidades, analisar valores nulos e validar
-- a consistência das tabelas utilizadas no projeto.
--
-- As tabelas de trabalho são recriadas a partir das
-- tabelas originais a cada execução, garantindo que
-- o processo de limpeza seja reproduzível.
--
-- Fonte dos dados: Human Resources Data Set - Kaggle
-- Autor do dataset: Rich Huebner
-- Dados sintéticos utilizados para fins de análise.
-- =====================================================


-- =====================================================
-- CRIAÇÃO DAS TABELAS DE TRABALHO
-- =====================================================

DROP TABLE IF EXISTS funcionarios;

SELECT *
INTO funcionarios
FROM funcionarios_original;

DROP TABLE IF EXISTS custos_recrutamento;

SELECT *
INTO custos_recrutamento
FROM custos_recrutamento_original;


-- =====================================================
-- TABELA: FUNCIONARIOS
-- =====================================================

-- 1. Quantidade inicial de registros

SELECT COUNT(*) AS Total_Registros
FROM funcionarios;

-- A base importada possui 401 registros.


-- 2. Verificação de registros sem identificação

SELECT COUNT(*) AS Registros_Sem_EmpID
FROM funcionarios
WHERE EmpID IS NULL;

-- Foram encontrados 91 registros sem EmpID.


-- 3. Inspeção dos registros sem identificação

SELECT *
FROM funcionarios
WHERE EmpID IS NULL;

-- A inspeção mostrou que os 91 registros estavam completamente vazios.


-- 4. Remoção de registros com todas as colunas nulas

DELETE FROM funcionarios
WHERE EmpID IS NULL
  AND Employee_Name IS NULL
  AND MarriedID IS NULL
  AND MaritalStatusID IS NULL
  AND GenderID IS NULL
  AND EmpStatusID IS NULL
  AND DeptID IS NULL
  AND PerfScoreID IS NULL
  AND FromDiversityJobFairID IS NULL
  AND PayRate IS NULL
  AND Termd IS NULL
  AND PositionID IS NULL
  AND Position IS NULL
  AND State IS NULL
  AND Zip IS NULL
  AND DOB IS NULL
  AND Sex IS NULL
  AND MaritalDesc IS NULL
  AND CitizenDesc IS NULL
  AND HispanicLatino IS NULL
  AND RaceDesc IS NULL
  AND DateofHire IS NULL
  AND DateofTermination IS NULL
  AND TermReason IS NULL
  AND EmploymentStatus IS NULL
  AND Department IS NULL
  AND ManagerName IS NULL
  AND ManagerID IS NULL
  AND RecruitmentSource IS NULL
  AND PerformanceScore IS NULL
  AND EngagementSurvey IS NULL
  AND EmpSatisfaction IS NULL
  AND SpecialProjectsCount IS NULL
  AND LastPerformanceReview_Date IS NULL
  AND DaysLateLast30 IS NULL;

-- O filtro exige que todas as colunas estejam nulas.
-- Registros sem EmpID que contenham outras informações
-- são preservados para investigação.


-- 5. Validação após a limpeza

SELECT COUNT(*) AS Total_Registros
FROM funcionarios;

SELECT COUNT(*) AS Registros_Sem_EmpID
FROM funcionarios
WHERE EmpID IS NULL;

-- Após a remoção, restaram 310 registros e nenhum registro sem EmpID.


-- 6. Verificação de funcionários duplicados

SELECT
	EmpID AS ID_Funcionario,
	COUNT(*) AS Quantidade
FROM funcionarios
GROUP BY EmpID
HAVING COUNT(*) > 1;

-- Não foram encontrados funcionários com EmpID duplicado.


-- 7. Verificação de valores ausentes

SELECT
	SUM(CASE WHEN Employee_Name IS NULL THEN 1 ELSE 0 END) AS Employee_Name,
	SUM(CASE WHEN EmpID IS NULL THEN 1 ELSE 0 END) AS EmpID,
	SUM(CASE WHEN MarriedID IS NULL THEN 1 ELSE 0 END) AS MarriedID,
	SUM(CASE WHEN MaritalStatusID IS NULL THEN 1 ELSE 0 END) AS MaritalStatusID,
	SUM(CASE WHEN GenderID IS NULL THEN 1 ELSE 0 END) AS GenderID,
	SUM(CASE WHEN EmpStatusID IS NULL THEN 1 ELSE 0 END) AS EmpStatusID,
	SUM(CASE WHEN DeptID IS NULL THEN 1 ELSE 0 END) AS DeptID,
	SUM(CASE WHEN PerfScoreID IS NULL THEN 1 ELSE 0 END) AS PerfScoreID,
	SUM(CASE WHEN FromDiversityJobFairID IS NULL THEN 1 ELSE 0 END) AS FromDiversityJobFairID,
	SUM(CASE WHEN PayRate IS NULL THEN 1 ELSE 0 END) AS PayRate,
	SUM(CASE WHEN Termd IS NULL THEN 1 ELSE 0 END) AS Termd,
	SUM(CASE WHEN PositionID IS NULL THEN 1 ELSE 0 END) AS PositionID,
	SUM(CASE WHEN Position IS NULL THEN 1 ELSE 0 END) AS Position,
	SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State,
	SUM(CASE WHEN Zip IS NULL THEN 1 ELSE 0 END) AS Zip,
	SUM(CASE WHEN DOB IS NULL THEN 1 ELSE 0 END) AS DOB,
	SUM(CASE WHEN Sex IS NULL THEN 1 ELSE 0 END) AS Sex,
	SUM(CASE WHEN MaritalDesc IS NULL THEN 1 ELSE 0 END) AS MaritalDesc,
	SUM(CASE WHEN CitizenDesc IS NULL THEN 1 ELSE 0 END) AS CitizenDesc,
	SUM(CASE WHEN HispanicLatino IS NULL THEN 1 ELSE 0 END) AS HispanicLatino,
	SUM(CASE WHEN RaceDesc IS NULL THEN 1 ELSE 0 END) AS RaceDesc,
	SUM(CASE WHEN DateofHire IS NULL THEN 1 ELSE 0 END) AS DateofHire,
	SUM(CASE WHEN DateofTermination IS NULL THEN 1 ELSE 0 END) AS DateofTermination,
	SUM(CASE WHEN TermReason IS NULL THEN 1 ELSE 0 END) AS TermReason,
	SUM(CASE WHEN EmploymentStatus IS NULL THEN 1 ELSE 0 END) AS EmploymentStatus,
	SUM(CASE WHEN Department IS NULL THEN 1 ELSE 0 END) AS Department,
	SUM(CASE WHEN ManagerName IS NULL THEN 1 ELSE 0 END) AS ManagerName,
	SUM(CASE WHEN ManagerID IS NULL THEN 1 ELSE 0 END) AS ManagerID,
	SUM(CASE WHEN RecruitmentSource IS NULL THEN 1 ELSE 0 END) AS RecruitmentSource,
	SUM(CASE WHEN PerformanceScore IS NULL THEN 1 ELSE 0 END) AS PerformanceScore,
	SUM(CASE WHEN EngagementSurvey IS NULL THEN 1 ELSE 0 END) AS EngagementSurvey,
	SUM(CASE WHEN EmpSatisfaction IS NULL THEN 1 ELSE 0 END) AS EmpSatisfaction,
	SUM(CASE WHEN SpecialProjectsCount IS NULL THEN 1 ELSE 0 END) AS SpecialProjectsCount,
	SUM(CASE WHEN LastPerformanceReview_Date IS NULL THEN 1 ELSE 0 END) AS LastPerformanceReview_Date,
	SUM(CASE WHEN DaysLateLast30 IS NULL THEN 1 ELSE 0 END) AS DaysLateLast30
FROM funcionarios;

/*
Após a exclusão das linhas vazias e antes dos demais
tratamentos, foram encontrados valores nulos
em 5 das 35 colunas:
*/
-- DateofTermination: 207
-- TermReason: 1
-- ManagerID: 8
-- LastPerformanceReview_Date: 103
-- DaysLateLast30: 103


-- 8. Validação dos valores ausentes em DateofTermination

SELECT
	Termd,
	COUNT(*) AS Quantidade
FROM funcionarios
WHERE DateofTermination IS NULL
GROUP BY Termd;

/*
Os 207 valores nulos em DateofTermination correspondem a funcionários
não desligados (Termd = 0), portanto não necessitam de tratamento.
*/


-- 9. Validação do valor ausente em TermReason

SELECT
	EmpID,
	EmploymentStatus,
	Termd,
	DateofTermination,
	TermReason
FROM funcionarios
WHERE TermReason IS NULL;

/*
Foi identificado um funcionário desligado (Termd = 1) sem motivo
de desligamento registrado em TermReason.
*/


-- Tratamento do valor ausente

UPDATE funcionarios
SET TermReason = 'Não informado'
WHERE EmpID = 1211050782 AND Termd = 1 AND TermReason IS NULL;


-- Validação após o tratamento

SELECT
	EmpID,
	EmploymentStatus,
	Termd,
	DateofTermination,
	TermReason
FROM funcionarios
WHERE EmpID = 1211050782;

/*
O valor ausente foi substituído por 'Não informado', preservando
o registro do funcionário sem atribuir um motivo de desligamento desconhecido.
*/


-- 10. Validação dos valores ausentes em ManagerID

SELECT 
	EmpID,
	Position,
	Department,
	ManagerName,
	ManagerID
FROM funcionarios
WHERE ManagerID IS NULL;

-- Os 8 registros sem ManagerID possuem Webster Butler como ManagerName.


-- Verificação do ManagerID associado a Webster Butler

SELECT DISTINCT
	ManagerName,
	ManagerID
FROM funcionarios
WHERE ManagerName = 'Webster Butler';

-- Webster Butler aparece associado ao ManagerID 39 nos registros preenchidos.


-- Tratamento dos valores ausentes

UPDATE funcionarios
SET ManagerID = 39
WHERE ManagerID IS NULL AND ManagerName = 'Webster Butler';


-- Validação após o tratamento

SELECT 
	COUNT(*) AS ManagerID_Nulos
FROM funcionarios
WHERE ManagerID IS NULL;

-- Os 8 valores ausentes foram preenchidos com o ManagerID 39.
-- Após o tratamento, não restaram valores nulos em ManagerID.
	

-- 11. Validação dos valores ausentes em LastPerformanceReview_Date

SELECT 
	Termd,
	COUNT(*) AS Quantidade
FROM funcionarios
WHERE LastPerformanceReview_Date IS NULL
GROUP BY Termd;

/*
Os 103 valores nulos em LastPerformanceReview_Date pertencem a funcionários
desligados (Termd = 1). Como não há informação disponível sobre a data da
última avaliação, os valores foram mantidos como NULL.
*/


-- 12. Validação dos valores ausentes em DaysLateLast30

SELECT
	Termd,
	COUNT(*) AS Quantidade
FROM funcionarios
WHERE DaysLateLast30 IS NULL
GROUP BY Termd;

/*
Os 103 valores nulos em DaysLateLast30 pertencem a funcionários
desligados (Termd = 1). Como não há informação disponível sobre atrasos
nos últimos 30 dias, os valores foram mantidos como NULL.
*/

-- 12.1 Validação dos tipos de dados

SELECT
    COLUMN_NAME AS Coluna,
    DATA_TYPE AS Tipo_Dado
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'funcionarios'
ORDER BY ORDINAL_POSITION;

/*
Os tipos de dados das 35 colunas foram verificados após a importação.

As colunas apresentam tipos compatíveis com as informações armazenadas,
incluindo datas como date, campos textuais como nvarchar e campos
numéricos e indicadores em tipos numéricos apropriados.

Não foram identificados tipos de dados que necessitassem de correção.
*/

-- 12.2 Validação da coerência dos desligamentos

SELECT
    Termd,
    EmploymentStatus,
    COUNT(*) AS Quantidade,
    SUM(CASE 
        WHEN DateofTermination IS NULL THEN 1 
        ELSE 0 
    END) AS Sem_Data_Desligamento
FROM funcionarios
GROUP BY Termd, EmploymentStatus
ORDER BY Termd, EmploymentStatus;

/*
A validação demonstrou consistência entre o indicador Termd,
o status de emprego e a data de desligamento.

Os 207 funcionários com Termd = 0 não possuem data de desligamento,
enquanto os 103 funcionários com Termd = 1 possuem data preenchida.

Não foram identificadas inconsistências entre essas informações.
*/

-- 12.3 Validação da escala de satisfação

SELECT
    MIN(EmpSatisfaction) AS Satisfacao_Minima,
    MAX(EmpSatisfaction) AS Satisfacao_Maxima
FROM funcionarios;

/*
A variável EmpSatisfaction apresentou valores entre 1 e 5,
em conformidade com a escala definida no dataset.

Não foram identificados valores fora da faixa esperada.
*/


-- 13. Validação final da limpeza dos dados

SELECT
	COUNT(*) AS Total_Registros,
	SUM(CASE WHEN EmpID IS NULL THEN 1 ELSE 0 END) AS EmpID_Nulos,
	COUNT(EmpID) - COUNT(DISTINCT EmpID) AS Registros_Duplicados_Excedentes,
	SUM(CASE WHEN TermReason IS NULL THEN 1 ELSE 0 END) AS TermReason_Nulos,
	SUM(CASE WHEN ManagerID IS NULL THEN 1 ELSE 0 END) AS ManagerID_Nulos
FROM funcionarios;

/*
Na execução inicial, a validação final registrou 310 linhas,
sem EmpID nulo ou duplicado e sem valores nulos em
TermReason e ManagerID.

Os 207 valores nulos em DateofTermination foram mantidos
por corresponderem a funcionários não desligados (Termd = 0).

Os 103 valores nulos em LastPerformanceReview_Date e os
103 em DaysLateLast30 foram mantidos por não haver informação
suficiente para preenchê-los. Essas ausências foram observadas
em funcionários desligados (Termd = 1), sem determinação
da causa da ausência.
*/


-- =====================================================
-- TABELA: CUSTOS_RECRUTAMENTO
-- =====================================================

-- 1. Quantidade inicial de registros

SELECT COUNT(*) AS Total_Registros
FROM custos_recrutamento;

-- A tabela custos_recrutamento possui 22 registros.


-- 2. Verificação de fontes de recrutamento duplicadas

SELECT
    Employment_Source AS Fonte_Recrutamento,
    COUNT(*) AS Quantidade
FROM custos_recrutamento
GROUP BY Employment_Source
HAVING COUNT(*) > 1;

-- Nenhuma fonte de recrutamento duplicada foi identificada.


-- 3. Verificação de valores nulos

SELECT
    SUM(CASE WHEN Employment_Source IS NULL THEN 1 ELSE 0 END) AS Nulos_Employment_Source,
    SUM(CASE WHEN January IS NULL THEN 1 ELSE 0 END) AS Nulos_January,
    SUM(CASE WHEN February IS NULL THEN 1 ELSE 0 END) AS Nulos_February,
    SUM(CASE WHEN March IS NULL THEN 1 ELSE 0 END) AS Nulos_March,
    SUM(CASE WHEN April IS NULL THEN 1 ELSE 0 END) AS Nulos_April,
    SUM(CASE WHEN May IS NULL THEN 1 ELSE 0 END) AS Nulos_May,
    SUM(CASE WHEN June IS NULL THEN 1 ELSE 0 END) AS Nulos_June,
    SUM(CASE WHEN July IS NULL THEN 1 ELSE 0 END) AS Nulos_July,
    SUM(CASE WHEN August IS NULL THEN 1 ELSE 0 END) AS Nulos_August,
    SUM(CASE WHEN September IS NULL THEN 1 ELSE 0 END) AS Nulos_September,
    SUM(CASE WHEN October IS NULL THEN 1 ELSE 0 END) AS Nulos_October,
    SUM(CASE WHEN November IS NULL THEN 1 ELSE 0 END) AS Nulos_November,
    SUM(CASE WHEN December IS NULL THEN 1 ELSE 0 END) AS Nulos_December,
    SUM(CASE WHEN Total IS NULL THEN 1 ELSE 0 END) AS Nulos_Total
FROM custos_recrutamento;

-- Não foram identificados valores nulos na tabela.


-- 4. Validação do custo total por fonte de recrutamento

SELECT
    Employment_Source AS Fonte_Recrutamento,
    Total AS Custo_Total,
    (January + February + March + April + May + June +
    July + August + September + October + November + December)
        AS Soma_Custos_Mensais
FROM custos_recrutamento
WHERE Total <> (
    January + February + March + April + May + June +
    July + August + September + October + November + December
);

/*
Foram identificadas 3 fontes de recrutamento em que o custo total
informado não corresponde à soma dos custos mensais:

- Pay Per Click: Total = 1323 | Soma mensal = 1325
- Pay Per Click - Google: Total = 3509 | Soma mensal = 3510
- Website Banner Ads: Total = 7143 | Soma mensal = 7145

Como não há evidências para identificar um mês específico como incorreto,
a soma dos custos mensais será utilizada para corrigir o valor de Total.
*/


-- 5. Correção dos custos totais inconsistentes

UPDATE custos_recrutamento
SET Total =
    January + February + March + April + May + June +
    July + August + September + October + November + December
WHERE Total <> (
    January + February + March + April + May + June +
    July + August + September + October + November + December
);

-- Validação após a correção dos custos totais

SELECT
    Employment_Source AS Fonte_Recrutamento,
    Total AS Custo_Total,
    January + February + March + April + May + June +
    July + August + September + October + November + December
        AS Soma_Custos_Mensais
FROM custos_recrutamento
WHERE Total <> (
    January + February + March + April + May + June +
    July + August + September + October + November + December
);

-- Após a correção, nenhuma inconsistência foi identificada entre
-- o custo total e a soma dos custos mensais.


-- 6. Verificação de fontes com custo zerado em todos os meses

SELECT *
FROM custos_recrutamento
WHERE January = 0
    AND February = 0
    AND March = 0
    AND April = 0
    AND May = 0
    AND June = 0
    AND July = 0
    AND August = 0
    AND September = 0
    AND October = 0
    AND November = 0
    AND December = 0
    AND Total = 0;

/*
Foram identificadas 8 fontes de recrutamento com custo igual a zero
em todos os meses e no custo total.

Como não há evidências de que esses valores representem dados ausentes
ou incorretos, os registros foram mantidos sem alteração.
*/


-- 7. Validação da correspondência das fontes entre as tabelas

SELECT DISTINCT
    f.RecruitmentSource AS Fonte_Funcionarios
FROM funcionarios AS f
LEFT JOIN custos_recrutamento AS c
    ON f.RecruitmentSource = c.Employment_Source
WHERE c.Employment_Source IS NULL;

/*
A fonte de recrutamento "Indeed" está presente na tabela funcionarios,
mas não possui correspondência na tabela custos_recrutamento.

Como não há informação disponível sobre o custo dessa fonte,
nenhum valor foi estimado ou inserido.
*/