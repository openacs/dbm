
set users [db_list_of_lists get_users {}]


ad_form -name createschema -form {
    {name:text
	{label "Name"}
    }
    {user:text(select),optional
        {label "[_ dbm.owner]"}
        {options {$users}}
    }
} -on_submit {
    if {$user != ""} {
	db_dml create_schema "create schema $name authorization \"$user\""
    } else {
	db_dml create_schema "create schema $name"
    }
    ad_returnredirect "schemas"
    ad_script_abort
}