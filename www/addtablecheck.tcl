ad_page_contract {
    Add a check
} {
    table
}


ad_form -name addcheck -form {
    {table:text(hidden)
	{value $table}}
    {checkname:text
	{label "Name"}}
    {definition:text
	{label "Definition(...)"}
	{help_text "[_ dbm.enter]"}}  
} -on_submit {   
    db_dml add_check "alter table \"$table\" add constraint \"$checkname\" check($definition);"
} -after_submit {
    ad_returnredirect "tableconstraints?table=$table"
    ad_script_abort
}