ad_page_contract {
    Create foreign key
} {
    table
    name
    column
    targettable
}

set columns2 [db_list_of_lists get_columns2 {}]
set update_delete_opts [dbm::create_combo_opts -parameter update_delete -split ";"]
set match_opts [dbm::create_combo_opts -parameter match -split ";"]
set deferrable_opts [dbm::create_combo_opts -parameter deferrable -split ";"]
set initially_opts [dbm::create_combo_opts -parameter initially -split ";"]

ad_form -name createforeignkey2 -form {
    {name:text(hidden)
	{value $name}
    }  
    {table:text(hidden)
	{value $table}
    }
    {column:text(hidden)
	{value $column}
    }  
    {targettable:text(hidden)
	{value $targettable}
    }  
    {column2:text(multiselect),multiple
	{label "[_ dbm.columns2]"}
	{options {$columns2}}
    }
    {update:text(select)
	{label "On update"}
	{options {$update_delete_opts}}
    }
    {delete:text(select)
	{label "On delete"}
	{options {$update_delete_opts}}
    }
    {match:text(select)
	{label ""}
	{options {$match_opts}}
    }
    {deferrable:text(select)
	{label ""}
	{options {$deferrable_opts}}
    }
    {initially:text(select)
	{label ""}
	{options {$initially_opts}}
    }
    
} -on_submit {

    set output [list]
    set output2 [list]

    foreach el $column {
	lappend output [concat \"$el\"]
    }
    
    foreach el $column2 {
	lappend output2 [concat \"$el\"]
    }

    set columnslist [dbm::format_list -name $output]
    set columnslist2 [dbm::format_list -name $output2]
    
    db_dml create_foreignkey "alter table \"$table\" add constraint \"$name\" foreign key ($columnslist) references \"$targettable\" ($columnslist2) $match on update $update on delete $delete $deferrable $initially"
    
 
    ad_returnredirect "tableconstraints?table=$table"
   
}