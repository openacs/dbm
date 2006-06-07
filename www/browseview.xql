<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="views_pagination">
      <querytext>
      select * from $view
     
      </querytext>
    </fullquery>

    <fullquery name="browse_view">
      <querytext>
      select * from $view where
     [template::list::page_where_clause -name "views"]	     
      </querytext> 
    </fullquery>

    <fullquery name="get_fields">
      <querytext>
      SELECT a.attname
       FROM pg_class c, pg_attribute a, pg_type t
       WHERE c.relname = '$view'
       AND a.attnum > 0
       AND a.attrelid = c.oid
       AND a.atttypid = t.oid
       ORDER BY a.attnum;		       
      </querytext> 
    </fullquery>  
</queryset>  