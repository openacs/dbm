ad_page_contract {
    Display domain checks
} {
    domain
}


db_multirow checks get_checks {}

template::list::create \
    -name check \
    -multirow checks \
    -key conname \
    -actions [list "[_ dbm.adddomaincheck]" [export_vars -base adddomaincheck {domain}] "[_ dbm.adddomaincheck]"] \
    -elements {
    conname {
	    label "Name"
    }
    consrc {
	    label "Definition"
    }
    mycolumn {
	    label "[_ dbm.actions]"
	display_template {
	        <a href="dropdomaincheck?Name=$domain&check=@checks.conname@" title="[_ dbm.dropdomaincheck_1]"><img src="/resources/dbm/images/b_drop.png" border="0"/></a>
	}
    }
    }