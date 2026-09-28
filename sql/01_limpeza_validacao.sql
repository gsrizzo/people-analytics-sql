-- =====================================================
-- 01. LIMPEZA E VALIDAÇÃO DOS DADOS
-- Projeto: People Analytics com SQL
-- =====================================================


-- 1. Quantidade inicial de registros
-- A base importada possui 401 registros.

SELECT COUNT(*) AS total_registros
FROM funcionarios;

-- 2. Verificação de registros sem identificação
-- Foram encontrados 91 registros sem EmpID.

SELECT COUNT(*) AS registros_sem_empid
FROM funcionarios
WHERE empid IS NULL;

-- 3. Inspeção dos registros sem identificação
-- A inspeção mostrou que os 91 registros estavam completamente vazios.

SELECT *
FROM funcionarios
WHERE empid IS NULL;

-- 4. Remoção de registros completamente vazios
-- Os registros não tinham nenhuma informação, então foram removidos.

DELETE FROM funcionarios
WHERE empid IS NULL;

-- 5. Validação após a limpeza
-- Após a remoção, restaram 310 registros e nenhum registro sem EmpID.

SELECT COUNT(*) AS total_registros
FROM funcionarios;

SELECT COUNT(*) AS registros_sem_empid
FROM funcionarios
WHERE EmpID IS NULL;