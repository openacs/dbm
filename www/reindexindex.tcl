ad_page_contract {
    Reindex an index
} {
    index
    table
}

db_dml reindex "REINDEX INDEX \"$index\""
ad_returnredirect "tableindex?table=$table&msg=[_ dbm.reindex_complete]"
ad_script_abort