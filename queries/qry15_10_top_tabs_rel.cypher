// qry15_10_top_tabs_rel.cypher
MATCH p=()-[r:RELATIONSHIP]->(tabs:Tables)
WITH tabs, count(tabs) as count
ORDER BY count desc
RETURN tabs.TableName as TableName, count
LIMIT 10