ad_page_contract {
    Alter table
} {
    table
}

set users [db_list_of_lists get_users {}]

ad_form -name altertable -form {
    {table:text(hidden)
	{value $table}
    }
    {newtable:text
	{value $table}
	{label "Name"}
    }
    {user:text(select)
	{label "[_ dbm.owner]"}
	{options {$users}}
    } 
} -on_submit { 
      db_dml alter_table "alter table \"$table\" rename to \"$newtable\""
      db_dml alter_table2 "alter table \"$newtable\" owner to \"$user\""        
} -after_submit {
        ad_returnredirect "showtables"
        ad_script_abort
}