<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_types">
      <querytext>
      SELECT pg_catalog.format_type(t.oid, NULL) AS type1,
      pg_catalog.format_type(t.oid, NULL) AS type2
      FROM pg_catalog.pg_type t
      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
      WHERE (t.typrelid = 0 OR (SELECT c.relkind = 'c' FROM pg_catalog.pg_class c
      WHERE c.oid = t.typrelid)) AND t.typname !~ '^_'
      AND pg_catalog.pg_type_is_visible(t.oid)
      AND n.nspname = 'pg_catalog'
      ORDER BY pg_catalog.format_type(t.oid, NULL);
      </querytext>
    </fullquery>

</queryset>   