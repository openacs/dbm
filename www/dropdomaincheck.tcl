ad_page_contract {
    Confirm dropping of a domain check
} {
    Name
    check
}


ad_form -name dropcheck -form {
    {Name:text(hidden)
	{mode "display"}
	{value $Name}}
    {check:text(hidden)
	{mode "display"}
	{value $check}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
  
    db_dml drop_check "alter domain $Name drop constraint $check $cascade2"
    
} -after_submit {
    ad_returnredirect "alterdomain?domain=$Name"
    ad_script_abort
}