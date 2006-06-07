<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_privileges">
      <querytext>
      select relacl from pg_class where relname='$sequence'
      </querytext>
    </fullquery>
</queryset>