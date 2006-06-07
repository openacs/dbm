ad_page_contract {
    Cluster an index
} {
    index
    table
}

db_dml cluster_index "cluster \"$index\" on \"$table\""

ad_returnredirect "tableindex?table=$table&msg=[_ dbm.clustercomplete]"
ad_script_abort