ad_page_contract {
    Browse a table
} {
    table
}

db_multirow tables browse_table {}

set elements [db_list_of_lists get_fields {}] 
# what we get: rel_id member_state 
# what we want: rel_id {label rel_id} member_state {label member_state}


foreach element $elements {
    set temp "{label $element}"
    append output [concat $element "$temp"] " "
}

append output "mycolumn { label \"[_ dbm.actions]\" \n display_template { <a href=\"editrow?table=$table&"

foreach element $elements {
    append output "$element=@tables.${element}@&"
}

append output "\" title=\"[_ dbm.edit]\"><img src=\"/resources/dbm/images/Edit16.gif\" border=\"0\"></a> <a href=\"deleterow?table=$table&"
foreach element $elements {
    append output "$element=@tables.${element}@&"
}

append output "\" title=\"[_ dbm.delete]\"><img src=\"/resources/dbm/images/b_drop.png\" border=\"0\"></a>}}"


template::list::create \
    -name browsed_table \
    -multirow tables \
    -elements $output


	