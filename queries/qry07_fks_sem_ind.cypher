// qry07_fks_sem_ind.cypher
MATCH (tabs:Tables)-[r:RELATIONSHIP]->()
WHERE r.HasIndex='N'
RETURN tabs.TableName as TableName, r.ConstraintName as ConstraintName
ORDER BY tabs.TableName asc