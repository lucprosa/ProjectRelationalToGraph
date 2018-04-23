//qry12_top_tabs_tam.cypher
MATCH p=(tabs:Tables)
WITH tabs
ORDER BY toInt(tabs.Size) DESC
RETURN tabs.TableName as Tabela, toInt(tabs.Size)/1024/1024 as TamanhoMB
LIMIT 20