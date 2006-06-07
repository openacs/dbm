template::list::create \
    -name schemas \
    -multirow schemas \
    -key nspname \
    -actions [list "[_ dbm.createschema]" createschema "[_ dbm.createschema]"] \
    -bulk_actions [list "[_ dbm.remove]" "dropschema" "[_ dbm.remove_checked_schemas]"] \
    -elements {
	nspname {
	    label "Schema"
	}
	usename {
	    label "[_ dbm.owner]"
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		<a href="dropschema?nspname=@schemas.nspname@" title="[_ dbm.dropschema_1]"><img src="/resources/dbm/images/b_drop.png" border="0"/></a> <a href="schemaprivileges?schema=@schemas.nspname@" title="[_ dbm.Privileges]"><img src="/resources/dbm/images/s_rights.png" border="0"></a>
	    }
	}
    }

db_multirow schemas get_schemas {}