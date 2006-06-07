ad_page_contract {
    
} {
    page:optional
    orderby:optional
}

set pagesize [parameter::get -parameter "PageSize"]

template::list::create \
    -name sequences \
    -multirow sequences \
    -key relname \
    -page_size $pagesize \
    -page_flush_p 0 \
    -page_query_name sequences_pagination \
    -actions [list "[_ dbm.createsequence]" createsequence "[_ dbm.createsequence]"] \
    -bulk_actions [list "[_ dbm.remove]" "dropsequence" "[_ dbm.remove_checked_sequences]"] \
    -elements {
	relname {
	    label "[_ dbm.sequence]"
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
		<a href="sequenceproperties?sequence=@sequences.relname@" title="[_ dbm.properties]"><img src="/resources/dbm/images/b_props.png" border="0"></a> 
		<a href="resetsequence?sequence=@sequences.relname@" title="[_ dbm.resetsequence_1]"><img src="/resources/dbm/images/b_reset.png" border="0"></a>
                <a href="dropsequence?relname=@sequences.relname@" title="[_ dbm.dropsequence_1]"><img src="/resources/dbm/images/b_drop.png" border="0"</a> 
		<a href="sequenceprivileges?sequence=@sequences.relname@" title="[_ dbm.privileges]"><img src="/resources/dbm/images/s_rights.png" border="0"></a>
	    }
	}
    } -orderby {
        relname {orderby relname}
	nspname {orderby nspname}
	usename {orderby usename}
	default_value relname,asc
    }
    

db_multirow sequences get_sequences {}
