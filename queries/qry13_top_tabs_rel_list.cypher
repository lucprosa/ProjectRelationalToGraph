//qry13_top_tabs_rel_list.cypher
MATCH p=(tabs:Tables)
WITH tabs
ORDER BY toInt(tabs.Size) DESC
LIMIT 20
OPTIONAL MATCH (tabs2:Tables)-[r:RELATIONSHIP]->(tabs)
WITH  count(r) as count, tabs.TableName as Tb, tabs.Size as TbSize
RETURN Tb as Tabela, toInt(TbSize)/1024/1024 as TamanhoMB, count as CntRelation
ORDER BY TamanhoMB desc