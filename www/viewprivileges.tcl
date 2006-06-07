ad_page_contract {
    Show view privileges
} {
    view
}

template::list::create \
    -name priv \
    -multirow priv \
    -key relacl \
    -actions [list "[_ dbm.alterprivileges]" [export_vars -base alterprivileges2 {view}] "[_ dbm.alterprivileges]"] \
    -elements {
        relacl {
            label "[_ dbm.Privileges]"
        }
    }

db_multirow priv get_privileges {}