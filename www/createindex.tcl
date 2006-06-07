ad_page_contract {
    Create index
} {
    table
}

set method_opts [dbm::create_combo_opts -parameter methods]

set columns [db_list_of_lists get_columns {}]

ad_form -name createindex -form {
    {name:text
	{label "Name"}
    }
    {table:text(hidden)
	{value $table}
    }
    {column:text(multiselect),multiple
	{label "[_ dbm.columnsinindex]"}
	{options {$columns}}
    }
    {method:text(select)
	{options {$method_opts}}
	{label "[_ dbm.typeofindex]"}
    }
    {unique:text(checkbox),optional
	{label ""}
	{options {{"Unique" 1}}}
    }
    {where:text,optional
	{label "Where(...)"}
	{help_text "[_ dbm.enter]"}
    }
} -on_submit {
    if {$unique != ""} {
	set unique "UNIQUE"
    }
    
    set output [list]

    foreach el $column {
	lappend output [concat \"$el\"]
    }

    set columnslist [dbm::format_list -name $output]

    if {$where != ""} {
	db_dml create_index "create $unique index \"$name\" on \"$table\" using $method ($columnslist) where ($where)"
    } else {
	db_dml create_index "create $unique index \"$name\" on \"$table\" using $method ($columnslist)"
    }

    ad_returnredirect "tableindex?table=$table"
    ad_script_abort
}