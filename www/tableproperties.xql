<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_properties">
      <querytext>
SELECT a.attnum, a.attname AS field, t.typname AS type,
       a.attnotnull AS not_null, a.atthasdef as has_default
  FROM pg_class c, pg_attribute a, pg_type t
 WHERE c.relname = '$table'
   AND a.attnum > 0
   AND a.attrelid = c.oid
   AND a.atttypid = t.oid
 ORDER BY a.attnum;
       </querytext>
    </fullquery>
</queryset>   