// qry06_tabs_isoladas.cypher
MATCH (tabs:Tables) 
WHERE NOT (tabs)-[:RELATIONSHIP]->() 
AND NOT ()-[:RELATIONSHIP]->(tabs) 
RETURN tabs.TableName as TableName
ORDER BY tabs.TableName asc