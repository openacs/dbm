<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_privileges">
      <querytext>
      select datacl from pg_database where datname='oacs-5-2'
      </querytext>
    </fullquery>
</queryset>