ad_page_contract {
    Confirm dropping of a view
} {
    relname:multiple
}

set viewlist [dbm::format_list -name $relname]


ad_form -name dropview -form {
    {relname:text(hidden)
	{mode "display"}
	{value $relname}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
    foreach view $relname {
    db_dml drop_view "drop view \"$view\" $cascade2"
    }
} -after_submit {
    ad_returnredirect "views"
    ad_script_abort
}