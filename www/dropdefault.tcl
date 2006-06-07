ad_page_contract {
    Drop default
} {
    table
    column
}

db_dml alter_column "alter table \"$table\" alter column \"$column\" DROP DEFAULT"
   
ad_returnredirect "showtables"
ad_script_abort