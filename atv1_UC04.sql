use uc4atividades;

create user 'user_relatorio'@'localhost' identified by '123456';
grant select on *.* to 'user_relatorio'@'localhost';
flush privileges;
create role 'view_relatorio';
grant select on *.* to 'view_relatorio';
flush privileges;
grant 'view_relatorio' to 'user_relatorio'@'localhost';
flush privileges;

create user 'user_funcionario'@'localhost' identified by '987654';
grant select, insert, update, delete on *.* to 'user_funcionario'@'localhost';
flush privileges;
create role 'write_relatorio';
grant select, insert, update, delete on *.* to 'write_relatorio';
flush privileges;
grant 'write_relatorio' to 'user_funcionario'@'localhost';
flush privileges;

show grants for 'user_relatorio'@'localhost';
show grants for 'user_funcionario'@'localhost';
select * from mysql.user;
