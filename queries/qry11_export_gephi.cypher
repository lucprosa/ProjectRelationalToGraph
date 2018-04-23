//qry11_export_gephi.cypher
match p=(t:Tables)-[r:RELATIONSHIP]->(t2:Tables)
WITH p
call apoc.gephi.add(null,'workspace',p,'weight',['TableName', 'ConstraintName']) yield nodes, relationships, time
return nodes, relationships, time