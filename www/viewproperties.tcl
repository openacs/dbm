ad_page_contract {
    Display view properties
} {
    view
}

db_multirow properties get_properties {}

template::list::create \
    -name view_properties \
    -multirow properties \
    -elements {
	field {
	    label "[_ dbm.field]"
        }
        type {
	    label "[_ dbm.type]"
        }
        has_default {
	    label "[_ dbm.default]"
        }
    }