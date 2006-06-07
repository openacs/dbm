<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_fields">
      <querytext>
      SELECT a.attname AS field
       FROM pg_class c, pg_attribute a, pg_type t
       WHERE c.relname = '$table'
       AND a.attnum > 0
       AND a.attrelid = c.oid
       AND a.atttypid = t.oid
       ORDER BY a.attnum;		       
      </querytext> 
    </fullquery>  

</queryset>

