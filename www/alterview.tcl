ad_page_contract {
    Alter view definition
} {
    name
}

set definition [db_string get_definition "select definition from pg_views where viewname='$name'"]

ad_form -name alterview -form {
    {name:text
	{value $name}
	{mode "display"}
	{label "Name"}}
    {definition:text(textarea)
	{label "Definition"}
	{nospell}
	{value $definition}
	{html {rows 8 cols 50}}}  
} -on_submit {   
    db_dml alter_view "create or replace view $name as $definition;"        
} -after_submit {
        ad_returnredirect "views"
        ad_script_abort
}