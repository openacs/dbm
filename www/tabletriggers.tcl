ad_page_contract {
    
} {
    table
}



template::list::create \
    -name triggers \
    -multirow triggers \
    -key tgname \
    -actions [list "[_ dbm.createtrigger]" [export_vars -base createtrigger {table}] "[_ dbm.createtrigger]"] \
    -elements {
	tgname {
	        label "Name"
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		   <a href="triggerdefinition?table=$table&trigger=@triggers.tgname@" title="Definition"><img src="/resources/dbm/images/b_info.png" border="0"></a> <a href="droptrigger?table=$table&trigger=@triggers.tgname@" title="[_ dbm.droptrigger_1]"><img src="/resources/dbm/images/b_drop.png" border="0"/></a>
	    }
	}
    } 

db_multirow triggers get_triggers {}
