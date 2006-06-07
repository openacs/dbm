ad_page_contract {
    Add a check
} {
    domain
}


ad_form -name addcheck -form {
    {domain:text(hidden)
	{mode "display"}
	{value $domain}}
    {checkname:text
	{label "Name"}}
    {definition:text
	{label "Definition"}
	{help_text "[_ dbm.enter]"}}  
} -on_submit {   
    db_dml add_check "alter domain $domain add constraint $checkname check($definition);"
} -after_submit {
    ad_returnredirect "alterdomain?domain=$domain"
    ad_script_abort
}