use uc4atividades;

SELECT * FROM venda v, item_venda iv, produto p, cliente c, funcionario f
WHERE v.id = iv.venda_id AND c.id = v.cliente_id AND p.id = iv.produto_id AND f.id = v.funcionario_id and tipo_pagamento = 'D';

-- Explain não otimizado-- 
explain select * from cliente;
explain select * from venda;

-- Explain otimizado -- 
explain select c.nome,cliente_id,p.nome from venda v 
	join cliente c on v.cliente_id = c.id
	join produto p on v.cliente_id = p.id
    where cliente_id = 9;
    

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --

SELECT * FROM produto p, item_venda iv, venda v
WHERE p.id = iv.produto_id AND v.id = iv.venda_id AND p.fabricante like '%lar%';
 
 -- Explain não otimizado-- 
explain select * from produto;
explain select * from item_venda;

-- Explain otimizado -- 
explain select p.id, p.nome, p. descricao, p.estoque, p.fabricante, iv.quantidade, iv.valor_unitario, iv.subtotal, 
v.data, v.data_envio from item_venda iv
	join produto p on iv.produto_id = p.id
	join venda v on iv.venda_id = v.id
    where p.fabricante like '%lar%';
 -- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --

-- Explain otimizado -- 
explain select SUM(iv.subtotal), SUM(iv.quantidade)
from produto p, item_venda iv, venda v, cliente c
where p.id = iv.produto_id and v.id = iv.venda_id and c.id = v.cliente_id /*f.id = v.funcionario_id*/
group by c.nome, p.nome;

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --

-- index --
create index Busca_Cliente 
	on cliente
		(
			id,
			nome,
			cpf,
			usuario_id
		);

-- chamando o index com explain --

explain select * from Cliente where id = 9;

-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx --

-- view --
create view busca_clientes 
	as 	
		select c.nome,cliente_id,descricao from venda v 
		join cliente c on v.cliente_id = c.id
		join produto p on v.cliente_id = p.id;

-- chamando uma view -- 
select * from busca_clientes;