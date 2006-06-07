<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_indexes">
      <querytext>
      SELECT c2.relname, i.indisprimary, i.indisunique, i.indisclustered,
      pg_catalog.pg_get_indexdef(i.indexrelid, 0, true)
      FROM pg_catalog.pg_class c, pg_catalog.pg_class c2, pg_catalog.pg_index
      i
      WHERE c.relname = '$table' AND pg_catalog.pg_table_is_visible(c.oid) 
      AND c.oid = i.indrelid AND i.indexrelid = c2.oid
      </querytext>
    </fullquery>

</queryset>  