ad_page_contract {
    Confirm dropping of an index
} {
    index
    table
}


ad_form -name dropindex -form {
    {index:text(hidden)
	{value $index}}
    {table:text(hidden)
	{value $table}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
    
    db_dml drop_index "drop index \"$index\" $cascade2"
    
} -after_submit {
    ad_returnredirect "tableindex?table=$table"
    ad_script_abort
}