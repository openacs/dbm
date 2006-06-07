ad_page_contract {
    Show sequence properties
} {
    sequence
}

db_multirow properties browse_sequence {}

set elements [db_list_of_lists get_fields {}] 
# what we get: rel_id member_state 
# what we want: rel_id {label rel_id} member_state {label member_state}


foreach element $elements {
    set temp "{label $element}"
    append output [concat $element "$temp"] " "
}


template::list::create \
    -name sequence_properties \
    -multirow properties \
    -elements $output