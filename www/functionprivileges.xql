<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_privileges">
      <querytext>
      select proacl from pg_proc where oid='$oid'
      </querytext>
    </fullquery>
</queryset>