// qry14_top_tabs_rel_graph.cypher
MATCH p=(tabs:Tables)
WITH tabs
ORDER BY toInt(tabs.Size) DESC
LIMIT 10
MATCH p2=()-[r:RELATIONSHIP]->(tabs) 
RETURN p2