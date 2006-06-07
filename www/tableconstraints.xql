<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_constraints">
      <querytext>
      SELECT
      pc.conname,
      pg_catalog.pg_get_constraintdef(pc.oid, true) AS consrc,
      pc.contype,
      CASE WHEN pc.contype='u' OR pc.contype='p' THEN (
      SELECT
      indisclustered
      FROM
      pg_catalog.pg_depend pd,
      pg_catalog.pg_class pl,
      pg_catalog.pg_index pi
      WHERE
      pd.refclassid=pc.tableoid 
      AND pd.refobjid=pc.oid
      AND pd.objid=pl.oid
      AND pl.oid=pi.indexrelid
      ) ELSE
      NULL
      END AS indisclustered
      FROM
      pg_catalog.pg_constraint pc
      WHERE
      pc.conrelid = (SELECT oid FROM pg_catalog.pg_class WHERE relname='$table'
      AND relnamespace = (SELECT oid FROM pg_catalog.pg_namespace
      WHERE nspname='public'))
      ORDER BY 1
      </querytext>
    </fullquery>

</queryset>  