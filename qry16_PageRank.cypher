// qry16_PageRank
MATCH (l:Tables) WITH collect(l) AS ls
CALL apoc.algo.pageRank(ls) YIELD node,score
RETURN node.TableName as Tabela, node.triangles as Triangulos, node.coefficient as Coefficient, node.betweenness as Betweenness,  score ORDER BY score DESC LIMIT 10