use cp;
show files;

ALTER SESSION SET `store.format` = 'parquet';

create table dfs.arquivo.cnpj_receita_federal_pq as
select row_number() over(partition by 1) as rownum, columns[0] as texto from dfs.`Drill/receita_federal/SAMPLE_F.K032001K.D90308.csv`;

create table dfs.arquivo.cnpj_receita_federal_pq2 as
select substr(columns[0],1,1) as fl_tipo,columns[0] as texto from dfs.`Drill/receita_federal/SAMPLE_F.K032001K.D90308.csv`;
