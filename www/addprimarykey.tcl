ad_page_contract {
    Create primary key
} {
    table
}

set columns [db_list_of_lists get_columns {}]

ad_form -name createprimarykey -form {
    {name:text
	{label "Name"}
    }
    {table:text(hidden)
	{value $table}
    }
    {column:text(multiselect),multiple
	{label "[_ dbm.columns]"}
	{options {$columns}}
    }
} -on_submit {
     
    set output {}

    foreach el $column {
	lappend output [concat \"$el\"]
    }

    set columnslist [dbm::format_list -name $output]

      db_dml create_primarykey "alter table \"$table\" add constraint \"$name\" primary key ($columnslist)"
  

    ad_returnredirect "tableconstraints?table=$table"
    ad_script_abort
}