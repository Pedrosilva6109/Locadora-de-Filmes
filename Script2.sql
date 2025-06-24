CREATE TABLE aluguel (

	id serial,

	data_aluguel timestamp,

	id_inventario int,

	id_cliente int,

	data_devolucao timestamp,

	id_funcionario int,

	ultima_atualizacao timestamp

);
CREATE TABLE ator (

	id serial,

	nome varchar(45),

	sobrenome varchar(45),

	ultima_atualizacao timestamp

);
CREATE TABLE categoria (

	categoria_id serial,

	nome varchar(80),

	ultima_atualizacao timestamp

);
CREATE TABLE categoria_filme (
	filme_id serial,
	categoria_id serial,
	ultimo_atualizacao timestamp
);
CREATE TABLE cidade (

	id serial,

	nome varchar(50),

	id_pais int,

	ultima_atualizacao timestamp

);
CREATE TABLE cliente (

	id serial,

	id_loja int,

	nome varchar(45),

	sobrenome varchar(45),

	email varchar(50),

	id_endereco int,

	ativo bool,

	data_criacao date,

	ultima_atualizacao timestamp

);
CREATE TABLE endereco (

	id serial,

	endereco varchar(50),

	complemento varchar(50),

	distrito varchar(20),

	id_cidade int,

	cep varchar(10),

	telefone varchar(20),

	ultima_atualizacao timestamp

);
CREATE TABLE filme (

	filme_id serial,

	titulo varchar(50),

	description text,

	lancamento_ano bpchar(4),

	linguagem_id int,

	aluguel_duracao varchar(20),

	taxa_aluguel numeric(4, 2),

	duracao varchar(10),

	custo_reposicao numeric(4, 2),

	avaliacao numeric(1, 1),

	ultima_atualizacao timestamp,

	recursos_especiais varchar(50),

	texto_inteiro text

);
CREATE TABLE filme_ator (

	id_ator int,

	id_filme int,

	ultima_atualizacao timestamp

);
CREATE TABLE funcionario (

	id serial,

	nome varchar(45),

	sobrenome varchar(45),

	id_endereco int,

	email varchar(50),

	id_loja int,

	ativo bool,

	usuario varchar(16),

	senha varchar(40),

	ultima_atualizacao timestamp,

	foto bytea

);
CREATE TABLE idioma (

	id serial,

	nome varchar(20),

	ultima_atualizacao timestamp

);
CREATE TABLE inventario (

	id serial,

	id_filme int,

	id_loja int,

	ultima_atualizacao timestamp

);
CREATE TABLE loja (

	id serial,

	id_gerente int,

	id_endereco int,

	ultima_atualizacao timestamp

);
CREATE TABLE pagamento (

	id serial,

	id_cliente int,

	id_funcionario int,

	id_aluguel int,

	valor numeric(5, 2),

	data_pagamento timestamp

);
CREATE TABLE pais (

	id serial,

	nome varchar(50),

	ultima_atualizacao timestamp

);

--remover coluna
alter table loja drop column ultima_atualizacao;

--adicionar coluna
alter table loja add column ultima_atualizacao timestamp;

--renomear coluna
alter table loja rename column ultima_atualizacao
	to ult_atual;

--alterar o tipo de dado da coluna
alter table loja alter column ult_atual
	set data type timestamp; 
	
alter table categoria add primary key (categoria_id);
alter table filme add primary key (filme_id);
alter table idioma add primary key (idioma_id);
alter table inventario add primary key (inventario_id);
alter table pais add primary key (pais_id);
alter table ator add primary key (ator_id);
alter table cidade add primary key (cidade_id);
alter table loja add primary key (loja_id);
alter table pagamento add primary key (pagamento_id);
alter table endereco add primary key (endereco_id);
alter table cliente add primary key (cliente_id);
alter table funcionario add primary key (funcionario_id);
alter table aluguel add primary key (aluguel_id);

alter table filme_categoria
add constraint fk_categoria
foreign key (categoria_id)
references categoria(categoria_id);

alter table filme_categoria
add constraint fk_filme
foreign key (filme_id)
references filme(filme_id);

alter table filme
add constraint fk_idioma
foreign key (idioma_id)
references idioma(idioma_id);

alter table filme_ator
add constraint fk_ator
foreign key (ator_id)
references filme(filme_id);

alter table filme_ator
add constraint fk_filme
foreign key (filme_id)
references filme(filme_id);

alter table inventario --tabela que possui chave estrangeira
add constraint fk_filme --adiciona restrição na tabela a ser alterada
foreign key (filme_id) --define a chave estrangeira na tabela a ser alterada
references filme(filme_id); --referencia a tabela que possui a chave primaria

alter table aluguel
add constraint fk_inventario
foreign key (inventario_id)
references inventario(inventario_id);

alter table aluguel
add constraint fk_funcionario
foreign key (funcionario_id)
references funcionario(funcionario_id);

alter table pagamento
add constraint fk_aluguel
foreign key (aluguel_id)
references aluguel(aluguel_id);

alter table pagamento
add constraint fk_funcionario
foreign key (funcionario_id)
references funcionario(funcionario_id);

alter table funcionario
add constraint fk_loja
foreign key (loja_id)
references loja(loja_id);