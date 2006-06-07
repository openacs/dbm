<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_rules">
      <querytext>
		select rulename, definition from pg_rules
		where tablename ='$table' ORDER BY rulename;
      </querytext>
    </fullquery>

</queryset>  