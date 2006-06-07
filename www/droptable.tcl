ad_page_contract {
    Confirm dropping of a table
} {
    table
}

ad_form -name droptable -form {
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
   
    db_dml drop_table "drop table \"$table\" $cascade2"
 
} -after_submit {
    ad_returnredirect "showtables"
    ad_script_abort
}