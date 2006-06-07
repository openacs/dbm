<?xml version="1.0"?>
<queryset>
	<rdbms><type>postgresql</type><version>7.1</version></rdbms>
	<fullquery name="get_databases">
		   <querytext>
		   select datname from pg_database order by datname
		   </querytext>
	 </fullquery>
</queryset>	    