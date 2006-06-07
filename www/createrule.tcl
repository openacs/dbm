ad_page_contract {
    Create a rule
} {
    table
}

set event_opts [dbm::create_combo_opts -parameter RuleEvent]

ad_form -name createrule -form {
    {table:text(hidden)
	{mode "display"}
	{value $table}
    }
    {name:text
	{label "Name"}
    }
    {event:text(select)
	{options {$event_opts}}
	{label "[_ dbm.event]"}
    }
    {where:text,optional
	{label "Where"}
	{html {size 50}}
    }
    {instead:text(checkbox),optional
	{label "Do Instead"}
	{options {{"" 1}}}
    }
    {action:text
	{label "[_ dbm.action]"}
	{html {size 50}}
    }
} -on_submit {
    if {$where != ""} {
       set where "WHERE $where"
    }
    if {$instead != ""} {
       set instead "INSTEAD"
    } 
    db_dml create_rule "create rule $name as on $event to $table $where do $instead $action"

} -after_submit {
    ad_returnredirect "showrules?table=$table"
    ad_script_abort
}