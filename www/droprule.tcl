ad_page_contract {
    Confirm dropping of a rule
} {
    rulename
    tablename
}


ad_form -name droprule -form {
    {rulename:text(hidden)
	{mode "display"}
	{value $rulename}}
    {tablename:text(hidden)
	{mode "display"}
	{value $tablename}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
  
    db_dml drop_rule "drop rule $rulename on $tablename $cascade2"
    
} -after_submit {
    ad_returnredirect "showrules?table=$tablename"
    ad_script_abort
}