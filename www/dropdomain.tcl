ad_page_contract {
    Confirm dropping of a domain
} {
    typname:multiple
}

set domainlist [dbm::format_list -name $typname]

ad_form -name dropdomain -form {
    {typname:text(hidden)
	{mode "display"}
	{value $typname}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
    foreach domain $typname {
    db_dml drop_domain "drop domain $domain $cascade2"
    }
} -after_submit {
    ad_returnredirect "showdomains"
    ad_script_abort
}