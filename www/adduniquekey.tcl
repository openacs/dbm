ad_page_contract {
    Create unique key
} {
    table
}

set columns [db_list_of_lists get_columns {}]

ad_form -name createuniquekey -form {
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
     
    set output [list]

    foreach el $column {
	lappend output [concat \"$el\"]
    }

    set columnslist [dbm::format_list -name $output]

      db_dml create_uniquekey "alter table \"$table\" add constraint \"$name\" unique ($columnslist)"
  

    ad_returnredirect "tableconstraints?table=$table"
    ad_script_abort
}