SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';
SET SQL_SAFE_UPDATES=0;
 
 
-- -----------------------------------------------------
-- Schema supermercado
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `supermercado`;
USE `supermercado` ;

-- -----------------------------------------------------------------------------------------------------------------------------------------------
-- LETRA A) CRIACAO DE TODAS AS TABELAS E RESTRICOES
-- -----------------------------------------------------------------------------------------------------------------------------------------------
	-- -----------------------------------------------------
	-- Table `supermercado`.`Cliente`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`Cliente` (
	  `Cod_Cliente` INT(10) NOT NULL auto_increment,
	  `NomeCliente` VARCHAR(45) NOT NULL,
	  `EnderecoCliente` VARCHAR(100) NOT NULL,
	  PRIMARY KEY(`Cod_Cliente`))
      
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`Caixa`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`Caixa` (
	  `ID_func` INT(10) NOT NULL AUTO_INCREMENT,
	  `NomeCaixa` VARCHAR(45) NOT NULL,
	  `Salario` DECIMAL(10,2) NOT NULL,
	  `DataDeAdmissao` DATETIME NOT NULL,
	  PRIMARY KEY (`ID_func`))
	ENGINE = InnoDB;

	-- -----------------------------------------------------
	-- Table `supermercado`.`Venda`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`Venda` (
	  `Nota_Fiscal` CHAR(20) NOT NULL,
	  `Data` DATE NOT NULL,
	  `FormaDePagamento` CHAR(1) NOT NULL,
	  `Cod_Cliente` INT(10) NOT NULL,
	  `ID_func` INT(10) NOT NULL,
	  PRIMARY KEY (`Nota_Fiscal`),
	  INDEX `fk_Venda_Cliente_idx` (`Cod_Cliente` ASC),
	  INDEX `fk_Venda_Caixa1_idx` (`ID_func` ASC),
	  CONSTRAINT `fk_Venda_Cliente`
		FOREIGN KEY (`Cod_Cliente`)
		REFERENCES `supermercado`.`Cliente` (`Cod_Cliente`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_Venda_Caixa1`
		FOREIGN KEY (`ID_func`)
		REFERENCES `supermercado`.`Caixa` (`ID_func`)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`Fornecedor`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`Fornecedor` (
	  `ID_Fornecedor` INT(10) NOT NULL AUTO_INCREMENT,
	  `EnderecoFornecedor` VARCHAR(100) NOT NULL,
	  `NomeFornecedor` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`ID_Fornecedor`))
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`Produto`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`Produto` (
	  `ID_Produto` CHAR(20) NOT NULL,
	  `NomeProduto` VARCHAR(45) NOT NULL,
	  `Marca` VARCHAR(45) NOT NULL,
	  `qntdEstoque` INT(10) NULL,
	  `ValorDeCompra` DECIMAL(10,2) NOT NULL,
	  `ValorDeVenda` DECIMAL(10,2) NOT NULL,
	  `ID_Fornecedor` INT NOT NULL,
	  PRIMARY KEY (`ID_Produto`),
	  INDEX `fk_Produto_Fornecedor1_idx` (`ID_Fornecedor` ASC),
	  CONSTRAINT `fk_Produto_Fornecedor1`
		FOREIGN KEY (`ID_Fornecedor`)
		REFERENCES `supermercado`.`Fornecedor` (`ID_Fornecedor`)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`ProdutoVenda`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`ProdutoVenda` (
	  `Nota_Fiscal` CHAR(20) NOT NULL,
	  `ID_Produto` CHAR(20) NOT NULL ,
	  `qntdVendida` INT(10) NOT NULL,
	  `valorVendido` DECIMAL(10,2) NOT NULL,
	  INDEX `fk_ProdutoVenda_Venda1_idx` (`Nota_Fiscal` ASC),
	  INDEX `fk_ProdutoVenda_Produto1_idx` (`ID_Produto` ASC),
	  PRIMARY KEY (`ID_Produto`, `Nota_Fiscal`),
	  CONSTRAINT `fk_ProdutoVenda_Venda1`
		FOREIGN KEY (`Nota_Fiscal`)
		REFERENCES `supermercado`.`Venda` (`Nota_Fiscal`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_ProdutoVenda_Produto1`
		FOREIGN KEY (`ID_Produto`)
		REFERENCES `supermercado`.`Produto` (`ID_Produto`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`Gerente`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`Gerente` (
	  `ID_Gerente` INT(10) NOT NULL AUTO_INCREMENT ,
	  `Acrescimo` DECIMAL(10,2) NOT NULL,
	  `Salario` DECIMAL(10,2) NOT NULL,
	  `DataDeAdmissao` DATETIME NOT NULL,
	  `NomeGerente` VARCHAR(45) NOT NULL,
	  PRIMARY KEY (`ID_Gerente`))
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`Pedido`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`Pedido` (
	  `Numero_Pedido` INT(10) NOT NULL auto_increment,
	  `DataPedido` DATE NOT NULL,
	  `Quantidade` INT(10) NOT NULL,
	  `ID_Produto` CHAR(20) NOT NULL,
	  `ID_Gerente` INT NOT NULL,
	  PRIMARY KEY (`Numero_Pedido`),
	  INDEX `fk_Pedido_Produto1_idx` (`ID_Produto` ASC),
	  INDEX `fk_Pedido_Gerente1_idx` (`ID_Gerente` ASC),
	  CONSTRAINT `fk_Pedido_Produto1`
		FOREIGN KEY (`ID_Produto`)
		REFERENCES `supermercado`.`Produto` (`ID_Produto`)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION,
	  CONSTRAINT `fk_Pedido_Gerente1`
		FOREIGN KEY (`ID_Gerente`)
		REFERENCES `supermercado`.`Gerente` (`ID_Gerente`)
		ON DELETE RESTRICT
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`TelefoneCliente`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`TelefoneCliente` (
	  `Telefone` CHAR(11) NOT NULL,
	  `Cod_Cliente` INT(10) NOT NULL,
	  PRIMARY KEY (`Telefone`, `Cod_Cliente`),
	  INDEX `fk_Telefones_Cliente1_idx` (`Cod_Cliente` ASC),
	  CONSTRAINT `fk_Telefones_Cliente1`
		FOREIGN KEY (`Cod_Cliente`)
		REFERENCES `supermercado`.`Cliente` (`Cod_Cliente`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;


	-- -----------------------------------------------------
	-- Table `supermercado`.`TelefoneFornecedor`
	-- -----------------------------------------------------
	CREATE TABLE IF NOT EXISTS `supermercado`.`TelefoneFornecedor` (
	  `Telefone` CHAR(11) NOT NULL,
	  `ID_Fornecedor` INT(10) NOT NULL,
	  PRIMARY KEY (`Telefone`, `ID_Fornecedor`),
	  INDEX `fk_Telefones_Fornecedor1_idx` (`ID_Fornecedor` ASC),
	  CONSTRAINT `fk_Telefones_Fornecedor1`
		FOREIGN KEY (`ID_Fornecedor`)
		REFERENCES `supermercado`.`Fornecedor` (`ID_Fornecedor`)
		ON DELETE CASCADE
		ON UPDATE NO ACTION)
	ENGINE = InnoDB;
	
-- -----------------------------------------------------------------------------------------------------------------------------------------------
-- LETRA B) EXEMPLOS ALTER TABLE E DROP TABLE
-- -----------------------------------------------------------------------------------------------------------------------------------------------	
    ALTER TABLE Cliente
	ADD email VARCHAR(50); 

	ALTER TABLE Cliente
	DROP COLUMN email; 

	ALTER TABLE Fornecedor
	MODIFY COLUMN NomeFornecedor VARCHAR(50); 

-- -----------------------------------------------------------------------------------------------------------------------------------------------
-- LETRA C) INSERÇÃO DE DADOS
-- -----------------------------------------------------------------------------------------------------------------------------------------------
	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA CLIENTE
	-- --------------------------------------------------
	
    INSERT INTO Cliente
	VALUES (1,'Fernando','Rua Peixoto Alves Cabrau,n 32 - Centro'); 
	INSERT INTO Cliente
	VALUES (2,'Salomao','Rua Santanan,n 32 - Centro'); 
	INSERT INTO Cliente
	VALUES (3,'Alves','Rua Castanhal,n 21 - Matozinhos'); 
	INSERT INTO Cliente
	VALUES (4,'Pedro','Rua Castanhal,n 51 - Biquinha');
	INSERT INTO Cliente
	VALUES (5,'Carla','Rua Ferdinandes,n 49 - Tejuco'); 
	INSERT INTO Cliente
	VALUES (6,'Thiago','Avenida Tiradentes,n 45 - Perimetral'); 
	INSERT INTO Cliente
	VALUES (7,'Clara','Avenia Josue de Queiroz,n 109 - Perimetral'); 
	INSERT INTO Cliente
	VALUES (8,'Roberto','Rua Carlos Chaga,n 102 - UFLA');
	INSERT INTO Cliente
	VALUES (9,'Diego','Rua Carlos Chaga,n 321 - UFLA');
	INSERT INTO Cliente
	VALUES (10,'','');
	    
	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA CAIXA
	-- --------------------------------------------------
	INSERT INTO Caixa
	VALUES (33,'Claudio',1200.30,'2019-04-24 18:45:33'); 
	INSERT INTO Caixa
	VALUES (44,'Fabricio',1200.30, '2019-08-24 13:45:33');
	INSERT INTO Caixa
	VALUES (55,'Paula',1200.30, '2019-04-24 12:45:33');
	INSERT INTO Caixa
	VALUES (66,'Gustavo',1200.30, '2019-01-24 09:45:33');
	INSERT INTO Caixa
	VALUES (77,'Arthur',1200.30, '2017-05-24 23:45:33');
	INSERT INTO Caixa
	VALUES (88,'Gabriel',1200.30, '2018-12-24 19:45:33');
	INSERT INTO Caixa
	VALUES (99,'Jeremias',1200.30, '2018-07-24 11:45:33');
	INSERT INTO Caixa
	VALUES (22,'Thaisa',1200.30, '2018-03-24 13:45:33');

	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA VENDA
	-- --------------------------------------------------
	INSERT INTO Venda
	VALUES ('3510000001','2019-08-24','c',1,22); 
	INSERT INTO Venda
	VALUES ('5210000002','2019-08-22','d',2,22); 
	INSERT INTO Venda
	VALUES ('9120000003','2019-08-23','c',3,66); 
	INSERT INTO Venda
	VALUES ('8130000004','2019-08-21','c',4,66); 
	INSERT INTO Venda
	VALUES ('7430000005','2019-08-20','d',5,44); 
	INSERT INTO Venda
	VALUES ('7650000006','2019-08-19','c',6,33); 
	INSERT INTO Venda
	VALUES ('8910000007','2019-08-18','d',7,99); 
	INSERT INTO Venda
	VALUES ('5670000008','2019-08-17','d',8,55); 
	INSERT INTO Venda
	VALUES ('3210000009','2019-08-16','c',1,77);
	INSERT INTO Venda
	VALUES ('12300000010','2019-08-15','d',8,44);

	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA FORNECEDOR
	-- --------------------------------------------------
	INSERT INTO Fornecedor
	VALUES (11,'Lavras','Roberto'); 
	INSERT INTO Fornecedor
	VALUES (22,'Sjdr','Tonhao'); 
	INSERT INTO Fornecedor
	VALUES (33,'Uberaba','Frederico'); 
	INSERT INTO Fornecedor
	VALUES (44,'Campos de Jordao','Maria'); 
	INSERT INTO Fornecedor
	VALUES (55,'Rio de Janeiro','Angelo'); 

	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA PRODUTO
	-- --------------------------------------------------
	INSERT INTO Produto
	VALUES ('10', 'MacaTomate','Pomarola',NULL,2.70,6.30,11); 
	INSERT INTO Produto
	VALUES ('20', 'Chocolate','Garoto',4000,1.80,4.90,22); 
	INSERT INTO Produto
	VALUES ('30', 'Leite Condensado','Moca',500,2.90,5.30,11); 
	INSERT INTO Produto
	VALUES ('40', 'Arroz','Albaruska',10500,7.70,11.50,33); 
	INSERT INTO Produto
	VALUES ('50', 'Feijao','Rio Branco',11500,2.70,5.10,44); 
	INSERT INTO Produto
	VALUES ('60', 'Amaciante','Confort',NULL,4.30,7.20,11); 
	INSERT INTO Produto
	VALUES ('70', 'Sabao em Po','Omo',9500,6.40,11.50,55); 
	INSERT INTO Produto
	VALUES ('80', 'Doce de Leite','Minas',22500,4.10,8.30,22); 
	INSERT INTO Produto
	VALUES ('90', 'Detergente','Ype',500,0.40,1.20,11); 
	INSERT INTO Produto
	VALUES ('100', 'Palha de aco','Bombril',NULL,1.70,2.50,44); 
	INSERT INTO Produto
	VALUES ('110', 'Leite','Camponesa',44500,1.25,2.49,11); 
	INSERT INTO Produto
	VALUES ('120', 'Macarrao','Santa Amalia',2200,1.70,3.20,11); 
	INSERT INTO Produto
	VALUES ('130', 'Refrigerante','Coca-Cola',55500,6.70,9.30,33); 
	INSERT INTO Produto
	VALUES ('140', 'Achocolatado','Toddy',100,3.70,6.20,55); 
	INSERT INTO Produto
	VALUES ('150', 'Macarrao Instantaneo','Miojo Nissin',44500,0.90,1.30,33); 

	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA PRODUTO/VENDA
	-- --------------------------------------------------
	INSERT INTO ProdutoVenda
	VALUES ('8130000004','100',3,5.00);
	INSERT INTO ProdutoVenda
	VALUES ('3510000001','140',1,6.20); 
	INSERT INTO ProdutoVenda
	VALUES ('5670000008','150',2,2.60); 
	INSERT INTO ProdutoVenda
	VALUES ('12300000010','30',3,15.90); 
	INSERT INTO ProdutoVenda
	VALUES ('7650000006','20',5,5.39); 
	INSERT INTO ProdutoVenda
	VALUES ('3210000009','50',6,4.39); 
	INSERT INTO ProdutoVenda
	VALUES ('7430000005','70',10,9.39); 
	INSERT INTO ProdutoVenda
	VALUES ('5210000002','80',11,7.39); 
	INSERT INTO ProdutoVenda
	VALUES ('8910000007','90',13,1.39); 
	INSERT INTO ProdutoVenda
	VALUES ('9120000003','130',19,1.39); 
	INSERT INTO ProdutoVenda
	VALUES ('8130000004','90',33,5.00);
 

	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA GERENTE
	-- --------------------------------------------------
	INSERT INTO Gerente
	VALUES (01, 0.2, 2400.30, '2019-04-24 12:45:33', 'Pedro Augusto');
    INSERT INTO Gerente
	VALUES (02, 0.2, 2500.30, '2020-04-24 12:45:33', 'Otavio Castro');
    INSERT INTO Gerente
	VALUES (03, 0.2, 2600.30, '2021-04-24 12:45:33', 'Pablo Escobar');
    INSERT INTO Gerente
	VALUES (04, 0.2, 2600.30, '2021-04-24 12:45:33', 'dPablo Escobar');
	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA PEDIDO
	-- --------------------------------------------------
	INSERT INTO Pedido
	VALUES (1, '2005-08-24', 10, '20', 01);
	INSERT INTO Pedido
	VALUES (2, '2005-08-19', 7, '110', 01);
	INSERT INTO Pedido
	VALUES (3, '2019-09-13', 15, '150', 02);
	INSERT INTO Pedido
	VALUES (4, '2019-09-17', 2, '60', 02);
	INSERT INTO Pedido
	VALUES (5, '2019-09-19', 1, '40', 03);
	INSERT INTO Pedido
	VALUES (6, '2019-09-22', 19, '120', 03);
	INSERT INTO Pedido
	VALUES (7, '2019-09-25', 52, '80', 03);


	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA TELEFONECLIENTE
	-- --------------------------------------------------
	INSERT INTO TelefoneCliente
	VALUES ('12981866085', 01);
	INSERT INTO TelefoneCliente
	VALUES ('12982042360', 01);
	INSERT INTO TelefoneCliente
	VALUES ('174824-4850', 02);
	INSERT INTO TelefoneCliente
	VALUES ('351733-2019', 03);
	INSERT INTO TelefoneCliente
	VALUES ('825449-1613', 04);
	INSERT INTO TelefoneCliente
	VALUES ('12981892083', 05);
	INSERT INTO TelefoneCliente
	VALUES ('11982568950', 05);
	INSERT INTO TelefoneCliente
	VALUES ('35981867054', 06);
	INSERT INTO TelefoneCliente
	VALUES ('35963589632', 07);
	INSERT INTO TelefoneCliente
	VALUES ('11991818580', 08);

	-- --------------------------------------------------
	-- INSERCAO DE VALORES NA TABELA TELEFONEFORNECEDOR
	-- --------------------------------------------------
	INSERT INTO TelefoneFornecedor
	VALUES ('35982023560', 11);
	INSERT INTO TelefoneFornecedor
	VALUES ('35981658247', 22);
	INSERT INTO TelefoneFornecedor
	VALUES ('35992042350', 22);
	INSERT INTO TelefoneFornecedor
	VALUES ('17981886025', 33);
	INSERT INTO TelefoneFornecedor
	VALUES ('12981765460', 44);
	INSERT INTO TelefoneFornecedor
	VALUES ('25991816084', 55);
    
-- -----------------------------------------------------------------------------------------------------------------------------------------------
-- LETRA D) MODIFICACAO DE DADOS UTILIZANDO UPDATE
-- -----------------------------------------------------------------------------------------------------------------------------------------------
	UPDATE Fornecedor
	SET NomeFornecedor = 'Joao'
	WHERE ID_Fornecedor = 22;

	UPDATE Cliente
	SET EnderecoCliente = 'Rua do Instituto'
	WHERE Cod_Cliente = 04;

	UPDATE Caixa
	SET Salario = 1500.00
	WHERE NomeCaixa = 'Arthur';

	UPDATE Venda 
	SET FormaDePagamento='v' 
	WHERE Nota_Fiscal ='7650000006';

	UPDATE Produto
	SET qntdEstoque = 10000
	WHERE ID_Fornecedor IN (SELECT ID_Fornecedor FROM Fornecedor WHERE NomeFornecedor = 'Roberto');

	
-- -----------------------------------------------------------------------------------------------------------------------------------------------
-- LETRA E) EXCLUSAO DE DADOS
-- -----------------------------------------------------------------------------------------------------------------------------------------------	
       
    
    DELETE FROM TelefoneCliente
    WHERE Cod_Cliente = 08;
    
    DELETE FROM TelefoneFornecedor
    WHERE Telefone = '25991816084';

	DELETE FROM Pedido
    WHERE ID_Produto = '80';

	DELETE FROM Produto
	WHERE NomeProduto = 'MacaTomate';
	
    DELETE FROM ProdutoVenda
    WHERE ID_Produto IN (SELECT ID_Produto FROM Produto WHERE NomeProduto = 'Palha de aco');
    
-- -----------------------------------------------------------------------------------------------------------------------------------------------
-- LETRA F) EXEMPLO DE 12 CONSULTAS 
-- -----------------------------------------------------------------------------------------------------------------------------------------------    
    
    -- <><> SELECT 1 <><>
    -- Recupera o nome dos caixas e a quantidade de vendas feitas por eles. Recupera apenas caixas que fizeram mais de uma venda.
    SELECT ID_func, NomeCaixa, COUNT(*) AS qntdVendas
    FROM Caixa
    NATURAL JOIN Venda
    GROUP BY ID_func, NomeCaixa HAVING qntdVendas > 1;
        
   
   -- <><> SELECT 2 <><>
    -- Recupera o nome de fornecedores, nome e valor de venda de produtos fornecidos com o valor superior a 7.20 reais. 
    -- Deve incluir também apenas o nome de fornecedores que fornecem produtos de valores inferiores a 7.20 reais.
	SELECT Fornecedor.NomeFornecedor, Produto.NomeProduto, Produto.ValorDeVenda
    FROM Fornecedor
    LEFT JOIN Produto ON Produto.ID_Fornecedor = Fornecedor.ID_Fornecedor and Produto.ValorDeVenda > 7.20;
   
  
   -- <><> SELECT 3 <><>
   -- Recupera o codigo e nome dos clientes que realizaram compras onde a forma de pagamento foi por credito.
   -- Nao deve-se repetir os nomes de clientes.
    SELECT DISTINCT Cod_Cliente, nomeCliente
    FROM Cliente 
    NATURAL JOIN Venda 
    WHERE FormaDePagamento='c';
   
   
    -- <><> SELECT 4 <><>
    -- Recupera o nome do Caixa que foi admitido entre os anos 2017 e 2018, anterior ao horario de 13h:44m:00s
    SELECT NomeCaixa 
    FROM Caixa
    WHERE DataDeAdmissao between '2017-01-01 00:00:01' AND '2018-12-31 13:44:00';
    
   
    -- <><> SELECT 5 <><>
    -- Recupera o id do produto, nome do produto e nome dos clientes que compraram produtos fornecidos pelo fornecedor de nome Angelo
    SELECT P.ID_Produto, P.NomeProduto, C.NomeCliente
    FROM Cliente C, Venda V, ProdutoVenda PV, Produto P, Fornecedor F
    WHERE V.Cod_Cliente = C.Cod_Cliente and V.Nota_Fiscal = PV.Nota_Fiscal and PV.ID_Produto = P.ID_Produto and
    P.ID_Fornecedor = F.ID_Fornecedor and F.NomeFornecedor='Angelo';
    
    
    -- <><> SELECT 6 <><>
    -- Recupera o nome e a quantidade de produtos(ordenados por nome) que foram comprados por clientes, mas NÃO pela cliente Carla
    SELECT P.NomeProduto, PV.qntdVendida
    FROM Produto P, ProdutoVenda PV, Venda V
    WHERE P.ID_Produto = PV.ID_Produto and V.Nota_Fiscal = PV.Nota_Fiscal and V.Cod_Cliente 
    NOT IN (SELECT Cod_Cliente 
			FROM Cliente 
			WHERE nomeCliente='Carla')
    ORDER BY P.NomeProduto;
   
 
    -- <><> SELECT 7 <><>
    -- Recupere o id, quantidade de estoque e nome dos produtos que foram pedidos pelos gerentes Otavio Castro ou Pablo Escobar 
	-- (ordenados pelo nome do produto).
	SELECT P.ID_Produto, P.qntdEstoque, P.NomeProduto
	FROM Produto P, Pedido Pe, Gerente G
	WHERE G.ID_Gerente=Pe.ID_Gerente and Pe.ID_Produto = P.ID_Produto and G.NomeGerente='Pablo Escobar'
		UNION 
	SELECT P.ID_Produto, P.qntdEstoque, P.NomeProduto
	FROM Produto P, Pedido Pe, Gerente G
	WHERE G.ID_Gerente=Pe.ID_Gerente and Pe.ID_Produto = P.ID_Produto and G.NomeGerente='Otavio Castro'
    ORDER BY NomeProduto;
    
	
    -- <><> SELECT 8 <><>
    -- Recupere o id e o nome dos Caixas que NÃO fizeram venda para o cliente de ID 08 
    SELECT c.ID_func, c.NomeCaixa 
    FROM Caixa c 
    WHERE NOT EXISTS 
			(SELECT ID_func 
			FROM Venda v, Cliente cl 
			where c.ID_func = v.ID_func and cl.Cod_Cliente = v.Cod_Cliente and cl.Cod_Cliente=08);
    
	    
    
	-- <><> SELECT 9 <><>
	-- Recupere a quantidade total, o valor de compra total, valor de venda total, lucro liquido e a porcentagem do lucro de produtos que não possuem estoque nulos
	SELECT COUNT(*) AS ProdutosTotais,SUM(ValorDeCompra) AS ValorTotalDeCompra,  SUM(ValorDeVenda) 
    AS ValorTotalDeVenda, SUM(ValorDeVenda-ValorDeCompra) As Lucro, (SUM(ValorDeVenda-ValorDeCompra)/SUM(ValorDeCompra))*100 AS '%_Lucro'
	FROM Produto
    WHERE qntdEstoque is not null;

   
   
	-- <><> SELECT 10 <><>
    -- Recupere nome e valor de compra de produtos que possuem pelo menos letra 'a' em seu nome e que algum possua valor de compra MAIOR que 2.8.
    SELECT NomeProduto, ValorDeCompra
    FROM Produto
    WHERE NomeProduto like '%a%' and NomeProduto = ANY (SELECT NomeProduto FROM Produto WHERE ValorDeCompra > 2.80);
   
   
	
    -- <><> SELECT 11  <><>
	-- Recupera produtos que não foram feitos pedidos ou que não foram vendidos ainda
    SELECT NomeProduto, ID_Produto
    FROM Produto
    WHERE ( ID_Produto NOT IN (SELECT ID_Produto FROM ProdutoVenda) ) OR ( ID_Produto NOT IN (SELECT ID_Produto FROM Pedido));

    
        
	
    -- <><> SELECT 12 (Falta utilizar all e or) <><>
	-- Recupera todas as vendas feitas pelo caixa de ID 22 no dia 2019-08-24 caso todas as vendas desse dia tenham sido feitas somente por esse caixa
    SELECT V.Nota_Fiscal, V.Data, Cli.NomeCliente, CX.NomeCaixa, CX.ID_func
    FROM Venda V, Cliente Cli, Caixa CX
    WHERE V.Cod_Cliente = Cli.Cod_Cliente AND V.ID_func = CX.ID_func AND  
		V.ID_func = 22 AND V.Data = '2019-08-24' AND
		V.ID_func = ALL (SELECT ID_func From Venda WHERE Data = '2019-08-24');




-- -----------------------------------------------------------------------------------------------------------------------------------------------
-- LETRA G) EXEMPLOS DE CRIAÇÃO DE VIEWS COM SUAS RESPECTIVAS VISUALIZAÇÕES
-- -----------------------------------------------------------------------------------------------------------------------------------------------	
   
	-- <><> VIEW 1 <><>
    -- Vamos criar uma view de nome DataCaixa que retorne ao ser consultada, o id, nome e data da venda realizada por um caixa,
	-- eliminando assim, a necessidade de realizar NATURAL JOIN toda vez que precisarmos desses dados.
    CREATE VIEW v_DataCaixa
	AS SELECT ID_func, NomeCaixa, Data
    FROM Caixa
    NATURAL JOIN Venda;
      
	-- Verificando o VIEW DataCaixa      
    SELECT ID_func, NomeCaixa, Data
    FROM v_DataCaixa
    ORDER BY ID_func;
	
     
   
 	-- <><> VIEW 2 <><> 
    -- Cria uma View com todos os produtos em falta e com seus respectivos fornecedores, mostrando o endereço e o telefone deles.
    CREATE VIEW v_ProdutosEmFalta
	AS 
    SELECT P.NomeProduto, P.Marca, F.NomeFornecedor, T.Telefone, F.EnderecoFornecedor
    FROM Produto P, Fornecedor F, TelefoneFornecedor T 
    WHERE P.qntdEstoque = 0 AND F.ID_Fornecedor = P.ID_Fornecedor AND T.ID_Fornecedor = F.ID_Fornecedor
    ORDER BY P.Marca, P.NomeProduto;
    
    -- Verificando o VIEW ProdutosEmFalta
    Select * from v_ProdutosEmFalta;
    
    
 	
    -- <><> VIEW 3 <><>
    -- Cria uma View mostrando todos os pedidos feitos por todos os gerentes com os produtos e quantidades de cada pedido.
    CREATE VIEW v_PedidoGerente
	AS SELECT G.ID_Gerente, G.NomeGerente, Ped.Numero_Pedido, Pr.NomeProduto, Pr.Marca, Ped.Quantidade
    FROM Gerente G, Pedido Ped, Produto Pr
    WHERE G.ID_Gerente=Ped.ID_Gerente AND Pr.ID_Produto=Ped.ID_Produto
    GROUP BY G.ID_Gerente, Ped.Numero_Pedido;
      
	-- Verificando o VIEW PedidoGerente     
    SELECT * FROM v_PedidoGerente;
    
    
    
-- -----------------------------------------------------------------------------------------------------------------------------------------------    
-- LETRA H) EXEMPLOS DE GRANT E REVOKE PARA PERMISSÃO DE ACESSO
-- -----------------------------------------------------------------------------------------------------------------------------------------------


	-- <><> CREATE USER <><>
	-- CRIAÇÃO DE 2 USUARIOS ROOT1 E ROOT2 COM AS SENHAS 1234 E 4321 RESPECTIVAMENTE
	CREATE USER 'root1'@'localhost' IDENTIFIED BY '1234';
	drop user 'root2'@'localhost';
	CREATE USER 'root2'@'localhost' IDENTIFIED BY '4321';

	-- <><> GRANT <><> 
	-- DANDO TODOS PRIVILÉGIOS EM TODAS AS TABELAS PARA O USER ROOT1
	GRANT ALL PRIVILEGES ON supermercado.* TO 'root1'@'localhost';

	-- DANDO O PRIVILÉGIO DE INSERÇÃO NA TABELA PRODUTO PARA O USER ROOT2
	GRANT INSERT ON supermercado.Produto TO 'root2'@'localhost';

	-- DANDO O PRIVILÉGIO DE CRIAÇÃO NA TABELA PRODUTO PARA O USER ROOT2
	GRANT CREATE ON supermercado.Produto TO 'root2'@'localhost';


	-- <><> REVOKE <><>
	-- RETIRANDO O PRIVILÉGIO DE DELETAR TODAS AS TABELAS DO USER ROOT1
	REVOKE DELETE ON supermercado.* FROM 'root1'@'localhost';

	-- RETIRANDO O PRIVILÉGIO DE CRIAÇÃO DA TABELA PRODUTO DO USER ROOT2
	REVOKE CREATE ON supermercado.Produto FROM 'root2'@'localhost'; 


	-- <><> DROP USER <><>
	-- EXCLUINDO OS USER'S ROOT1 E ROOT2
	DROP USER 'root1'@'localhost';

	DROP USER 'root2'@'localhost';    


-- -----------------------------------------------------------------------------------------------------------------------------------------------   
-- LETRA I) EXEMPLOS DE PROCEDIMENTOS/FUNÇÕES (PROCEDURES) E SUAS RESPECTIVAS FORMAS DE EXECUÇÕES
-- -----------------------------------------------------------------------------------------------------------------------------------------------	
    
    -- <><> PROCEDURE 1 <><>
    -- Fazer um reajuste salarial de um Caixa, passando nos parâmetros da função de chamada(CALL) o valor do reajuste do salário
    -- que deseja ser alterado e o id do caixa existente.
     DELIMITER $$
	 
	CREATE PROCEDURE pr_ReajusteSalario(
		IN  pSalarioReajuste DECIMAL(10,2),
		IN pID_func INT(10)
		)

	BEGIN
		
		DECLARE VSalario DECIMAL(10,2);
		
		SELECT Salario 
		FROM Caixa 
		WHERE ID_func = pID_func
		INTO VSalario;
		
		SET VSalario = VSalario * pSalarioReajuste;
		UPDATE Caixa
		SET Salario = VSalario
		WHERE ID_func = pID_func;

	END $$

	DELIMITER ;
	-- TESTE DO REAJUSTE SALARIAL PASSANDO OS PARÂMETROS E EM SEGUIDA UM SELECT PARA MOSTRAR OS RESULTADOS
	CALL pr_ReajusteSalario(1.50,22);
	SELECT ID_func, Salario FROM Caixa;
    



	-- <><> PROCEDURE 2 <><> 
	-- Fazer uma atualização na quantidade de estoque e valor de venda na tabela Produto, passando como parâmetros o id do produto existente,
    -- a quantidade do estoque a ser alterado e o valor de venda a ser alterado.
	DELIMITER //
	CREATE PROCEDURE pr_AtualizarEstoque ( 
		IN pID_Produto CHAR(20), 
        IN pqntdEstoque INT(10), 
        IN pValorDeVenda decimal(10,2)
        )
	
    BEGIN
		
	DECLARE contador int(10);
	 
		SELECT count(*) 
        FROM Produto 
        WHERE ID_Produto = pID_Produto 
        INTO contador;
	 
		IF contador > 0 THEN
			UPDATE Produto 
            SET qntdEstoque = qntdEstoque + pqntdEstoque, ValorDeVenda = pValorDeVenda
			WHERE ID_Produto = pID_Produto;
		ELSE
			INSERT INTO Produto (ID_Produto, NomeProduto, Marca ,qntdEstoque, ValorDeCompra, ValorDeVenda, ID_Fornecedor) values (pID_Produto,'NovoProduto','NovaMarca', pqntdEstoque,  ValorDeCompra, pValorDeVenda, 33);
		END IF;
	END //
	DELIMITER ;
    -- TESTE PARA DO ESTOQUE PASSANDO OS PARÂMETROS E EM SEGUIDA UM SELECT PARA NOS MOSTRAR OS RESULTADOS
    CALL pr_AtualizarEstoque('110',5003,7.20);
	SELECT * FROM Produto;
   
    
    
 
    -- <><> PROCEDURE 3 <><> 
    -- Procedure que cria ou exclui uma view que separa os produtos em categorias, 
    -- caso receba 'c' como parametro, cria a view,
    -- caso receba 'e' como parametro, exclui a view.
    -- caso a operação desejada tenha sido feita com sucesso retorna 1, caso contrario retorna 0
    
    DELIMITER //
    CREATE PROCEDURE pr_CategoriaProduto ( 
		IN _flag CHAR(1), 
        OUT _retorno boolean
        )
	BEGIN
        IF _flag = 'c' THEN
			CREATE OR REPLACE VIEW CategoriaProduto AS 
				SELECT NomeProduto, 
					CASE WHEN NomeProduto IN ('MacaTomate', 'Doce de Leite', 'Leite Condensado') THEN 'Enlatados'
						WHEN NomeProduto IN ('Arroz', 'Feijao') THEN 'Grãos'
						WHEN NomeProduto IN ('Amaciante', 'Sabao em Po', 'Detergente','Palha de aco') THEN 'Limpeza'
						WHEN NomeProduto IN ('Refrigerante','Achocolatado','Leite') THEN 'Bebidas'
						WHEN NomeProduto IN ('Chocolate') THEN 'Doces'
						WHEN NomeProduto IN ('Macarrao Instantaneo', 'Macarrao') THEN 'Massas'
							 ELSE '' END AS Categoria
				FROM Produto
				ORDER BY Categoria,NomeProduto;
			SET _retorno = true;
		ELSE
			IF _flag = 'e' THEN
				 DROP VIEW IF EXISTS CategoriaProduto;
                SET _retorno = true;
			ELSE
				SET _retorno = false;
			END IF; 
        END IF;
	END//
	
    DELIMITER ;
    -- TESTE 1 PARA CRIAÇÃO DO VIEW USANDO PARÂMETROS 'c' - PARA CRIAR
    CALL pr_CategoriaProduto('c',@_retorno);
    SELECT  * FROM CategoriaProduto;
	-- TESTE 2 ELE EXCLUI A VIEW USANDO PARÂMETROS 'e' - PARA CRIAR
    CALL pr_CategoriaProduto('e',@_retorno);
    SELECT  * FROM CategoriaProduto;


- -----------------------------------------------------------------------------------------------------------------------------------------------   
-- LETRA J) EXEMPLOS DE TRIGGERS (INSERÇÃO, ALTERAÇÃO E EXCLUSÃO)
-- -----------------------------------------------------------------------------------------------------------------------------------------------


	
	-- <><> TRIGGER 1 (ALTERAÇÃO) <><>
	-- Trigger com a função de após os dados chegarem à tabela Gerente, irá fazer uma modificação/update na tabela Gerente, onde irá verificar se o salario novo
    -- é maior que o salário antigo, caso salario novo seja menor, não deixará atualizar o salário do Gerente e assim ficará o maior Salário
	DELIMITER //
    CREATE TRIGGER tr_Salario_Novo_Update
	BEFORE UPDATE ON Gerente
	FOR EACH ROW
		
        BEGIN
		
			IF (NEW.Salario < OLD.Salario) THEN
				  UPDATE Gerente SET Salario  = OLD.Salario
				  WHERE ID_Gerente = OLD.ID_Gerente;
			END IF;
	END //
    DELIMITER ;
    
    -- TESTE 1
    -- TRIGGER UTILIZANDO O GERENTE DE ID 1, MOSTRANDO TABELAS COM SALARIO ANTIGO E ALTERANDO O SALARIO ATUAL
    SELECT * FROM Gerente;
    UPDATE Gerente 
    SET Salario = 3337
    where ID_Gerente = 1;
	SELECT * FROM Gerente;
    -- TESTE 2
    -- TRIGGER UTILIZANDO O MESMO GERENTE DE ID 1, MOSTRANDO A TABELA COM SALARIO ANTIGO E POR CONSEQUENCIA IMPOSSIBILITANDO DE
    -- DIMINUIR O SALARI POIS É MENOR QUE O SALARIO ANTIGO
	SELECT * FROM Gerente;
    UPDATE Gerente 
    SET Salario = 3000
    where ID_Gerente = 1;
	SELECT * FROM Gerente;
 

  
  
  -- <><> TRIGGER 2 (INSERÇÃO) <><>
  -- Trigger com a função de antes dos dados chegarem à tabela Pedido, irá verificar se a quantidade de produtos pedidos em Pedido é menor que 5,
  -- entirar atualizar para nova quantidade.
	DELIMITER //
    CREATE TRIGGER tr_Quantidade_Pedido_Insert 
    BEFORE INSERT ON Pedido
	FOR EACH ROW
		BEGIN
			
            IF(NEW.Quantidade < 1) 	THEN	
				SIGNAL SQLSTATE '45000' SET message_text = 'O pedido deve ser de quantidade maior que 1';
          	END IF;
    END //	
    DELIMITER ;
	
    -- TESTAR O TRIGGER SERÁ PASSADO O VALOR < 1 NA INSERÇÃO
    INSERT INTO Pedido VALUES (9, '2019-09-25', 0, '80', 03);	
	
    
    
    
    -- <><> TRIGGER 3 (EXCLUSÃO) <><>
    -- O Gerente do supermercado ganha acrescimo por numero de pedidos. Caso o numero de pedidos seja menor que 5,
    -- Ao deletar um produto com a quantidade menor ou igual a 7, o gerente automaticamente irá perder 0.1 no seu Acrescimo de salario
  
	DELIMITER //
    CREATE TRIGGER tr_Quantidade_Pedido_Delete
    before DELETE ON Pedido
	FOR EACH ROW
		BEGIN
			
				UPDATE Gerente G, Pedido P SET G.Acrescimo = G.Acrescimo-0.01 WHERE P.Quantidade <= 7;
	END //	
    DELIMITER ;
    -- 
    -- TESTAR DELETANDO UM PRODUTO COM QUANTIDADE 7 E DEPOIS VERIFICAR SE O ACRESCIMO DO SALARIO DO GERENTE FOI ALTERADO    
    DELETE FROM Pedido WHERE Quantidade = 7;
	select ID_Produto, Quantidade From Pedido;
    select * FROM Gerente;
    
   
   
    -- <><> TRIGGER 4 (INSERÇÃO) <><>
    -- Trigger com a função onde toda vez que for cadastrada uma tupla na tabela ProdutoVenda, 
    -- decrementará 1 unidade na coluna qntdEstoque da tabela Produto.
    -- Esse trigger serve para atualizar o estoque de produtos sempre que uma venda for feita.

	DELIMITER //
	CREATE TRIGGER tr_DecrementaEstoque
	AFTER INSERT 
    	ON ProdutoVenda
	FOR EACH ROW
	
	BEGIN
		UPDATE Produto
		SET qntdEstoque = qntdEstoque - 1
		WHERE ID_Produto = new.ID_Produto;
	END //

	DELIMITER ;
          
    -- TESTAR O TRIGGER FAZENDO UM SELECT PRIMEIRAMENTE PARA VERMOS A QUANTIDADE DO ESTOQUE DE CERTO PRODUTO, QUE NO CASO É DE ID 120	
    SELECT ID_Produto, qntdEstoque from Produto WHERE ID_PRODUTO = '120';
    -- INSERE UMA NOVO VALOR EM PRODUTO VENDA COM O ID 120
    INSERT INTO ProdutoVenda VALUES ('00000001','120',33,5.00);
    -- VERIFICA SE A QUANTIDADE DO ESTOQUE DIMINUIU
    SELECT ID_Produto, qntdEstoque from Produto WHERE ID_PRODUTO = '120';
    
    
  
    -- <><> TRIGGER 5 (INSERÇÃO) <><>
    -- Trigger com a função para que não deixe inserir dentro da tabela Cliente Nome ou Endereco nulos
    -- Então toda vez que for tentar colocar um Nome ou Endereço vazio, irá mandar uma mensagem de erro
    DELIMITER //
	CREATE TRIGGER tr_RenomeiaNome
	BEFORE INSERT 
	ON Cliente
	FOR EACH ROW
	
	BEGIN
		IF(new.NomeCliente='' OR new.EnderecoCliente = '') THEN
			SIGNAL SQLSTATE '45000' SET message_text = 'Nome ou Endereco estão em branco!';	
		END IF;
	END //

	DELIMITER ;
    
    -- PARA TESTAR O TRIGGER SERÁ PASSADO CAMPOS NULOS OU VAZIOS EM NOME E ENDEREÇO E ASSIM RETORNARÁ UMA MENSAGEM DE TEXTO
    -- TESTE 1
    INSERT INTO Cliente Values (33,'','');
    -- TESTE 2
	INSERT INTO Cliente Values (34,'aaa','');
    -- TESTE 3
    INSERT INTO Cliente Values (35,'','bbb');
    
    
    



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

