ad_page_contract {
    Confirm dropping of a constraint
} {
    constraint
    table
}


ad_form -name dropconstraint -form {
    {constraint:text(hidden)
	{value $constraint}}
    {table:text(hidden)
	{value $table}}  
    {cascade:text(checkbox),optional
	{label "CASCADE"}
	{options {{[_ dbm.yes] 1}}}}
} -on_submit {
    if {$cascade == ""} {
	set cascade2 "RESTRICT"
    } else {
	set cascade2 "CASCADE"
    }
    
    db_dml drop_constraint "alter table \"$table\" drop constraint \"$constraint\" $cascade2"
  
} -after_submit {
    ad_returnredirect "tableconstraints?table=$table"
    ad_script_abort
}