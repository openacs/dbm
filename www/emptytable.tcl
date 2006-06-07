ad_page_contract {
    Confirm emptying of a table
} {
    table
}

ad_form -name emptytable -form {
    {table:text(hidden)
	{value $table}}
} -on_submit {
    db_dml empty_table "delete from \"$table\""
} -after_submit {
    ad_returnredirect "showtables"
    ad_script_abort
}