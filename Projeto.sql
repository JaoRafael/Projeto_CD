create database db_cds;
use db_cds;

-- =======================================================================================================================================================

-- tabela funcionario
create table funcionarios(cod_func int not null auto_increment,
						  nome_func varchar(100) not null,
                          end_func varchar(200) not null,
                          sal_func decimal(10,2) not null default 0,
                          sexo_func char(1) not null default 'F', 
                          
                          constraint pk_func primary key(cod_func),
                          constraint ch_func_1 check (sal_func >= 0),
                          constraint ch_func_2 check (sexo_func in ('F', 'M')));
                          
desc funcionarios;                          

-- =======================================================================================================================================================

-- dados tabela funcionarios 
insert funcionarios values(null, 'Vania Gabriela Pereira', 'Rua A', 2500.00, 'F'),
						  (null, 'Norberto Pereira da Silva', 'Rua B', 2300.00, 'M'),
                          (null, 'Olavo Linhares', 'Rua C', 2300.00, 'M'),
                          (null, 'Paula da Silva', 'Rua D', 3000.00, 'F'),
                          (null, 'Rolando Rocha', 'Rua E', 2000.00, 'M');

-- =======================================================================================================================================================
                          
 -- tabela dependente
 create table dependentes(cod_dep int not null auto_increment,
						  cod_func int not null,
                          nome_dep varchar(100) not null,
                          sexo_dep char(1) not null default 'M',
-- restrição completa a nivel de tabela                         
                          constraint pk_dep primary key (cod_dep),
                          constraint fk_dep foreign key (cod_func) references funcionarios (cod_func),
                          constraint ch_dep check (sexo_dep in ('F', 'M')));
desc dependentes;

-- =======================================================================================================================================================

-- dados tabela dependente  
insert dependentes values (null, 1, 'Ana Pereira', 'F'),
						  (null, 1, 'Roberto Pereira', 'M'),
                          (null, 3, 'Brisa Linhares', 'F'),
                          (null, 3, 'Mari Sol Linhares', 'F'),
                          (null, 4, 'Sonia da Silva', 'F');
select * from dependentes;                          

-- =======================================================================================================================================================

-- tabela estado
create table estados (sigla_est char(2) not null,
					  nome_est char(50) not null,
                      
                      constraint pk_est primary key(sigla_est),
                      constraint uq_est unique(nome_est));

-- =======================================================================================================================================================
                      
-- dados tabela estado
insert estados values('SP', 'São Paulo'),
					 ('MG', 'Minas Gerais'),
                     ('RJ', 'Rio de Janeiro');
select *from estados;

-- =======================================================================================================================================================
  
-- tabela cidade
create table cidades(cod_cid int not null auto_increment,
					 sigla_est char(2) not null,
                     nome_cid varchar(100) not null,
                     
                     constraint pk_cid primary key (cod_cid),
                     constraint fk_cid foreign key (sigla_est) references estados(sigla_est));

-- =======================================================================================================================================================
                     
-- dados da tabela cidade 
insert cidades values (null, 'SP', 'São Paulo'),
					  (null, 'SP', 'Sorocaba'),
					  (null, 'SP', 'Jundiai'),
					  (null, 'SP', 'Americana'),
					  (null, 'SP', 'Araraquara'),
					  (null, 'MG', 'Ouro Preto'),
					  (null, 'RJ', 'Cachoeiro do Itapemirin');  
select * from cidades;                      

-- =======================================================================================================================================================
  
  -- tabela cliente
  create table clientes(cod_cli int not null auto_increment,
						cod_cid int not null,
                        nome_cli varchar(100) not null,
                        end_cli varchar(100) not null,
                        renda_cli decimal(10,2) not null default 0,
                        sexo_cli char(1) not null default 'F',
                        
                        constraint pk_cli primary key (cod_cli),
                        constraint fk_cli foreign key (cod_cid) references cidades(cod_cid),
                        constraint ch_cli_1 check (renda_cli >= 0),
                        constraint ch_cli_2 check (sexo_cli in ('F', 'M')));

-- =======================================================================================================================================================
                        
-- dados tabela cliente 
insert clientes values(null, 1, 'Jose Nogueira', 'Rua A', 1500.00, 'M'),
					  (null, 1, 'Angelo Pereira', 'Rua B', 2000.00, 'M'),
                      (null, 1, 'Alem Mar Paranhos', 'Rua C', 1500.00, 'F'),
                      (null, 1, 'Catarina Souza', 'Rua D', 892.00, 'F'),
                      (null, 1, 'Vagner Costa', 'Rua E', 950.00, 'M'),
                      (null, 2, 'Antenor da Costa', 'Rua F', 1582.00, 'M'),
                      (null, 2, 'Maria Amelia de Souza', 'Rua G', 1152.00, 'F'),
                      (null, 2, 'Paulo Roberto da Silva', 'Rua H', 3950.00, 'M'),
                      (null, 1, 'Fatima de Souza', 'Rua I', 16325.00,'F'),
                      (null, 3, 'Joel da Rocha', 'Rua J', 2000.00, 'M'); 
select * from clientes;                      

-- =======================================================================================================================================================
  
-- tabela conjuges 
create table conjuges (cod_cli int not null,
					   nome_conj varchar(100) not null,
                       renda_conj decimal(10,2) not null default 0,
                       sexo_conj char(1) not null default 'M',
                       
                       constraint pk_conj primary key(cod_cli),
                       constraint fk_conj foreign key(cod_cli) references clientes(cod_cli),
                       constraint ch_conj_1 check (renda_conj >= 0),
                       constraint ch_conj_2 check(sexo_conj in('F', 'M')));

-- =======================================================================================================================================================
                       
-- dados da tabela conjuges
insert conjuges values(1, 'Carla Nogueira', 2500.00, 'F'),
					  (2, 'Emilia Pereira', 5500.00, 'F'),
                      (6, 'Altiva da Costa', 3000.00, 'F'),
                      (7, 'Carlos de Souza', 3250.00, 'M'); 
select * from conjuges;                     

-- =======================================================================================================================================================
  
-- tabela artista
create table artistas(cod_art int not null auto_increment,
					  nome_art varchar(100) not null,
-- reduzida a nivel de tabela, sem apelido, sem identificação                      
                      primary key (cod_art),
                      unique(nome_art));

-- =======================================================================================================================================================
                      
-- dados tabela artista 
insert artistas values(null, 'Marisa Monte'),
					 (null, 'Baby do Brasil'),
                     (null, 'Moraes Moreira'),
                     (null, 'Pepeu Gomes'),
                     (null, 'Paulinho Bica de Cantor'),
                     (null, 'Luiz Galvão'),
                     (null, 'Alceu Valença'),
                     (null, 'Geraldo Azevedo'),
                     (null, 'Elba Ramalho'),
                     (null, 'Carlinhos Brown'),
                     (null, 'Arnaldo Antunes'),
                     (null, 'Adriana Calcanhoto'),
                     (null, 'Aline Barros'),
                     (null, 'Gal Costa'),
                     (null, 'Chico Buarque'),
                     (null, 'Rita Lee'),
                     (null, 'Skank'),
                     (null, 'Lulu Santos'),
                     (null, 'Anitta'); 
select * from artistas;                     
 
-- ======================================================================================================================================================= 
 
-- tabela de gravadoras, restrições nivel de coluna 
create table gravadoras(cod_grav int not null primary key auto_increment,
						nome_grav varchar(50)unique not null);
 
-- ======================================================================================================================================================= 
 
-- dados tabela gravadoras  
insert gravadoras values(null, 'Phonomotor'),
						(null, 'Biscoito Fino'),
                        (null, 'Som Livre'),
                        (null, 'Sony Music'),
                        (null, 'Universal'),
                        (null, 'EMI');
select * from gravadoras;

-- =======================================================================================================================================================

-- tabela categorias
create table categorias(cod_cat int not null auto_increment,
						nome_cat varchar (50) not null,
-- restrições a nivel de tabela completa                        
                        constraint pk_cat primary key (cod_cat),
                        constraint uq_cat unique (nome_cat));

-- =======================================================================================================================================================
                        
-- dados tabela categoria 
insert categorias values(null, 'MPB'),
						(null, 'Trilha Sonora'),
                        (null, 'Gospel'),
                        (null, 'Rock Nacional');
select * from categorias;

-- =======================================================================================================================================================

-- tabela titulos
create table titulos(cod_tit int auto_increment,
					 cod_cat int not null,
                     cod_grav int not null,
                     nome_cd varchar (100) not null,
                     val_compra decimal (10,2) not null,
                     val_cd decimal (10,2) not null,
                     qtd_estq int not null,
                     
                     constraint pk_tit primary key(cod_tit),
                     constraint uq_tit unique(nome_cd),
                     constraint fk_tit_1 foreign key(cod_cat) references categorias(cod_cat),
                     constraint fk_tit_2 foreign key(cod_grav) references gravadoras(cod_grav),
                     constraint ch_tit_1 check(val_cd >= 0),
                     constraint ch_tit_2 check(qtd_estq >= 0));

-- =======================================================================================================================================================
                     
-- dados tabela titulo
insert titulos values(null, 1, 1, 'Tribalistas', 30.00, 150.00, 1500),
					 (null, 1, 3, 'Acabou Chorare Novos Baianos se Encontram',50.00, 200.00,500),
                     (null, 1, 4, 'O Grande encontro', 60.00, 120.00, 1000),
                     (null, 1, 2, 'Estratosfera', 50.00, 70.00, 2000),
                     (null, 1, 2, 'A Caravana', 55.00, 98.00, 500),
                     (null, 1, 4, 'Loucura', 30.00, 300.00, 200),
                     (null, 3, 4, 'Graça Extraordinária', 20.00, 250.00, 100),
                     (null, 4, 2, 'Reza', 30.00, 130.00, 300),
                     (null, 1, 5, 'Recanto', 30.00, 90.00, 500),
                     (null, 1, 6, 'O que voce quer saber de verdade', 30.00, 130.00, 500); 
select * from titulos;                     

-- =======================================================================================================================================================
  
-- tabela titulo_artista (detalhe do titulo)
create table titulos_artistas (cod_tit int not null, 
							   cod_art int not null,
                               
                               constraint pk_titart primary key (cod_tit, cod_art),
                               constraint fk1_titart foreign key (cod_tit) references titulos (cod_tit),
                               constraint fk2_titart foreign key (cod_art) references artistas (cod_art));

-- =======================================================================================================================================================
  
  -- dados tabela artista_titulo
insert titulos_artistas values  (1, 1),
								(1, 10),
                                (1, 11),
                                (2, 2),
                                (2, 3),
                                (2, 4),
                                (2, 5),
                                (2, 6),
                                (3, 7),
                                (3, 8),
                                (3, 9),
                                (4, 14),
                                (5, 15),
                                (6, 12),
                                (7, 13),
                                (8, 16),
                                (9, 14),
                                (10, 1);  
select * from titulos_artistas;  

-- =======================================================================================================================================================
  
-- Tabela Pedidos
create table pedidos(num_ped int not null auto_increment,
					 cod_cli int not null,
                     cod_func int not null,
                     data_ped datetime not null,
                     
                     constraint pk_ped primary key(num_ped),
                     constraint fk_ped_1 foreign key(cod_cli) references clientes(cod_cli),
                     constraint fk_ped_2 foreign key(cod_func) references funcionarios(cod_func));

-- =======================================================================================================================================================

-- Dados tabela pedidos
insert pedidos values (null, 1, 2, '2012/05/02'),
					  (null, 3, 4, '2012/05/02'),
                      (null, 4, 5, '2012/06/02'),
                      (null, 1, 4, '2013/03/02'),
                      (null, 7, 5, '2013/03/02'),
                      (null, 4, 4, '2013/03/02'),
                      (null, 5, 5, '2013/03/02'),
                      (null, 8, 2, '2013/03/02'),
                      (null, 2, 2, '2013/03/02'),
                      (null, 7, 1, '2013/03/02');
                     
select * from pedidos;
 
-- ======================================================================================================================================================= 
 
-- Tabela Tiulos Pedidos
create table titulos_pedidos(num_ped int not null,
							 cod_tit int not null,
                             qtd_cd int not null,
                             val_cd decimal(10, 2) not null,
                             
                             constraint pk_titped primary key(num_ped, cod_tit), -- <- chave primaria composta
                             constraint fk_titped_4 foreign key(cod_tit) references titulos(cod_tit),
                             constraint fk_titped_3 foreign key(num_ped) references pedidos(num_ped),
                             constraint ch_titped_2 check(qtd_cd >= 1),
                             constraint ch_titped_3 check(val_cd >= 0));

-- =======================================================================================================================================================
                     
-- Dados tabela titulo_pedido
insert titulos_pedidos values(1, 1, 2, 150.00),
							 (1, 2, 3, 200.00),
                             (2, 1, 1, 150.00),
                             (2, 2, 3, 200.00),
							 (3, 1, 2, 150.00),
                             (4, 2, 3, 200.00),
                             (5, 1, 2, 150.00),
                             (6, 2, 3, 200.00),
                             (6, 3, 1, 120.00),
                             (7, 4, 2, 70.00),
                             (8, 1, 4, 150.00),
                             (9, 2, 3, 200.00),
                             (10, 7, 2, 250.00);
                             
select * from titulos_pedidos;                              



         
         
















                      
                        