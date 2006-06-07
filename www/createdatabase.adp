<master src="lib/master">

<script type="text/javascript">
function changeframe (URI, framename) {
         parent[framename].location.href = URI;
}
</script>

<body onLoad="changeframe('browser', 'browser')">

<listtemplate name="database_information"></listtemplate>
   
<p> 

<formtemplate id="createdatabase"></formtemplate>
