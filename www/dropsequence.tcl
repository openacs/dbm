ad_page_contract {
    Confirm dropping of a sequence
} {
    relname:multiple
}

set sequencelist [dbm::format_list -name $relname]

ad_form -name dropsequence -form {
    {relname:text(hidden)
	{value $relname}
	{mode "display"}}
    {cascade:text(checkbox),optional
    	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
    foreach sequence $relname {
    db_dml drop_sequence "drop sequence $sequence $cascade2"
    }
} -after_submit {
    ad_returnredirect "showsequences"
    ad_script_abort
}
