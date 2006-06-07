<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="functions_pagination">
      <querytext>
      SELECT proname, pt.typname, oidvectortypes(pc.proargtypes), pc.oid
      FROM pg_proc pc, pg_user pu, pg_type pt, pg_language pl
      WHERE pc.proowner = pu.usesysid AND pc.prorettype = pt.oid AND
      pc.prolang = pl.oid AND
      pc.oid > (SELECT datlastsysoid from pg_database limit 1)
      [template::list::orderby_clause -name functions -orderby]
      </querytext>
    </fullquery>



    <fullquery name="get_functions">
      <querytext>
      SELECT proname, pt.typname, oidvectortypes(pc.proargtypes), pc.oid
      
      FROM pg_proc pc, pg_user pu, pg_type pt, pg_language pl
      WHERE pc.proowner = pu.usesysid AND pc.prorettype = pt.oid AND
      pc.prolang = pl.oid AND
      pc.oid > (SELECT datlastsysoid from pg_database limit 1)
      and [template::list::page_where_clause -name functions]
      [template::list::orderby_clause -name functions -orderby]
      </querytext>
    </fullquery>

</queryset>