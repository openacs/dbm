<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_triggers">
      <querytext>
SELECT t.tgname, 
p.proname AS tgfname, c.relname, NULL AS tgdef
FROM pg_catalog.pg_trigger t LEFT JOIN pg_catalog.pg_proc p
ON t.tgfoid=p.oid, pg_catalog.pg_class c
WHERE t.tgrelid=c.oid
AND c.relname='$table'
AND c.relnamespace=(SELECT oid FROM pg_catalog.pg_namespace WHERE
      nspname='public')
AND (NOT tgisconstraint OR NOT EXISTS
(SELECT 1 FROM pg_catalog.pg_depend d JOIN pg_catalog.pg_constraint c
ON (d.refclassid = c.tableoid AND d.refobjid = c.oid)
WHERE d.classid = t.tableoid AND d.objid = t.oid AND d.deptype = 'i' AND
      c.contype = 'f'))

      </querytext>
    </fullquery>

</queryset>  