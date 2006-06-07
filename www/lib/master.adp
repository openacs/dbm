@doc_type;noquote@
<html>
  <head>
    <title>@title;noquote@</title>
    <multiple name="header_links">
      <link rel="@header_links.rel@" type="@header_links.type@"
      href="@header_links.href@" media="@header_links.media@">
    </multiple>

    <if @acs_blank_master__htmlareas@ not nil><script type="text/javascript"
    src="/resources/acs-templating/rte/richtext.js"></script></if>

    <script type="text/javascript"
    src="/resources/acs-subsite/core.js"></script>

    @header_stuff;noquote@
  </head>
  <body<multiple name="attribute">
  @attribute.key@="@attribute.value@"</multiple>>
  <if @acs_blank_master__htmlareas@ not nil>
    <script type="text/javascript"><!--
      //Usage: initRTE(imagesPath, includesPath, cssFile)
      initRTE("/resources/acs-templating/rte/images/",
  "/resources/acs-templating/rte/", "");
      // --></script></if>
    <if @admin_p@><slave></if><else>You must be a site wide admin!</else>
  </body>
</html>