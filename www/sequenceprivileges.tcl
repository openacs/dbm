ad_page_contract {
    Show sequence privileges
} {
    sequence
}

template::list::create \
    -name priv \
    -multirow priv \
    -key relacl \
    -actions [list "[_ dbm.alterprivileges]" [export_vars -base alterprivileges2 {sequence}] "[_ dbm.alterprivileges]"] \
    -elements {
        relacl {
            label "[_ dbm.Privileges]"
        }
    }

db_multirow priv get_privileges {}