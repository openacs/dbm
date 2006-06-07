<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_users">
    <querytext>
    select usename as name1, usename as name2 from pg_user order by usename
    </querytext>
    </fullquery>
</queryset>