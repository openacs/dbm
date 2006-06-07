<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_users">
    <querytext>
    select usename as name1, usename as name2 from pg_user order by usename
    </querytext>
    </fullquery>

    <fullquery name="get_groups">
    <querytext>
    SELECT groname as group1, groname as group2 FROM pg_group ORDER BY
    groname
    </querytext>
    </fullquery>

</queryset>