ad_page_contract {
    Cluster
} {
    table
    constraint
}

db_dml cluster "cluster $constraint on $table"

ad_returnredirect "tableconstraints?table=$table&msg=[_ dbm.clustercomplete]"
ad_script_abort