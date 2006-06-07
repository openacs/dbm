ad_page_contract {
    
} {
    page:optional
    orderby:optional
}


set pagesize [parameter::get -parameter "PageSize"]

template::list::create \
    -name views \
    -multirow views \
    -key relname \
    -page_size $pagesize \
    -page_flush_p 0 \
    -page_query_name views_pagination \
    -actions [list "[_ dbm.createview]" createview "[_ dbm.createview]"] \
    -bulk_actions [list "[_ dbm.remove]" "dropview" "[_ dbm.remove_checked_views]"] \
    -elements {
	relname {
	            label "[_ dbm.view]"
	}
	nspname {
	            label "Schema"
	}
	usename {
	    label "[_ dbm.owner]"
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		<a href="viewproperties?view=@views.relname@" title="[_ dbm.properties]"><img src="/resources/dbm/images/b_props.png" border="0"></a> <a href="browseview?view=@views.relname@" title="[_ dbm.browse]"><img src="/resources/dbm/images/b_browse.png" border="0"></a> <a href="viewdefinition?view=@views.relname@" title="Definition"><img src="/resources/dbm/images/b_info.png" border="0"></a> <a href="showrules?table=@views.relname@" title="[_ dbm.rules]"><img src="/resources/dbm/images/b_rules.png" border="0"></a> <a href="viewprivileges?view=@views.relname@" title="[_ dbm.privileges]"><img src="/resources/dbm/images/s_rights.png" border="0"></a> <a href="alterview?name=@views.relname@" title="[_ dbm.edit]"><img src="/resources/dbm/images/Edit16.gif" border="0"></a> <a href="dropview?relname=@views.relname@" title="[_ dbm.dropview_1]"><img src="/resources/dbm/images/b_drop.png" border="0"></a>
	    }
	}
    } -orderby {
        relname {orderby relname}
	nspname {orderby nspname}
	usename {orderby usename}
	default_value relname,asc
    }


db_multirow views get_views {}
