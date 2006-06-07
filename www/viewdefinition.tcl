ad_page_contract {
    Show view definition
} {
    view
}

db_multirow viewdefinition get_definition "select definition from pg_views where viewname='$view'" {
    set definition [dbm::highlight_sql -sql $definition]
}

template::list::create \
    -name view_definition \
    -multirow viewdefinition \
    -elements {
	definition {
	    label "Definition"
	    display_template {
		@viewdefinition.definition;noquote@
	    }
	}
    }
    
 