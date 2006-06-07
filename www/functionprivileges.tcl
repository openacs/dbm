ad_page_contract {
    Show function privileges
} {
    function
    args
    oid
}

template::list::create \
    -name priv \
    -multirow priv \
    -key proacl \
    -actions [list "[_ dbm.alterprivileges]" [export_vars -base alterprivileges2 {oid args function}] "[_ dbm.alterprivileges]"] \
    -elements {
        proacl {
            label "[_ dbm.Privileges]"
        }
    }

db_multirow priv get_privileges {}