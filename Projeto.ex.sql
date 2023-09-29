-- TITULOS
desc titulos;

-- =======================================================================================================================================================

-- TODOS
select * from titulos;

-- =======================================================================================================================================================

-- CODIGO 1, 2 ou 3 
select * from titulos where cod_tit = 1 or cod_tit = 2 or cod_tit = 3;
select * from titulos where cod_tit in(1, 2, 3);

select * from titulos where cod_tit >= 1 and cod_tit <= 3;
select * from titulos where cod_tit between 1 and 3;

select * from titulos where cod_tit <= 3;
select * from titulos where cod_tit < 4;

select * from titulos order by cod_tit asc limit 3;
select * from titulos order by cod_tit asc limit 0, 3;

-- =======================================================================================================================================================

-- CODIGO DIFERENTE DE 2, 6, 9
select * from titulos where cod_tit <> 2 and cod_tit <> 6 and cod_tit <> 9;
select * from titulos where cod_tit not in(2, 6, 9);

-- =======================================================================================================================================================

-- PREÇO DE VENDA ENTRE 100 E 150
select * from titulos where val_cd between 100 and 150;
select * from titulos where val_cd > 100 and val_cd< 150;

-- =======================================================================================================================================================

-- PREÇO DEE CUSTO MENOR QUE 100
select * from titulos where val_compra < 100;

-- =======================================================================================================================================================

-- NOME QUE CONTENHA O TEXTO 'SABER'
select * from titulos where nome_cd like '%saber%';

-- =======================================================================================================================================================

-- NOME INICIADO COM 'ACABOU
select* from titulos where nome_cd like 'acabou%';

-- =======================================================================================================================================================

-- NOME INICIADO POR CONSOANTES
select * from titulos where nome_cd like 'b%' or nome_cd like 'c%' or nome_cd like 'd%';
select * from titulos where nome_cd not like 'a%' and
							nome_cd not like 'e%' and
                            nome_cd not like 'i%' and
                            nome_cd not like 'o%' and
                            nome_cd not like 'u%';

-- ======================================================================================================================================================= 
 
-- EXPRESSÕES REGULARES
 select * from titulos where nome_cd regexp '^[^aeiou]';
 select * from titulos where nome_cd not regexp '^[aeiou]';
 
 select * from titulos where nome_cd rlike '^[^aeiou]';
 select * from titulos where nome_cd not rlike '^[aeiou]';
 
-- ======================================================================================================================================================= 
 
 -- LUCRO MAIOR QUE 50%
 select nome_cd as 'Titulo',
		val_compra as 'Valor de Compra',
        val_cd as 'Valor de Venda',
        val_cd - val_compra as 'Lucro em R$',
        round((val_cd - val_compra) * 100 / val_cd, 1) as 'Lucro em %',
        round(val_cd * 1.4, 2) as 'Projeção de 40% na Venda',
        round(val_compra * 1.5, 2) as 'Projeção de 50% de Lucro'
        from titulos where val_cd > val_compra * 1.5;

select * from titulos where val_cd > val_compra * 1.5;

-- =======================================================================================================================================================

-- LUCRO MENOR QUE 100%
select * from titulos where val_cd < val_compra * 2;

-- =======================================================================================================================================================

-- LUCRO MAIOR QUE R$ 100.00
select * from titulos where (val_cd - val_compra) > 100;

-- =======================================================================================================================================================

-- QUANTOS TITULOS EXISTEM CADASTRADOS NO SISTEMA ?
select * from titulos;
select count(*) from titulos;
select count(cod_tit) from titulos;

-- =======================================================================================================================================================

-- LISTE TODOS OS TITULOS DO SISTEMA, TRAZENDO A CATEGORIA E A GRAVADORA DO MESMO
select nome_cat as 'Categoria', 
       nome_cd as 'Titulo',
       nome_grav as 'Gravadora'
		 from titulos t 
		 join categorias ct on t.cod_cat = ct.cod_cat 
         join gravadoras g on t.cod_grav = g.cod_grav
         order by nome_cat, nome_cd;

-- =======================================================================================================================================================

-- QUAL CATEGORIA E VALOR DO TITULO MAIS CARO QUE NÓS JÁ COMPRAMOS?
select nome_cat as 'Categoria', 
       nome_cd as 'Titulo',
       val_compra as 'Valor Compra'
		 from titulos t 
		 join categorias ct on t.cod_cat = ct.cod_cat 
         where val_compra = (select max(val_compra)from titulos);

-- =======================================================================================================================================================  
  
-- QUAL A CATEGORIA, A GRAVADORA E O VALOR DO TITULO MAIS CARO QUE NÓS JÁ COMPRAMOS?
select nome_cat as 'Categoria', 
       nome_cd as 'Titulo',
       val_compra as 'Valor Compra',
       nome_grav as 'Gravadora'
		 from titulos t 
		 join categorias ct on t.cod_cat = ct.cod_cat
         join gravadoras g on t.cod_grav = g.cod_grav
         where val_compra = (select max(val_compra)from titulos);

-- =======================================================================================================================================================

-- QUANTOS CLIENTE DO ESTADO DE SÃO PAULO ESTÃO CADASTRADOS NO SISTEMA? PS: MONTAR A QUERY PELO NOME DE ESTADO
select nome_cli as 'Cliente', 
	   nome_cid as 'Cidade',
       nome_est as 'UF'
		from clientes cl
        join cidades cd on cl.cod_cid = cd.cod_cid
        join estados e on cd.sigla_est = e.sigla_est
        where nome_est = 'São Paulo';


select count(cod_cli) as 'Numero de Cliente de São Paulo'
		from clientes cl
        join cidades cd on cl.cod_cid = cd.cod_cid
        join estados e on cd.sigla_est = e.sigla_est
        where nome_est = 'São Paulo';

-- =======================================================================================================================================================  
  
-- QUANTO CADA FUNCIONÁRIO RECEBEU DE COMISSÃO EM CADA VENDA? A COMISSÃO É DE 50% DE LUCRO
select nome_func as 'Funcionário',
	   p.num_ped as 'Pedido',
       nome_cd as 'Titulo',
       qtd_cd as 'Numero de CDs',
       val_compra as 'Compra',
       tp.val_cd as 'Venda'
		from funcionarios f
        join pedidos p on f.cod_func = p.cod_func
        join titulos_pedidos tp on p.num_ped = tp.num_ped
        join titulos t on tp.cod_tit = t.cod_tit;


select nome_func as 'Funcionário',
	   p.num_ped as 'Pedido',
       group_concat(nome_cd) as 'Titulo',
       sum(round((qtd_cd * (tp.val_cd - val_compra))/ 2,2)) as 'Comissão do Vendedor'
		from funcionarios f
        join pedidos p on f.cod_func = p.cod_func
        join titulos_pedidos tp on p.num_ped = tp.num_ped
        join titulos t on tp.cod_tit = t.cod_tit
        group by p.num_ped;

-- =======================================================================================================================================================
        
-- QUANTO CADA FUNCIOÁRIO RECEBEU AO TOTAL?
 select nome_func as 'Funcionário',
	    group_concat(distinct p.num_ped) as 'Pedidos',
        sum(round((qtd_cd * (tp.val_cd - val_compra))/ 2,2)) as 'Comissão do Vendedor'
			from funcionarios f
			join pedidos p on f.cod_func = p.cod_func
			join titulos_pedidos tp on p.num_ped = tp.num_ped
			join titulos t on tp.cod_tit = t.cod_tit
			group by nome_func;       


 select nome_func as 'Funcionário',
	    group_concat(distinct p.num_ped) as 'Pedidos',
        sum(round((qtd_cd * (tp.val_cd - val_compra))/ 2,2)) as 'Comissão do Vendedor'
			from funcionarios f
			join pedidos p on f.cod_func = p.cod_func
			join titulos_pedidos tp on p.num_ped = tp.num_ped
			join titulos t on tp.cod_tit = t.cod_tit
			group by nome_func
            with rollup; 
 
 
 select case 
			when nome_func is not null then nome_func
            else 'Total de Comissões'
		end as 'Funcionário',
	    case 
			when nome_func is not null then group_concat(distinct p.num_ped)
            else ' '
		end as 'Pedidos',
        sum(round((qtd_cd * (tp.val_cd - val_compra))/ 2,2)) as 'Comissão do Vendedor'
			from funcionarios f
			join pedidos p on f.cod_func = p.cod_func
			join titulos_pedidos tp on p.num_ped = tp.num_ped
			join titulos t on tp.cod_tit = t.cod_tit
			group by nome_func
            with rollup; 
 
-- ======================================================================================================================================================= 
 
-- PEDIDOS DE FUNCIONÁRIOS SEM FILHOS
select num_ped as 'Pedido',
	   nome_func as 'Funcionário',
       nome_dep as 'Dependente'
         from pedidos p
		 join funcionarios f on p.cod_func = f.cod_func
         left join dependentes d on f.cod_func = d.cod_func
		 where cod_dep is null
         order by num_ped;

-- =======================================================================================================================================================

-- PEDIDOS DE CLIENTES SOLTEIROS
select num_ped as 'Pedido',
	   nome_cli as 'Cliente',
       nome_conj as 'Conjuge'
       from conjuges cj
		 right join clientes c on cj.cod_cli = c.cod_cli
         join pedidos p on c.cod_cli = p.cod_cli
         where nome_conj is null;

-- ======================================================================================================================================================= 
 
-- PEDIDOS DE CLIENTES SOLTEIROS QUE COPMPRARAM MARISA MONTE
select p.num_ped as 'Pedido',
	   nome_cli as 'Cliente',
       nome_conj as 'Conjuge',
       nome_art as 'Artista',
       nome_cd as 'Titulo'
         from conjuges cj
		 right join clientes c on cj.cod_cli = c.cod_cli
         join pedidos p on c.cod_cli = p.cod_cli
         join titulos_pedidos tp on p.num_ped = tp.num_ped
         join titulos t on tp.cod_tit = t.cod_tit
         join titulos_artistas ta on t.cod_tit = ta.cod_tit
         join artistas a on ta.cod_art = a.cod_art
         where nome_conj is null
         and nome_art = 'Marisa Monte';

-- ======================================================================================================================================================= 
  
-- PEDIDOS DE MARISA MONTE, COM NOME DO FUNCIONARIO E NOME DO CLIENTE            
select p.num_ped as 'Pedido',
	   nome_cli as 'Cliente',
       nome_func as 'Funcionário',
       nome_art as 'Artista',
       nome_cd as 'Titulo'
         from pedidos p 
         join clientes c on c.cod_cli = p.cod_cli
         join funcionarios f on p.cod_func = f.cod_func
         join titulos_pedidos tp on p.num_ped = tp.num_ped
         join titulos t on tp.cod_tit = t.cod_tit
         join titulos_artistas ta on t.cod_tit = ta.cod_tit
         join artistas a on ta.cod_art = a.cod_art
         where nome_art = 'Marisa Monte';

-- ======================================================================================================================================================= 

-- PEDIDOS DE MPB, EXCETO TITULO COMEÇANDO COM VOGAL, NOME DO FUNCIONARIO E NOME DO CLIENTE E COM NOME DO CONJUGE E FILHO
select p.num_ped as 'Pedido',
	   nome_func as 'Funcionário',
       nome_dep as 'Dependente',
       nome_cli as 'Cliente',
       nome_conj as 'Conjuge',
       nome_cd as 'Titulo'
		from pedidos p 
        join funcionarios f on p.cod_func = f.cod_func
        left join dependentes d on f.cod_func = d.cod_func
        join clientes c on p.cod_cli = c.cod_cli
        left join conjuges cj on c.cod_cli = cj.cod_cli
		join titulos_pedidos tp on p.num_ped = tp.num_ped
		join titulos t on tp.cod_tit = t.cod_tit
        join categorias ct on t.cod_cat = ct.cod_cat
        where nome_cat = 'MPB'
        and nome_cd regexp '^[^aeiou]';
        
        










