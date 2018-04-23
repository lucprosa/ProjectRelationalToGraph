//qry10_rel_adm082_sys010.cypher
match (t:Tables)-[r:RELATIONSHIP]->(t2:Tables)
WHERE t2.TableName="SYS010" and t.TableName="ADM082" RETURN r