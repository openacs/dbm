<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_schemas">
      <querytext>
      SELECT pn.nspname, pu.usename
      FROM pg_catalog.pg_namespace pn LEFT JOIN pg_catalog.pg_user pu ON
      (pn.nspowner = pu.usesysid)
      WHERE nspname NOT LIKE 'pg_%'
      AND nspname NOT IN ('information_schema') 
      ORDER BY nspname;
      </querytext>
    </fullquery>

</queryset>  