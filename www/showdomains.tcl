ad_page_contract {
    
} {
    page:optional
    orderby:optional
}

set pagesize [parameter::get -parameter "PageSize"]

template::list::create \
    -name domains \
    -multirow domains \
    -key typname \
    -page_size $pagesize \
    -page_flush_p 0 \
    -page_query_name domains_pagination \
    -actions [list "[_ dbm.createdomain]" createdomain "[_ dbm.createdomain]"] \
    -bulk_actions [list "[_ dbm.remove]" "dropdomain" "[_ dbm.removedomains]"] \
    -elements {
	typname {
	    label "[_ dbm.domain]"
	}
	format_type {
	    label "[_ dbm.type]"
	}
	typnotnull {
	    label "Not Null"
	    display_template {
		<if @domains.typnotnull@ eq "t">
		<img src="/shared/images/checkboxchecked" height="13" width="13" border="0" style="background-color: white;">
                </if>
                <else>
		<img src="/shared/images/checkbox" height="13" width="13" border="0" style="background-color: white;">
                </else>
	    }
	}
	typdefault {
	    label "[_ dbm.default]"
	}
	nspname {
	    label "Schema"
	}
	pg_get_userbyid {
	    label "[_ dbm.owner]"
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		    <a href="alterdomain?domain=@domains.typname@" title="[_ dbm.editdomain]"><img src="/resources/dbm/images/Edit16.gif" border="0"/></a> <a href="dropdomain?typname=@domains.typname@" title="[_ dbm.dropdomain_1]"><img src="/resources/dbm/images/b_drop.png" border="0"/></a>
	    }
	}
    } -orderby {
	typname {orderby typname}
	nspname {orderby nspname}
	pg_get_userbyid {orderby pg_get_userbyid}
	default_value typname, asc
    }

db_multirow domains get_domains {}
