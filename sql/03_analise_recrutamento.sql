-- =====================================================
-- 03. ANÁLISE DE RECRUTAMENTO
-- Projeto: People Analytics com SQL
-- =====================================================

/*
Objetivo:
Analisar as fontes de recrutamento dos funcionários,
identificando a quantidade de contratações, os desligamentos
e os custos associados a cada fonte.

A análise busca identificar padrões que possam contribuir
para a avaliação das estratégias de recrutamento.
*/


-- 1. Quantidade de funcionários e desligamentos por fonte de recrutamento

SELECT
	RecruitmentSource AS Fonte_Recrutamento,
	COUNT(*) AS Quantidade_Funcionarios,
	SUM(
		CASE
			WHEN Termd = 1 THEN 1
			ELSE 0
		END
	) AS Total_Desligados,
	CAST(
		SUM(
			CASE
				WHEN Termd = 1 THEN 1
				ELSE 0
			END
		) * 100.0 / COUNT(*)
		AS DECIMAL(5,2)
	) AS Percentual_Desligamento
FROM funcionarios
GROUP BY RecruitmentSource
ORDER BY Percentual_Desligamento DESC;

/*
As fontes de recrutamento apresentaram diferenças na proporção
de funcionários desligados.

Social Networks (72,73%), Search Engine (60,00%) e
Diversity Job Fair (55,17%) apresentaram percentuais elevados.

Employee Referral apresentou a maior quantidade de funcionários
(31) e uma proporção de desligamento relativamente baixa (12,90%).

As fontes com apenas um funcionário foram desconsideradas
na interpretação dos maiores percentuais, devido à amostra reduzida.

Os resultados indicam uma associação entre a fonte de recrutamento
e o status de desligamento, sem estabelecer relação de causa.
*/


-- 2. Custos totais por fonte de recrutamento

SELECT
	Employment_Source AS Fonte_Recrutamento,
	Total AS Custo_Total
FROM custos_recrutamento
ORDER BY Custo_Total DESC;

/*
MBTA ads (US$ 10.980,00), Diversity Job Fair (US$ 10.021,00) e
Newspager/Magazine (US$ 8.291,00) apresentaram os maiores custos
totais de recrutamento registrados.

Oito fontes apresentaram custo total igual a zero,
incluindo Employee Referral, que possui a maior quantidade
de funcionários na base.

Os valores zerados foram preservados conforme o dataset,
mas não permitem concluir que essas fontes não geraram
custos reais de recrutamento.

A comparação isolada dos custos não permite avaliar a
eficiência das fontes, sendo necessário relacioná-los
à quantidade de funcionários recrutados.
*/


-- 3. Custo por funcionário recrutado por fonte de recrutamento

SELECT
	RecruitmentSource AS Fonte_Recrutamento,
	COUNT(*) AS Quantidade_Funcionarios,
	custos_recrutamento.Total AS Custo_Total,
	CAST(
		custos_recrutamento.Total * 1.0 / COUNT(*)
		AS DECIMAL(10,2)
	) AS Custo_Funcionario
FROM funcionarios
LEFT JOIN custos_recrutamento
	ON funcionarios.RecruitmentSource = custos_recrutamento.Employment_Source
GROUP BY RecruitmentSource, custos_recrutamento.Total
ORDER BY Custo_Funcionario DESC;

/*
Careerbuilder (US$ 7.790,00) e Pay Per Click (US$ 1.325,00)
apresentaram os maiores custos registrados por funcionário,
mas possuem apenas um funcionário cada.

Entre as fontes com maior quantidade de funcionários,
MBTA ads apresentou custo de US$ 645,88 por funcionário,
seguida por On-campus Recruiting (US$ 625,00).

Employee Referral apresentou 31 funcionários e custo
registrado igual a zero. Esse valor não permite afirmar
que o recrutamento ocorreu sem despesas reais.

A fonte Indeed não possui correspondência na tabela
de custos e, por isso, seu custo permanece NULL.

Os resultados permitem comparar os custos registrados
por funcionário, mas não são suficientes, isoladamente,
para determinar a eficiência das fontes de recrutamento.
*/