-- Script to export database metadata to graph database

declare
c integer:=1;
ExcludeTables varchar2(4000):= ',SYS002_UNIT_BKP
,STO001_STOCK_BKP
,STO025_STOCK_TIME_TABLE_BKP
,G_BOOKS
,G_CUSTOMERS
,G_AUTHORS
,G_ORDERS
,G_LINE_ITEMS
,G_BOOK_AUTHORS
,MV_STO020
,MV_TAB_COMMENTS
,MY_STATS_TABLE
,BKP_STAT_170328
,DZ_LOTES_PERSONAL
,ESTIMATIVA_CRESCIMENTO
,MLOG$_ADM010_HOLIDAY
,VW_STO020
,TMPQUEST
,TMP_EMR027_PATIENT_MATERIAL
,GLOBAL_TEMP_ID_TABLE
,TMP_EMR010_PATIENT_MEDICATION
,TMP_EMR028_PATIENT_SERVICE
,GLOBAL_TEMP_BALANCE
,TMP_EMR032_SURGERY_PRODUCT
';

begin  

 dbms_output.put_line ('\\Creating tables...');
  
for curTabs in (select substr(ut.table_name, 1, instr(ut.table_name, '_') - 1) table_name,
               ut.table_name full_table_name,
               ut.NUM_ROWS,
               utc.COMMENTS,
               us.BYTES
          from user_tables ut, user_tab_comments utc, user_segments us
         where ut.TABLE_NAME = utc.TABLE_NAME(+)
           and ut.TABLE_NAME = us.segment_name(+)
 and ut.table_name not in
  (select regexp_substr(ExcludeTables, '[^,]+', 1, level) str
                from dual
              connect by regexp_substr(ExcludeTables, '[^,]+', 1, level) is not null)
          ) 
  loop               

  dbms_output.put_line ('CREATE (' || curTabs.table_name || ':Tables {TableName: ''' || curTabs.table_name ||
       ''', FullTableName:''' || curTabs.Full_Table_Name || ''', desc:''' ||
       replace(replace(replace(curTabs.comments, chr(10), ''), chr(13), ''),
               '''',
               '') || ''', NumRows:' || curTabs.num_rows || ', Size:' ||
       curTabs.bytes || '})');

  end loop;

  dbms_output.put_line (chr(10) || '\\Creating relationships...');
  
  for cur in (select distinct substr(uc.table_name, 1, instr(uc.table_name, '_') - 1) table_name,
       uc.CONSTRAINT_NAME,
       substr(uc2.table_name, 1, instr(uc2.table_name, '_') - 1) table_name_ref,
       ucc.COLUMN_NAME FKColumnName,
       case when uic.INDEX_NAME is not null then 'Y' else 'N' end HasIndex,
         us.bytes/1024 weight  
  from user_constraints uc, user_constraints uc2, user_cons_columns ucc, user_ind_columns uic, user_segments us
 where uc.CONSTRAINT_NAME = ucc.CONSTRAINT_NAME
   and uc.R_CONSTRAINT_NAME = uc2.CONSTRAINT_NAME
   and ucc.TABLE_NAME = uic.TABLE_NAME(+)
   and ucc.COLUMN_NAME = uic.COLUMN_NAME(+)
   and uc.CONSTRAINT_TYPE = 'R'
   and uc2.table_name =  us.segment_name   
   and uc.table_name not in 
   (select regexp_substr(ExcludeTables, '[^,]+', 1, level) str
                from dual
              connect by regexp_substr(ExcludeTables, '[^,]+', 1, level) is not null)
          )
   loop   
   
   if c=1 then 
     dbms_output.put_line ('CREATE');
     dbms_output.put_line ('(' || cur.table_name || ')-[:RELATIONSHIP {ConstraintName:''' || cur.constraint_name || ''', Weight: ' || cur.weight  || ' HasIndex: '''|| cur.HasIndex || ''', FKColumnName:''' || cur.FKColumnName || '''}]->(' || cur.table_name_ref || ')');
   end if;      
     dbms_output.put_line (',(' || cur.table_name || ')-[:RELATIONSHIP {ConstraintName:''' || cur.constraint_name || ''', Weight: ' || cur.weight  || ' HasIndex: '''|| cur.HasIndex || ''', FKColumnName:''' || cur.FKColumnName || '''}]->(' || cur.table_name_ref || ')');    
   c:=c+1;   
   end loop;                           
end;
/