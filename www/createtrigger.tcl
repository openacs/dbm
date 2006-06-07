ad_page_contract {
    Create a trigger
} {
    table
}

set functions_opts [db_list_of_lists get_functions {}]
set when_opts [dbm::create_combo_opts -parameter when]
set event_opts [dbm::create_combo_opts -parameter event -split ","]

ad_form -name createtrigger -form {
    {name:text
	{label "Name"}}
    {table:text(hidden)
	{value $table}}
    {when:text(select)
	{options {$when_opts}}
	{label "[_ dbm.when]"}}
    {event:text(select)
	{options {$event_opts}}
	{label "[_ dbm.event]"}}
    {function:text(select)
	{options {$functions_opts}}
	{label "[_ dbm.function]"}}
    {row:text(checkbox),optional
	{label "[_ dbm.for_each_row]"}
	{options {{"[_ dbm.yes]" 1}}}}
    {args:text,optional
	{help_text "[_ dbm.enter]"}
	{label "[_ dbm.arguments](...)"}}
} -on_submit {
    if {$row == ""} {
      set row "STATEMENT"
    } else {
      set row "ROW"
    }
    
    db_dml create_trigger "create trigger $name $when $event on $table for each $row execute procedure \"$function\" ($args)"

} -after_submit {
    ad_returnredirect "tabletriggers?table=$table"
    ad_script_abort
}