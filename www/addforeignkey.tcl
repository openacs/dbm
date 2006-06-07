ad_page_contract {
    Create foreign key
} {
    table
}

set columns [db_list_of_lists get_columns {}]
set tables [db_list_of_lists get_tables {}]

ad_form -name createforeignkey -form {
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
    {targettable:text(select)
	{label "[_ dbm.target]"}
	{options {$tables}}
    }
} -on_submit {
    ad_returnredirect "addforeignkey2?table=$table&name=$name&column=$column&targettable=$targettable"
   
}