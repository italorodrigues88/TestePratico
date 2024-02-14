INSERT INTO dbo.tbcliente
    (NOME, TIPO_PESSOA, CPF_CNPJ, RG_IE, LAGRADOURO, BAIRRO, NUMERO,
	 COMPLEMENTO, CIDADE, CEP, UF, PAIS, ATIVO)
VALUES
	('PESSOA FISICA ATIVA', '0', '88888888888', '99999999999', 'Rua teste 01', 
	 'Bairro teste 01', 963, 'complemento teste 01', 'Fortaleza', 60822327,
	 'CE', 'Brasil', 1)
GO

INSERT INTO dbo.tbcliente
    (NOME, TIPO_PESSOA, CPF_CNPJ, RG_IE, LAGRADOURO, BAIRRO, NUMERO,
	 COMPLEMENTO, CIDADE, CEP, UF, PAIS, ATIVO)
VALUES
	('PESSOA FISICA INATIVA', '0', '99999999999', '99999999999', 'Rua teste 02', 
	 'Bairro teste 02', 963, 'complemento teste 02', 'Fortaleza', 60822327,
	 'CE', 'Brasil', 0)
GO

INSERT INTO dbo.tbcliente
    (NOME, TIPO_PESSOA, CPF_CNPJ, RG_IE, LAGRADOURO, BAIRRO, NUMERO,
	 COMPLEMENTO, CIDADE, CEP, UF, PAIS, ATIVO)
VALUES
	('PESSOA JURIDICA ATIVA', '1', '99999999999999', '99999999999', 'Rua teste 03', 
	 'Bairro teste 03', 963, 'complemento teste 03', 'Fortaleza', 60822327,
	 'CE', 'Brasil', 1)
GO

INSERT INTO dbo.tbcliente
    (NOME, TIPO_PESSOA, CPF_CNPJ, RG_IE, LAGRADOURO, BAIRRO, NUMERO,
	 COMPLEMENTO, CIDADE, CEP, UF, PAIS, ATIVO)
VALUES
	('PESSOA JURIDICA INATIVA', '1', '88888888888888', '99999999999', 'Rua teste 03', 
	 'Bairro teste 03', 963, 'complemento teste 03', 'Fortaleza', 60822327,
	 'CE', 'Brasil', 0)
GO

INSERT INTO dbo.tbcliente_fone
	(CLIENTE_ID, FONE, OBSE)
VALUES
	(1, '85999999999', 'Fone Principal')
GO

INSERT INTO dbo.tbcliente_fone
	(CLIENTE_ID, FONE, OBSE)
VALUES
	(1, '85988888888', 'Fone irmão')
GO

INSERT INTO dbo.tbcliente_fone
	(CLIENTE_ID, FONE, OBSE)
VALUES
	(1, '85998989898', 'Fone esposa')