ad_page_contract {
    Confirm dropping of a schema
} {
    nspname:multiple
}

set schemalist [dbm::format_list -name $nspname]

ad_form -name dropschema -form {
    {nspname:text(hidden)
	{mode "display"}
	{value $nspname}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
    foreach schema $nspname {
    db_dml drop_schema "drop schema $schema $cascade2"
    }
} -after_submit {
    ad_returnredirect "schemas"
    ad_script_abort
}