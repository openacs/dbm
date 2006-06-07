ad_page_contract {
    Confirm dropping of a function
} {
    proname
    args
}


ad_form -name dropfunction -form {
    {proname:text(hidden)
	{mode "display"}
	{value $proname}}
    {args:text(hidden)
	{mode "display"}
	{value $args}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
   
    db_dml drop_function "drop function $proname ( $args ) $cascade2"
    
} -after_submit {
    ad_returnredirect "showfunctions"
    ad_script_abort
}