// qry02_tabs_cnt.cypher
MATCH (tabs:Tables)
WITH  count(tabs) as count
RETURN count