<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>

    <fullquery name="get_privileges">
      <querytext>
      select nspacl from pg_namespace where nspname='$schema'
      </querytext>
    </fullquery>
</queryset>