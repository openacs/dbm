ad_page_contract {
    Browse a view
} {
    {view ""}
    page:optional
    orderby:optional
} 

if {[empty_string_p $view]} {
    set view [ad_get_client_property dbm view]
} else {
  ad_set_client_property dbm view $view
}

set pagesize [parameter::get -parameter "PageSize"]
set elements [db_list_of_lists get_fields {}]

set column [lindex $elements 0]


foreach element $elements {
    set temp "{label $element}"
    append output [concat $element "$temp"] " "
}

template::list::create \
    -name views \
    -multirow views \
    -key $column \
    -page_size $pagesize \
    -page_flush_p 0 \
    -page_query_name views_pagination \
    -elements $output


db_multirow views browse_view {}
