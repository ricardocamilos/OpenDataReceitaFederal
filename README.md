# OpenDataReceitaFederal

Este projeto é um laboratório para a utilização de tecnologias para o processamento e disponibilização dos dados do cadastro de CNPJ da Receita Federal.

Os arquivos estão disponíveis no neste [link](http://receita.economia.gov.br/orientacao/tributaria/cadastros/cadastro-nacional-de-pessoas-juridicas-cnpj/dados-publicos-cnpj)

O primeiro passo é realizar a leitura dos arquivos e conseguir realizar consultas com filtros. Para isso vamos utilizar o [Apache Drill](https://drill.apache.org/), a escolha desta ferramenta deve-se ao fato de que ela permite consultas em arquivos sem a necessidade de transformações ou movimentação dos dados para um banco de dados centralizado:

>"Drill enables an analyst, armed only with a knowledge of SQL or a business intelligence (BI) tool such as Tableau, to analyze and query their data without having to transform the data or move it to a centralized data store."

Como referência de pesquisa utilizamos o livro [Learning Apache Drill: Query and Analyze Distributed Data Sources with SQL](https://www.oreilly.com/library/view/learning-apache-drill/9781492032786/),

![](https://www.oreilly.com/library/cover/9781492032786/360h/)

O site oficial do Apache Drill

![](https://drill.apache.org/docs/)
