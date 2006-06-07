<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="dbm::table_icon.get_table_properties">
      <querytext>
       SELECT a.attnum, 
              a.attname AS field, 
              t.typname AS type,
              a.attnotnull AS not_null, 
              a.atthasdef as has_default
       FROM 
              pg_class c, pg_attribute a, pg_type t
       WHERE 
              c.relname = :name AND
              a.attnum > 0 AND
              a.attrelid = c.oid AND
              a.atttypid = t.oid
       ORDER BY 
              a.attnum;
       </querytext>
    </fullquery>

    <fullquery name="dbm::table_icon.get_table_info">
      <querytext>
      SELECT nspname as namespace, 
      relname as tablename, 
      pg_catalog.pg_get_userbyid(relowner) AS tableowner, 
      relhasindex as hasindexes, 
      relhasrules as hasrules, 
      reltriggers as hastriggers, 
      pg_class.oid as table_id, 
      pg_catalog.obj_description(pg_class.oid,'pg_class') as
      table_description, 
      relacl, 
      CASE WHEN relkind = 'r' THEN 'table' WHEN relkind = 's' THEN 'special' ELSE 'view' END as reltype, 
      CASE WHEN relkind = 'v' THEN pg_get_viewdef(pg_class.oid) ELSE NULL END as view_definition
      FROM pg_catalog.pg_class
      JOIN pg_catalog.pg_namespace ON (relnamespace = pg_namespace.oid)
      WHERE relkind IN ('r', 's', 'v')
      AND relname = :name
     </querytext>
    </fullquery>

    <fullquery name="dbm::table_icon.get_table_constraints">
      <querytext>
      SELECT pg_constraint.oid, 
	     pg_namespace.nspname AS namespace, 
	     pg_constraint.conname AS constraint_name,
	     conkey AS constraint_key, 
	     confkey AS constraint_fkey, 
	     (select relname from pg_class where pg_class.oid = confrelid) as table_name,
	     confrelid
	   FROM pg_catalog.pg_constraint
	   JOIN pg_catalog.pg_class ON (pg_class.oid = conrelid)
	   JOIN pg_catalog.pg_class AS pc ON (pc.oid = confrelid)
	   JOIN pg_catalog.pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
	   JOIN pg_catalog.pg_namespace AS pn ON (pn.oid = pc.relnamespace)
	   WHERE contype = 'f'
	   AND conrelid = :table_id
     </querytext>

    </fullquery>

    <fullquery name="dbm::table_icon.get_referencing_tables">
      <querytext>
      SELECT distinct
	     pg_constraint.conname AS constraint_name,
	     (select relname from pg_class where pg_class.oid = confrelid) as ref_table_name,
	     (select relname from pg_class where pg_class.oid = conrelid) as table_name
	   FROM pg_catalog.pg_constraint
	   JOIN pg_catalog.pg_class ON (pg_class.oid = conrelid)
	   JOIN pg_catalog.pg_class AS pc ON (pc.oid = confrelid)
	   JOIN pg_catalog.pg_namespace ON (pg_class.relnamespace = pg_namespace.oid)
	   JOIN pg_catalog.pg_namespace AS pn ON (pn.oid = pc.relnamespace)
	   WHERE contype = 'f'
	   AND confrelid = :table_id
     </querytext>

    </fullquery>

    <fullquery name="get_types">
      <querytext>
      SELECT pg_catalog.format_type(t.oid, NULL) AS typname,
      pg_catalog.format_type(t.oid, NULL) AS typname2
      FROM (pg_catalog.pg_type t
      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace)
      LEFT JOIN pg_catalog.pg_user pu ON t.typowner = pu.usesysid
      WHERE (t.typrelid = 0 OR (SELECT c.relkind IN ('c') FROM
      pg_catalog.pg_class c
      WHERE c.oid = t.typrelid AND c.relnamespace NOT IN (SELECT oid FROM
      pg_catalog.pg_namespace WHERE nspname LIKE 'pg_%')))
      AND pg_catalog.pg_type_is_visible(t.oid)	
      ORDER BY typname
      </querytext>
    </fullquery>

</queryset>

