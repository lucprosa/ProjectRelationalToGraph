// qry08_triang_cnt.cypher
CALL algo.triangleCount.stream('Tables', 'RELATIONSHIPS', {concurrency:4})
YIELD nodeId, triangles;