/*Define que o schema padrao, deve ser mapeado no workspace*/
use dfs.receita_federal;
/*Exibe os arquivos que estão no workspace*/
show files;
/*Configura a gravacao em formato Parquet*/
ALTER SESSION SET `store.format` = 'parquet';

/*Criei um arquivo com pouco mais de 100mil registros*/

/*Cria uma copia dos dados em parquet com SK*/
drop table receita_federal_pq;

/*Teste feito para leitura de vários arquivos no mesmo diretório*/
--https://drill.apache.org/docs/querying-directories/
--select count(*) from `20190515/DADOS/`;
/*Funcionou!*/

/*Teste feito para leitura de vários arquivos compactados*/
--https://drill.apache.org/docs/querying-plain-text-files/
--select columns[0] from `20190515/ZIP/*.gz`;
/*Não Funcionou com .zip*/
/*Funcionou com .gz*/

create table receita_federal_pq as
select row_number() over(partition by 1) as rownum, columns[0] as texto from `20190515/DADOS/K3241.K03200DV.D90607.L00001`;
--Alterado o formato do arquivo de csv para tsv, pois estava cortando os dados na virgula
--O defaultInputFormat do workspace foi alterado para tsv, para nao precisar renomear os arquivos

select * from receita_federal_pq;

/*Altera parametros de memória para processar os arquivos parquet*/
alter session set `planner.width.max_per_node`=1;
--alter session set `planner.width.max_per_query`=1;
alter session set `planner.enable_hashjoin`=false;
alter session set `planner.memory.enable_memory_estimation`=true;

/*Cria uma tabela com uma coluna de tipo de registro*/
drop table receita_federal_reg;

create table receita_federal_reg as 
select $0 as rownum, cast(substring($1,1,1) as integer) as tp_registro,substring($1,2) as registro 
from receita_federal_pq;
/*Este erro estava acontecendo e foi corrigido*/
--Unexpected byte 0xa8 at position 984804
--Abrir arquivo no EmEditor e salvar UTF8 without Signature ou converter via unix

--O arquivo original tem 80GB precisa de conversão no terminal
--Via unix
--sed '1s/^\xEF\xBB\xBF//' < orig.txt > new.txt
--Via dos (iconv)
--iconv -f UTF-16 -t UTF-8 myfile.txt
--PowerShell
--Get-ChildItem -File -Recurse | % { $x = get-content -raw -path $_.fullname; $x -replace "`r`n","`n" | set-content -path $_.fullname }


select * from receita_federal_reg;

/*Cria uma tabela com os registros das empresas*/
drop table receita_federal_cnpj;
create table receita_federal_cnpj as
select registro from receita_federal_reg where tp_registro=1;

select * from receita_federal_cnpj;

/*Cria uma tabela com os registros dos socios*/
drop table receita_federal_socio;
create table receita_federal_socio as
select registro from receita_federal_reg where tp_registro=2;

select * from receita_federal_socio;

/*Cria uma tabela com os registros dos socios*/
drop table receita_federal_cnae;
create table receita_federal_cnae as
select registro from receita_federal_reg where tp_registro=6;

select * from receita_federal_cnae;
