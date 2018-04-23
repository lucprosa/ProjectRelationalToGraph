//qry01_import.cypher
// Import tables
USING PERIODIC COMMIT
LOAD CSV WITH HEADERS FROM "file:\\tables.csv" AS tab
CREATE (:Tables {TableName: tab.TABLE_NAME, FullTableName: tab.FULL_TABLE_NAME, NumRows: tab.NUM_ROWS, Desc: tab.COMMENTS, Size: tab.BYTES})

CREATE CONSTRAINT ON (tab:Tables) ASSERT tab.TableName IS UNIQUE

// Import Relationships
USING PERIODIC COMMIT 500
LOAD CSV WITH HEADERS FROM "file:\\relationships.csv" AS rel
MATCH (tab:Tables { TableName:rel.TABLE_NAME})
MATCH (tab2:Tables { TableName:rel.TABLE_NAME_REF})
create (tab)-[:RELATIONSHIP {ConstraintName:rel.CONSTRAINT_NAME, HasIndex: rel.HASINDEX, Weight: rel.WEIGHT, FKColumnName: rel.FKCOLUMNNAME}]->(tab2)


