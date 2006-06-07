
template::list::create \
    -name priv \
    -multirow priv \
    -key datacl \
    -actions [list "[_ dbm.alterprivileges]" alterprivileges2?database=oacs-5-2 "[_ dbm.alterprivileges]"] \
    -elements {
	datacl {
	    label "[_ dbm.Privileges]"
	}
    }

db_multirow priv get_privileges {}