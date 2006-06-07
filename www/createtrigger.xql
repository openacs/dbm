<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_functions">
      <querytext>
      SELECT DISTINCT ON (p.proname)
      p.proname AS name, p.proname AS name2
      FROM pg_catalog.pg_proc p
      INNER JOIN pg_catalog.pg_namespace n ON n.oid = p.pronamespace
      INNER JOIN pg_catalog.pg_language pl ON pl.oid = p.prolang
      LEFT JOIN pg_catalog.pg_user u ON u.usesysid = p.proowner
      WHERE NOT p.proisagg
      AND pg_catalog.pg_function_is_visible(p.oid) 
      AND p.prorettype = (select oid from pg_catalog.pg_type p where p.typname
      = 'trigger')
      ORDER BY p.proname
      </querytext>
    </fullquery>

</queryset>   