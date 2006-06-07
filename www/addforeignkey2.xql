<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_columns2">
    <querytext>
    SELECT a.attname AS field1, a.attname AS field2
    FROM pg_class c, pg_attribute a, pg_type t
    WHERE c.relname = '$targettable'
    AND a.attnum > 0
    AND a.attrelid = c.oid
    AND a.atttypid = t.oid
    </querytext>
    </fullquery>
   

</queryset>