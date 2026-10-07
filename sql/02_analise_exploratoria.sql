-- =====================================================
-- 02. ANÁLISE EXPLORATÓRIA DOS DADOS
-- Projeto: People Analytics com SQL
-- =====================================================

/*
Objetivo:
Explorar as principais características da base de funcionários,
fornecendo contexto para as análises posteriores de turnover.
*/

-- Pré-requisito: executar 01_limpeza_validacao.sql.
-- Os resultados comentados consideram a base tratada, com 310 registros.


-- 1. Distribuição dos funcionários por status

SELECT
	EmploymentStatus AS Status_Emprego,
	COUNT(*) AS Quantidade_Funcionarios,
	CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS Percentual
FROM funcionarios
GROUP BY EmploymentStatus
ORDER BY Quantidade_Funcionarios DESC;

/*
A base possui 182 funcionários ativos (58,71%). Entre os desligados,
88 tiveram desligamento voluntário (28,39%) e 15 foram desligados por
justa causa (4,84%), totalizando 103 funcionários desligados (33,23%).
Há ainda 14 funcionários afastados (4,52%) e 11 com início futuro (3,55%).
*/


-- 2. Distribuição dos funcionários por departamento

SELECT
	Department AS Departamento,
	COUNT(*) AS Quantidade_Funcionarios
FROM funcionarios
GROUP BY Department
ORDER BY Quantidade_Funcionarios DESC;

/*
O departamento Production concentra a maior quantidade de funcionários,
com 208 registros, seguido por IT/IS, com 50, e Sales, com 31.
Os demais departamentos possuem 10 funcionários ou menos.
*/


-- 3. Percentual de funcionários desligados por departamento

SELECT
	Department AS Departamento,
	COUNT(*) AS Total_Funcionarios,
	SUM(
		CASE
			WHEN Termd = 1 THEN 1
			ELSE 0
		END
	) AS Funcionarios_Desligados,
	CAST(
		SUM(
			CASE
				WHEN Termd = 1 THEN 1
				ELSE 0
			END
		) * 100.0 / COUNT(*)
		AS DECIMAL(5,2)
	) AS Percentual_Desligados
FROM funcionarios
GROUP BY Department
ORDER BY Percentual_Desligados DESC;

/*
O percentual considera todos os registros do departamento na base,
incluindo funcionários com início futuro, sem recorte temporal.

Production apresenta a maior proporção de funcionários desligados,
com 83 desligamentos entre 208 funcionários (39,90%).

Admin Offices e Software Engineering apresentam um percentual de 30,00%,
porém ambos possuem apenas 10 funcionários, o que exige cautela
na comparação devido ao tamanho reduzido desses grupos.

IT/IS apresenta um percentual de 20,00% e Sales, 12,90%.
Executive Office não registrou desligamentos, mas possui apenas
um funcionário na base.
*/


-- 4. Tipos de desligamento por departamento

SELECT
	Department AS Departamento,
	SUM(
		CASE
			WHEN EmploymentStatus = 'Voluntarily Terminated' THEN 1
			ELSE 0
		END
	) AS Desligamentos_Voluntarios,
	SUM(
		CASE
			WHEN EmploymentStatus = 'Terminated for Cause' THEN 1
			ELSE 0
		END
	) AS Desligamentos_Justa_Causa,
	SUM(
		CASE
			WHEN Termd = 1 THEN 1
			ELSE 0
		END
	) AS Total_Desligados
FROM funcionarios
GROUP BY Department
ORDER BY Total_Desligados DESC;

/*
Desligamentos_Justa_Causa corresponde à categoria
'Terminated for Cause' da base original.

Production concentra a maior quantidade de desligamentos, com 83 registros.
Desses, 75 foram desligamentos voluntários e 8 correspondem ao status
"Terminated for Cause", indicando predominância de saídas voluntárias
nesse departamento.

Nos demais departamentos, a quantidade absoluta de desligamentos é
consideravelmente menor.
*/


-- 5. Principais motivos de desligamento voluntário

SELECT
	TermReason AS Motivo_Desligamento,
	COUNT(*) AS Quantidade_Funcionarios,
	CAST(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS DECIMAL(5,2)) AS Percentual
FROM funcionarios
WHERE EmploymentStatus = 'Voluntarily Terminated'
GROUP BY TermReason
ORDER BY Quantidade_Funcionarios DESC;

/*
Os motivos mais frequentes de desligamento voluntário foram a saída
para outra posição (20), insatisfação (14) e busca por maior remuneração (11).

Esses três motivos representam 45 dos 88 desligamentos voluntários
(51,14%), indicando que pouco mais da metade das saídas voluntárias
está concentrada nessas três categorias.
*/


-- 6. Satisfação dos funcionários por situação de desligamento

SELECT
	CASE
		WHEN Termd = 1 THEN 'Desligado'
		ELSE 'Não Desligado'
	END AS Status_Desligamento,
	COUNT(*) AS Quantidade_Funcionarios,
	CAST(
		AVG(CAST(EmpSatisfaction AS DECIMAL(10,2)))
		AS DECIMAL(4,2)
	) AS Media_Satisfacao
FROM funcionarios
GROUP BY Termd
ORDER BY Termd;

/*
A satisfação é medida em uma escala de 1 a 5. O grupo "Não Desligado"
inclui funcionários ativos, afastados e com início futuro (207 no total).

A satisfação média registrada é semelhante entre funcionários
não desligados (3,90) e desligados (3,87), com diferença de
aproximadamente 0,03 ponto na escala de 1 a 5.

Essa comparação agregada não é suficiente para descartar uma relação
entre satisfação e desligamento. Uma análise por motivo de desligamento
pode ajudar a investigar diferenças entre os grupos.
*/


-- 7. Satisfação média por motivo de desligamento voluntário

SELECT
	TermReason AS Motivo_Desligamento,
	COUNT(*) AS Quantidade_Funcionarios,
	CAST(
		AVG(CAST(EmpSatisfaction AS DECIMAL(10,2)))
		AS DECIMAL(3,2)
	) AS Media_Satisfacao
FROM funcionarios
WHERE EmploymentStatus = 'Voluntarily Terminated'
GROUP BY TermReason
ORDER BY Media_Satisfacao;

/*
Entre os principais motivos de desligamento voluntário, os funcionários
que saíram por "unhappy" apresentaram satisfação média de 3,57, inferior
aos que saíram para outra posição (4,10) ou em busca de maior remuneração
(4,18).

O resultado indica uma associação entre o motivo "unhappy" e menor
satisfação registrada. Motivos com poucos funcionários devem ser
interpretados com cautela devido ao tamanho reduzido dos grupos.
*/


-- 8. Engajamento médio por status de desligamento

SELECT
	CASE
		WHEN Termd = 0 THEN 'Não Desligado'
		ELSE 'Desligado'
	END AS Status_Desligamento,
	COUNT(*) AS Quantidade_Funcionarios,
	CAST(
		AVG(CAST(EngagementSurvey AS DECIMAL(10,2)))
		AS DECIMAL(5,2)
	) AS Media_Engajamento
FROM funcionarios
GROUP BY Termd;

/*
O nível médio de engajamento foi de 3,33 tanto entre funcionários
não desligados quanto entre funcionários desligados.

Os resultados indicam que, nesta base, não foi observada diferença
relevante no engajamento médio entre os dois grupos.
*/


-- 9. Desempenho por status de desligamento

SELECT
	CASE
		WHEN Termd = 0 THEN 'Não Desligado'
		ELSE 'Desligado'
	END AS Status_Desligamento,
	CASE
		WHEN PerformanceScore = 'Exceeds' THEN 'Supera as Expectativas'
		WHEN PerformanceScore = 'Fully Meets' THEN 'Atende às Expectativas'
		WHEN PerformanceScore = 'Needs Improvement' THEN 'Precisa Melhorar'
		WHEN PerformanceScore = 'PIP' THEN 'Plano de Melhoria'
	END AS Desempenho,
	COUNT(*) AS Quantidade_Funcionarios,
	CAST(
		COUNT(*) * 100.0 /
		SUM(COUNT(*)) OVER (PARTITION BY Termd)
		AS DECIMAL(5,2)
	) AS Percentual
FROM funcionarios
GROUP BY Termd, PerformanceScore
ORDER BY
	CASE PerformanceScore
		WHEN 'Exceeds' THEN 1
		WHEN 'Fully Meets' THEN 2
		WHEN 'Needs Improvement' THEN 3
		WHEN 'PIP' THEN 4
	END,
	Termd;

/*
A maior parte dos funcionários de ambos os grupos atende às expectativas,
com percentuais semelhantes entre não desligados (78,26%) e desligados (78,64%).

A principal diferença foi observada na categoria "Precisa Melhorar",
que representa 9,71% dos desligados e 3,86% dos não desligados.

Também foi observada menor proporção de funcionários que superam as
expectativas entre os desligados (7,77%) em comparação aos não desligados (14,01%).

Os resultados indicam uma associação entre o perfil de desempenho e o
status de desligamento, sem estabelecer relação de causa.
*/


-- 10. Remuneração média por status de desligamento

SELECT
	CASE
		WHEN Termd = 0 THEN 'Não Desligado'
		ELSE 'Desligado'
	END AS Status_Desligamento,
	COUNT(*) AS Quantidade_Funcionarios,
	CAST(AVG(PayRate) AS DECIMAL(10,2)) AS Media_Remuneracao
FROM funcionarios
GROUP BY Termd;

/*
Os funcionários desligados apresentaram remuneração média de US$ 27,00
por hora, enquanto os não desligados apresentaram média de US$ 33,41
por hora.

A remuneração média dos desligados foi aproximadamente 19% menor.
Esse resultado é relevante considerando que "more money" aparece
entre os principais motivos de desligamento voluntário.

Os dados indicam uma associação entre remuneração e desligamento,
sem estabelecer relação de causa.

A comparação considera a remuneração média geral dos grupos,
sem controlar possíveis diferenças de remuneração entre cargos
ou departamentos.
*/


-- 11. Tempo médio de empresa até o desligamento

SELECT
	COUNT(*) AS Quantidade_Desligados,
	CAST(
		AVG(CAST(DATEDIFF(MONTH, DateofHire, DateofTermination) AS DECIMAL(10,2)))
		AS DECIMAL(10,2)
	) AS Media_Meses_Empresa
FROM funcionarios
WHERE Termd = 1;

/*
Os 103 funcionários desligados permaneceram, em média,
25,12 meses na empresa, o equivalente a aproximadamente
2 anos e 1 mês.

O resultado indica que, em média, os desligamentos registrados
na base ocorreram após pouco mais de dois anos de permanência
na empresa.

O tempo de permanência é aproximado, pois DATEDIFF(MONTH, ...)
considera as diferenças entre meses de calendário.
*/