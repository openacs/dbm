<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="domains_pagination">
      <querytext>
      SELECT t.typname, n.nspname,
      t.typnotnull, t.typdefault,
      pg_catalog.format_type(t.typbasetype, t.typtypmod),
      pg_catalog.pg_get_userbyid(t.typowner)
      FROM pg_catalog.pg_type t
      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
      WHERE t.typtype = 'd'
      AND pg_catalog.pg_type_is_visible(t.oid)
      [template::list::orderby_clause -name domains -orderby]
      </querytext>
    </fullquery>

    <fullquery name="get_domains">
      <querytext>
      SELECT t.typname, n.nspname,
      t.typnotnull, t.typdefault,
      pg_catalog.format_type(t.typbasetype, t.typtypmod),
      pg_catalog.pg_get_userbyid(t.typowner)
      FROM pg_catalog.pg_type t
      LEFT JOIN pg_catalog.pg_namespace n ON n.oid = t.typnamespace
      WHERE t.typtype = 'd'
      AND pg_catalog.pg_type_is_visible(t.oid)
      and [template::list::page_where_clause -name domains]
      [template::list::orderby_clause -name domains -orderby]
      </querytext>
    </fullquery>

</queryset>  