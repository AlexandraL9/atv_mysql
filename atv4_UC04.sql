use uc4atividades;

-- FN1 TABELA CLIENTE --

-- Criação de novas colunas para os atibutos compostos: 
alter table cliente add column nomeP varchar(255);
alter table cliente add column sobrenome varchar(255);
alter table cliente add column logradouro varchar(50);
alter table cliente add column bairro varchar(10);
alter table cliente add column cidade varchar(10);
alter table cliente add column estado varchar(10);
alter table cliente add column cep varchar(9);

set SQL_SAFE_UPDATES = 0;

update cliente set logradouro = endereco;
select endereco, logradouro from cliente;
alter table cliente drop column endereco;

-- Criação de novas colunas para os atibutos multivalorados: 
create table celular(
cel_cliente_id int not null auto_increment primary key)
select id,telefone from cliente;

alter table celular add constraint cel_cliente_id foreign key (cel_cliente_id) references cliente(id);
select * from cliente;
alter table cliente drop column telefone;

#Criando um view para fazer a buscar mais rapida 
create view Consultas as 
select nome,logradouro,telefone from cliente c join celular ce on c.id = ce.cel_cliente_id; 
#Chamando a VIEW
select * from consultas;

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -- 

-- TABELA  item_Venda FN2

create table info_produto
select produto_id,nome_produto,valor_unitario,quantidade,venda_id from item_venda;

create table info_vendas
select venda_id,subtotal from item_venda;

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx -- 

-- TABELA VENDA FN3
-- criação de nova tabela
create table pagamentos
(idPagamento int not null auto_increment primary key)
select tipo_pagamento,numero_cartao_pagamento,numero_parcelas_pagamento,data_pagamento from venda;

alter table venda drop column data_pagamento;
alter table venda drop column numero_parcelas_pagamento;
alter table venda drop column numero_cartao_pagamento;
alter table venda drop column tipo_pagamento;

alter table venda add column pagamento_id int not null;
alter table pagamentos add constraint id_Pagamento foreign key (idPagamento) references venda(id);

create view pesquisa as
select data,data_envio,cliente_id,c.nome,tipo_pagamento,data_pagamento from venda v 
join pagamentos p on v.id = p.idPagamento 
join cliente c on v.cliente_id = c.id;

select * from pesquisa;