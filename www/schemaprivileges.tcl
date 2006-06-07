ad_page_contract {
    Show schema privileges
} {
    schema
}

template::list::create \
    -name priv \
    -multirow priv \
    -key nspacl \
    -actions [list "[_ dbm.alterprivileges]" [export_vars -base alterprivileges2 {schema}] "[_ dbm.alterprivileges]"] \
    -elements {
        nspacl {
            label "[_ dbm.Privileges]"
        }
    }

db_multirow priv get_privileges {}