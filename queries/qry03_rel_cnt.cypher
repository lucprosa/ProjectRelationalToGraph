// qry03_rel_cnt.cypher
MATCH (tabs:Tables)-[r:RELATIONSHIP]->(tabs2:Tables)
WITH  count(r) as count
RETURN count