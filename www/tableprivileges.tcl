ad_page_contract {
    Show table privileges
} {
    table
}

template::list::create \
    -name priv \
    -multirow priv \
    -key relacl \
    -actions [list "[_ dbm.alterprivileges]" [export_vars -base alterprivileges2 {table}] "[_ dbm.alterprivileges]"] \
    -elements {
        relacl {
            label "[_ dbm.Privileges]"
        }
    }

db_multirow priv get_privileges {}