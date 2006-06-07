<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_checks">
      <querytext>
		select conname, 'CHECK (' || consrc || ')' as consrc from pg_catalog.pg_constraint where
		contypid = (select oid from 
			   pg_catalog.pg_type where typname='$domain');
      </querytext>
    </fullquery>
</queryset>  