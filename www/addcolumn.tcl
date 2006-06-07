ad_page_contract {
    Add a column
} {
    table
}


set type_opts1 [db_list_of_lists get_types {}]
set type_opts2 [db_list_of_lists get_domains {}]
set type_opts [concat $type_opts1 $type_opts2]

ad_form -name addcolumn -form {
    {table:text(hidden)
	{value $table}}  
    {name:text
	{label "[_ dbm.field]"}
	{float "left"}
	{section "[_ dbm.field]"}
	{text_align "left"}}
    {type:text(select)
	{options {$type_opts}}
	{float "left"}
	{label ""}
	{text_align "center"}
	{section "[_ dbm.type]"}}
    {array:text(checkbox),optional
	{label ""}
	{float "left"}
	{section "[_ dbm.type]"}
	{options {{"Array" 1}}}}
    {length:text,optional
	{float "left"}
	{section "[_ dbm.length]"}
	{help_text "[_ dbm.add_column]"}
	{label "[_ dbm.length]"}}
} -on_submit {
   
    if {$array != ""} {
	set array "[]"
    }
    if {$length == ""} {
	db_dml add_column "ALTER TABLE \"$table\" ADD COLUMN \"$name\" $type$array"
    } else {
	db_dml add_column "ALTER TABLE \"$table\" ADD COLUMN \"$name\" $type($length)$array"
    }
} -after_submit {
    ad_returnredirect "showtables"
    ad_script_abort
}