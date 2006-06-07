ad_page_contract {
    Confirm dropping of a trigger
} {
    table
    trigger
}



ad_form -name droptrigger -form {
    {table:text
	{mode "display"}
	{value $table}}
    {trigger:text
	{mode "display"}
	{value $trigger}}
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }

    db_dml drop_trigger "drop trigger $trigger on $table $cascade2"

} -after_submit {
    ad_returnredirect "tabletriggers?table=$table"
    ad_script_abort
}