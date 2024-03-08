use `uc4atividades`;

DELIMITER $$
create procedure ListarComprasPorClienteEData(
    in cliente_id int,
    in data_inicial datetime,
    in data_final datetime
)
begin
    select 
        c.nome as NomeCliente,
        v.id as IDCompra,
        v.valor_total as Total,
        p.nome as NomeProduto,
        iv.quantidade as Quantidade
    from cliente c
    inner join venda v on c.id = v.cliente_id
    inner join item_venda iv on v.id = iv.venda_id
    inner join produto p on iv.produto_id = p.id
    where
        c.id = cliente_id
        and v.data between data_inicial and data_final;
end$$
DELIMITER ;

-- Chamada da stored procedure
call ListarComprasPorClienteEData(1, '2023-01-01 00:00:00', '2023-12-31 23:59:59');

-- Criação da stored function
DELIMITER $$
create function DeterminarStatusCliente(cliente_id int) returns varchar(10) deterministic
begin
    declare total_compras decimal(9, 2);
    set total_compras = (
        select SUM(v.valor_total)
        from venda v
        where v.cliente_id = cliente_id
    );

    if total_compras > 10000 then
        return 'PREMIUM';
    else
        return 'REGULAR';
    end if;
end$$
DELIMITER ;

-- Chamada da stored function
select DeterminarStatusCliente(1);

-- Criação do trigger
DELIMITER $$
create trigger SenhaMD5 before insert on usuario
for each row
begin
    set new.senha = MD5(new.senha);
end$$
DELIMITER ;