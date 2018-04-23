//qry09_triang_exe.cypher
MATCH p=(t:Tables)-[r:RELATIONSHIP]->(t2:Tables)
where t.TableName="ADM485" return p