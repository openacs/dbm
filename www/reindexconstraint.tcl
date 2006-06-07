ad_page_contract {
    Reindex
} {
   
    table
}

db_dml reindex "REINDEX TABLE \"$table\""
ad_returnredirect "tableconstraints?table=$table&msg=[_ dbm.reindex_complete]"
ad_script_abort