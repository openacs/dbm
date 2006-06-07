ad_page_contract {
    Confirm dropping of a column
} {
    table
    column
}



ad_form -name dropcolumn -form {
    {table:text(hidden)
	{value $table}}
    {column:text(hidden)
	{value $column}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
   
    db_dml drop_column "alter table \"$table\" drop column \"$column\" $cascade2"
   
} -after_submit {
    ad_returnredirect "showtables"
    ad_script_abort
}