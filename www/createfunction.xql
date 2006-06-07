<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_returns">
      <querytext>
      SELECT pg_catalog.format_type(t.oid, NULL) AS typname1,
      pg_catalog.format_type(t.oid, NULL) AS typname2
      FROM (pg_catalog.pg_type t
      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace)
      LEFT JOIN pg_catalog.pg_user pu ON t.typowner = pu.usesysid
      WHERE (t.typrelid = 0 OR (SELECT c.relkind IN ('c', 'r', 'v')
      FROM pg_catalog.pg_class c WHERE c.oid = t.typrelid AND c.relnamespace NOT IN
      (SELECT oid FROM pg_catalog.pg_namespace WHERE nspname LIKE 'pg_%')))   
      AND t.typname !~ '^_'
      AND pg_catalog.pg_type_is_visible(t.oid)		
      ORDER BY typname1	
      </querytext>
    </fullquery>

</queryset>   