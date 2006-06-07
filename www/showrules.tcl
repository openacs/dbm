ad_page_contract {
    Show rules
} {
    table
}


db_multirow rules get_rules {}

template::list::create \
    -name rules \
    -multirow rules \
    -key rulename \
    -actions [list "[_ dbm.createrule]" [export_vars -base createrule {table}] "[_ dbm.createrule]"] \
    -elements {
	rulename {
	        label "Name"
	}
	definition {
	        label "Definition"
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		    <a href="droprule?tablename=$table&rulename=@rules.rulename@" title="[_ dbm.droprule_1]"><img src="/resources/dbm/images/b_drop.png" border="0"/></a>
	    }
	}
    }