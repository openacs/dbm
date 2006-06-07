<?xml version="1.0"?>
<queryset>
    <rdbms><type>postgresql</type><version>7.1</version></rdbms>
    <fullquery name="get_information">
      <querytext>
      SELECT d.datname as "Name",
       u.usename as "Owner",
       pg_catalog.pg_encoding_to_char(d.encoding) as "Encoding"
FROM pg_catalog.pg_database d
  LEFT JOIN pg_catalog.pg_user u ON d.datdba = u.usesysid
ORDER BY 1;
      </querytext>
    </fullquery>

</queryset>   