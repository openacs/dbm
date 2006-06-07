<?xml version="1.0"?>
<queryset>
	<rdbms><type>postgresql</type><version>7.1</version></rdbms>
        <fullquery name="tables_pagination">
                   <querytext>
                   SELECT tablename, schemaname,
                   tableowner FROM pg_catalog.pg_tables
                   WHERE schemaname NOT IN ('pg_catalog',
                   'information_schema', 'pg_toast')
                   [template::list::orderby_clause -name tables -orderby]
                   </querytext>
        </fullquery>


	<fullquery name="get_tablename">
		   <querytext>
		   SELECT tablename, schemaname,
		   tableowner FROM pg_catalog.pg_tables 
		   WHERE schemaname NOT IN ('pg_catalog',
		   'information_schema', 'pg_toast') 
		   and [template::list::page_where_clause -name tables]
		   [template::list::orderby_clause -name tables -orderby]	     
		   </querytext>
	</fullquery>
</queryset>			   