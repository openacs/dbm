ad_form -name vacuum -form {
    {analyze:text(checkbox),optional
	{label ""}
	{options {{"Analyze" 1}}}}
    {full:text(checkbox),optional
	{label ""}
	{options {{"Full" 1}}}}
    {freeze:text(checkbox),optional
        {label ""}
        {options {{"Freeze" 1}}}}

} -on_submit {
    if {$analyze != ""} {
	set analyze "ANALYZE"
    }
    if {$full != ""} {
	set full "FULL"
    }
    if {$freeze != ""} {
	set freeze "FREEZE"
    }
    db_dml vacuum "VACUUM $full $freeze $analyze"
} -after_submit {
    ad_returnredirect "admin?msg=[_ dbm.vacuum_complete]"
    ad_script_abort
}
