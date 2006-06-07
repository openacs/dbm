<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_columns">
    <querytext>
    SELECT a.attname AS field1, a.attname AS field2
    FROM pg_class c, pg_attribute a, pg_type t
    WHERE c.relname = '$table'
    AND a.attnum > 0
    AND a.attrelid = c.oid
    AND a.atttypid = t.oid
    </querytext>
    </fullquery>
    
    <fullquery name="get_tables">
    <querytext>
    SELECT tablename AS name1, tablename AS name2 
    FROM pg_catalog.pg_tables 
    WHERE schemaname NOT IN ('pg_catalog',
    'information_schema', 'pg_toast')
    order by tablename 
    </querytext>
    </fullquery>  


</queryset>