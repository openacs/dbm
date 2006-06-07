ad_page_contract {
    Confirm dropping of a database
} {
    database
}


ad_form -name dropdatabase -form {
    {database:text(hidden)
	{mode "display"}
	{value $database}}
} -on_submit {
     
    db_dml drop_database "drop database \"$database\""
    
} -after_submit {
    ad_returnredirect "createdatabase"
    ad_script_abort
}