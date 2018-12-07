CREATE DATABASE DB_PIZZARIA;

USE DB_PIZZARIA;
SELECT DATABASE();

-- CRIANDO AS TABELAS DO CLIENTE
CREATE TABLE TB_PESSOA(
ID_PESSOA INT NOT NULL PRIMARY KEY auto_increment, 
NOME_PESSOA VARCHAR(70) NOT NULL,
DT_NASCIMENTO DATE,
SEXO VARCHAR(30),
TIPO_PESSOA VARCHAR(12) NOT NULL,
TIPO_FUNC VARCHAR(18),
CPF VARCHAR (14),
CNPJ VARCHAR(18)
);

create table endereco(
ID_ENDERECO int not null primary key auto_increment,
RUA varchar(80) not null,
BAIRRO varchar(50),
CEP varchar (10) not null, 
FK_CIDADE INT not null,
FK_ESTADO INT NOT NULL,
foreign key (FK_CIDADE) references tb_cidades(ID_CIDADE),
foreign key (FK_ESTADO) references tb_estados(ID_ESTADO)
)engine=MyISAM default charset=UTF8MB4;

insert into endereco (rua, bairro, fk_cidade, FK_ESTADO, CEP) values 
('Rua Maria Garzo da Fonseca', 'Jardim Pansani', 110001, 11, '13451-155'),
('Rua Barão Amaral do Cabo Frio', 'Jardim Paraguaçu', 110001, 11, '13049-357'),
('Rua José Carlos Marthe', 'Jardim Residencial Giverny', 110001, 11, '18048-260'),
('Alameda Palmeiras', 'Jardim dos Ipês', 110001, 35, '06845-260'),
('Rua Tarde de Maio', 'Jardim Santo Elias (São Miguel)', 110001, 11, '08022-550' ),
('Rua Job Gonçalves', 'Jardim Guanciale', 110001, 11, '13236-130' ),
('Rua Cordeirópolis', 'Vila Virgínia', 110001, 11, '08576-270' ),
('Rua Miguel Doratiotto', 'Atibaia Jardim', 110001, 11, '12942-760' ),
('Travessa do Místico', 'Jardim Modelo', 110001, 11, '02237-040'),
('Rua Coronel Manuel Teodoro Azambuja', 'Vila Regina ( Zona Leste)', 110001, 11, '08225-130')
;

drop table endereco;

select * from endereco;



-- TODAS AS TABELAS POSSUEM PRIMARY KEY, NECESSARO CRIAR UMA TABELA PARA CLIENTES QUE POSSUA ID(PK) E TABELA PARA ENDEREÇO ID(PK), DEPOIS
-- CRIAR UMA TABELA QUE RELACIONARÁ AS DUAS, A TABAELA CLIENTE_ENDEREÇO , COM UM ID_CLIENTE_ENDEREÇO, ID_CLIENTE(FK) E ID_ENDEREÇO(FK)


DROP TABLE tb_pessoa;

SHOW TABLES;

SELECT COUNT(*) AS TOTAL_SEXO from tb_pessoa where SEXO is not null;

SELECT COUNT(*) AS total_idade from tb_pessoa where dt_nascimento is not null;



select tb_pessoa.NOME_PESSOA, pessoa_endereco.FK_END 
from pessoa_endereco 
inner join tb_pessoa 
ON pessoa_endereco.FK_END = tb_pessoa.ID_PESSOA;

-- TESTE
select endereco.RUA, tb_cidades.CIDADE
from tb_cidades
inner join endereco
on tb_cidades.ID_CIDADE = endereco.FK_CIDADE;

CREATE TABLE COMPRA_PIZZA (
ID_COMPRA int primary key auto_increment,
DT_COMPRA DATE NOT NULL,
FK_PESSOA INT NOT NULL,
foreign key (fk_pessoa) references tb_pessoa(id_pessoa)
);

insert into compra_pizza (dt_compra, fk_pessoa) values
('1999-01-20', 1),
('1999-01-21', 1),
('1999-01-22', 1)
;

drop table compra_pizza;
select dt_compra from compra_pizza order by dt_compra desc;

CREATE table PESSOA_ENDERECO(
ID_PESSOA_END INT primary key auto_increment,
FK_PESSOA int NOT null,
FK_END int not null,
foreign key (FK_PESSOA) references TB_PESSOA(ID_PESSOA),
foreign key (FK_END) references TB_ENDERECO(ID_END)
)engine=MyISAM default charset=UTF8MB4;

insert into pessoa_endereco (FK_PESSOA, FK_END) values 
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);
select * FROM pessoa_endereco;

DROP TABLE tb_func;


CREATE TABLE TB_TELEFONE_PESSOA(
ID_TEL int primary key auto_increment,
FK_ID_PESSOA_TEL INT NOT NULL,
TELEFONE_PESSOA VARCHAR (9) NOT NULL,
FOREIGN KEY (FK_ID_PESSOA_TEL) REFERENCES TB_PESSOA(ID_PESSOA)
)engine=MyISAM default charset=UTF8MB4;

INSERT INTO tb_telefone_pessoa (FK_ID_PESSOA_TEL, TELEFONE_PESSOA) values 
(1, 135-38610),
(2, 169-59536),
(3, 252-55799),
(4, 135-38610),
(5, 135-38610),
(6, 135-38610),
(7, 135-38610),
(8, 135-38610),
(9, 135-38610),
(10, 135-38610)
;

DROP TABLE tb_telefone_pessoa;

-- CRIANDO AS TABELAS DA PIZZARIA
CREATE TABLE TB_PEDIDO (
ID_PED int primary key auto_increment,
FK_PESSOA_PED INT NOT NULL,
DESCRICAO VARCHAR(50) NOT NULL,
VALOR_PED DECIMAL(8,2) NOT NULL,
DATA_PEDIDO DATE NOT NULL,
FK_ITEM_PED int not null,
FOREIGN KEY(FK_PESSOA_PED) REFERENCES tb_pessoa(ID_PESSOA),
FOREIGN KEY(FK_ITEM_PED) REFERENCES tb_item_ped(COD_ITEM_PED)
)engine=MyISAM default charset=UTF8MB4;

INSERT INTO TB_PEDIDO (FK_PESSOA_PED, DESCRICAO, VALOR_PED, DATA_PEDIDO, FK_ITEM_PED) VALUES 
(1, '', 55.50, '2018-11-26', 1),
(2, '', 15.50, '2018-11-24', 1),
(2, '', 35.50, '2018-11-18', 1),
(3, '', 45.50, '2018-11-15', 1)
;


SELECT FK_PESSOA_PED, DATA_PEDIDO FROM TB_PEDIDO ORDER BY DATA_PEDIDO DESC;

SELECT data_pedido as 'compra maior que 14 dias' from tb_pedido where data_pedido > '2018-11-20';

select * from tb_pedido;
DROP TABLE tb_pedido;

CREATE TABLE TB_PIZZA(
ID_PIZZA INT NOT NULL PRIMARY KEY auto_increment,
NOME_PIZZA VARCHAR(50) NOT NULL,
VALOR DECIMAL(8,2),
FK_SABOR INT NOT NULL,
foreign key (FK_SABOR) references tb_sabor(ID_SABOR)
);

create table cardapio
(
FK_PIZZA INT NOT NULL,
TIPO_PIZZA VARCHAR(30) not null,
foreign key (FK_PIZZA) references tb_pizza(ID_PIZZA)
);

INSERT INTO CARDAPIO (FK_PIZZA, TIPO_PIZZA) VALUES 
(1, 'SALGADA'),
(2, 'SALGADA'),
(3, 'SALGADA'),
(4, 'SALGADA'),
(5, 'SALGADA'),
(6, 'DOCE'),
(7, 'DOCE'),
(8, 'DOCE');

SELECT * FROM CARDAPIO ORDER BY TIPO_PIZZA;

SELECT tb_pizza.NOME_PIZZA, tb_sabor.NOME_SABOR
from tb_sabor
inner join tb_pizza
ON tb_pizza.FK_SABOR = tb_sabor.ID_SABOR;

DROP TABLE CARDAPIO;

select * from tb_pizza;

insert into tb_pizza (NOME_PIZZA, VALOR, FK_SABOR) values
('PIZZA DE CALABRESA', 35.50, 1),
('PIZZA DE MILHO', 30.00, 3),
('PIZZA DE BRÓCOLIS', 25.80, 4),
('PIZZA DE 4 QUEIJOS', 35.70, 2),
('PIZZA DE FRANGO', 41.80, 5),
('PIZZA DE CHOCOLATE', 35.00, 6),
('PIZZA DE BANANA', 38.00, 7),
('PIZZA DE DOCE DE LEITE', 40.00, 8)
;

SELECT * FROM TB_PIZZA;
describe tb_pizza;
DROP TABLE TB_PIZZA;

CREATE TABLE TB_SABOR(
ID_SABOR INT primary key auto_increment,
NOME_SABOR VARCHAR(50) NOT NULL
);

INSERT INTO tb_sabor (NOME_SABOR) VALUES
('CHOCOLATE'),
('BANANA'),
('DOCE DE LEITE')

;
SELECT * FROM TB_SABOR;

drop table tb_sabor;
describe tb_sabor;
alter table tb_sabor add column ID_SABOR int not null primary key first;
alter table tb_pizza add COLUMN FK_SABOR INT NOT NULL after id_pizza;

select * from tb_pizza;

CREATE TABLE TB_INGREDIENTE(
ID_INGRED int primary key auto_increment,
FK_PIZZA_INGRED INT NOT NULL,
NOME_INGREDIENTE VARCHAR(50) NOT NULL,
FOREIGN KEY (FK_PIZZA_INGRED) REFERENCES TB_PIZZA(ID_PIZZA)
)engine=MyISAM default charset=UTF8MB4;

drop table tb_ingrediente;

CREATE TABLE TB_TAMANHO (
FK_COD_PIZZA_TAM int not null,
TAMANHO varchar(1),
FOREIGN KEY (FK_COD_PIZZA_TAM) REFERENCES TB_PIZZA(ID_PIZZA)
)engine=MyISAM default charset=UTF8MB4;

CREATE TABLE TB_PRODUTOS(
ID_PROD INT NOT NULL PRIMARY KEY auto_increment,
NOME_PROD varchar(50) not null,
VALOR_PROD decimal(8,2)
);

CREATE TABLE TB_ITEM_PED(
COD_ITEM_PED INT NOT NULL auto_increment primary key,
FK_COD_PIZZA_ITEM_PED int not null,
QUANTIDADE int(3),
VALOR_TOTAL decimal(8,2) ,
foreign key (FK_COD_PIZZA_ITEM_PED) references TB_PIZZA (ID_PIZZA)
);

insert into tb_item_ped (FK_COD_PIZZA_ITEM_PED, QUANTIDADE, VALOR_TOTAL) values

-- OUTROS


create table tb_estados(
  id_estado int auto_increment not null primary key,
  sigla varchar(2) not null,
  nome varchar(30) not null
  ) ENGINE=InnoDB default charset=UTF8MB4;
  
create table TB_CIDADES(
  ID_CIDADE int not null auto_increment primary key,
  CIDADE varchar(50) not null,
  FK_ESTADO int not null,
  foreign key (FK_ESTADO) references tb_estados(id_estado)
  ) engine=MyISAM default charset=UTF8MB4;

-- POPULANDO

SELECT * FROM TB_PESSOA WHERE TIPO_PESSOA = 'CLIENTE' ;
insert into tb_pessoa (nome_pessoa, dt_nascimento, sexo, tipo_pessoa, tipo_func, CPF) values 
('Gabriel', '1999-01-20', 'MASCULINO', 'FUNCIONARIO', 'ATENDENTE', '408.291.248-70'),
('Paulo', '1999-01-12', 'MASCULINO', 'FUNCIONARIO', 'OPERADOR DE CAIXA', '725.416.480-06'),
('Eduardo', '1999-01-23', 'MASCULINO', 'FUNCIONARIO', 'MOTOBOY' , '594.574.730-00'),
('João', '1999-06-05', 'MASCULINO', 'FUNCIONARIO', 'PIZZAIOLO', '408.152.240-52'),
('Marcos', '1999-07-14', 'MASCULINO', 'FUNCIONARIO', 'GARÇOM', '155.273.890-69');

insert into tb_pessoa (nome_pessoa, dt_nascimento, tipo_pessoa, CNPJ) values 
('Luzia e Iago Padaria Ltda', '2013-10-06','cliente', '02.768.000/0001-61'),
('Melissa e Marlene Eletrônica Ltda', '2013-09-13','cliente', '28.551.851/0001-41'),
('Breno e Otávio Marcenaria ME', '2013-03-01','cliente', '06.418.748/0001-95'),
('Arthur e Bento Informática ME', '2013-04-04','cliente', '02.768.000/0001-61'),
('Daiane e Rosa Ferragens ME', '2013-08-20','cliente', '07.039.703/0001-72')
;


INSERT INTO tb_cidades (ID_CIDADE, cidade, fk_estado) VALUES 
(110001, 'ALTA FLORESTA D OESTE', '11'),
(110002, 'ARIQUEMES', '11'),
(110003, 'CABIXI', '11'),
(110004, 'CACOAL', '11'),
(110005, 'CEREJEIRAS', '11');

select * from tb_cidades;


Insert Into tb_estados (id_estado,sigla,nome) Values(12,'AC','Acre');  
Insert Into tb_estados (id_estado,sigla,nome) Values(27,'AL','Alagoas');  
Insert Into tb_estados (id_estado,sigla,nome) Values(13,'AM','Amazonas');
Insert Into tb_estados (id_estado,sigla,nome) Values(16,'AP','Amapá');
Insert Into tb_estados (id_estado,sigla,nome) Values(29,'BA','Bahia');
Insert Into tb_estados (id_estado,sigla,nome) Values(23,'CE','Ceará');
Insert Into tb_estados (id_estado,sigla,nome) Values(53,'DF','Distrito Federal');
Insert Into tb_estados (id_estado,sigla,nome) Values(32,'ES','Espírito Santo');
Insert Into tb_estados (id_estado,sigla,nome) Values(52,'GO','Goiás');
Insert Into tb_estados (id_estado,sigla,nome) Values(21,'MA','Maranhão');
Insert Into tb_estados (id_estado,sigla,nome) Values(31,'MG','Minas Gerais');
Insert Into tb_estados (id_estado,sigla,nome) Values(50,'MS','Mato Grosso do Sul');
Insert Into tb_estados (id_estado,sigla,nome) Values(51,'MT','Mato Grosso');
Insert Into tb_estados (id_estado,sigla,nome) Values(15,'PA','Pará');
Insert Into tb_estados (id_estado,sigla,nome) Values(25,'PB','Paraíba');
Insert Into tb_estados (id_estado,sigla,nome) Values(26,'PE','Pernambuco');
Insert Into tb_estados (id_estado,sigla,nome) Values(22,'PI','Piauí');
Insert Into tb_estados (id_estado,sigla,nome) Values(41,'PR','Paraná');
Insert Into tb_estados (id_estado,sigla,nome) Values(33,'RJ','Rio de Janeiro');
Insert Into tb_estados (id_estado,sigla,nome) Values(24,'RN','Rio Grande do Norte');
Insert Into tb_estados (id_estado,sigla,nome) Values(11,'RO','Rondônia');
Insert Into tb_estados (id_estado,sigla,nome) Values(14,'RR','Roraima');
Insert Into tb_estados (id_estado,sigla,nome) Values(43,'RS','Rio Grande do Sul');
Insert Into tb_estados (id_estado,sigla,nome) Values(42,'SC','Santa Catarina');
Insert Into tb_estados (id_estado,sigla,nome) Values(28,'SE','Sergipe');
Insert Into tb_estados (id_estado,sigla,nome) Values(35,'SP','São Paulo');
insert Into tb_estados (id_estado,sigla,nome) Values(17,'TO','Tocantins');

