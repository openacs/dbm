<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="views_pagination">
      <querytext>
      SELECT c.relname,
      n.nspname,
      CASE c.relkind WHEN 'r' THEN 'table' WHEN 'v' THEN 'view' WHEN 'i' THEN
      'index' WHEN 'S' THEN 'sequence' WHEN 's' THEN 'special' END,
      u.usename
      FROM pg_catalog.pg_class c
      LEFT JOIN pg_catalog.pg_user u ON u.usesysid = c.relowner
      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace
      WHERE c.relkind IN ('v','')
      AND n.nspname NOT IN ('pg_catalog', 'pg_toast')
      AND pg_catalog.pg_table_is_visible(c.oid)
      [template::list::orderby_clause -name views -orderby]
      </querytext>
    </fullquery>

   
 <fullquery name="get_views">
      <querytext>
      SELECT c.relname,
      n.nspname,
      CASE c.relkind WHEN 'r' THEN 'table' WHEN 'v' THEN 'view' WHEN 'i' THEN
      'index' WHEN 'S' THEN 'sequence' WHEN 's' THEN 'special' END,
      u.usename
      FROM pg_catalog.pg_class c
      LEFT JOIN pg_catalog.pg_user u ON u.usesysid = c.relowner
      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = c.relnamespace	
      WHERE c.relkind IN ('v','')
      AND n.nspname NOT IN ('pg_catalog', 'pg_toast')
      AND pg_catalog.pg_table_is_visible(c.oid)
      AND [template::list::page_where_clause -name views]
      [template::list::orderby_clause -name views -orderby]	
      </querytext>
    </fullquery>

</queryset>   