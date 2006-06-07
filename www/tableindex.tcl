ad_page_contract {
    
} {
    table
    {msg ""}
}


template::list::create \
    -name indexes \
    -multirow indexes \
    -key relname \
    -actions [list "[_ dbm.createindex]" [export_vars -base createindex {table}] "[_ dbm.createindex]"] \
    -elements {
	relname {
	        label "Name"
	}
	pg_get_indexdef {
	        label "Definition"
	}
	indisclustered {
	        label "Clustered?"
	    display_template {
		<if @indexes.indisclustered@ eq "t">
		<img src="/shared/images/checkboxchecked" height="13" width="13" border="0" style="background-color: white;">
                </if>
                <else>
		<img src="/shared/images/checkbox" height="13" width="13" border="0" style="background-color: white;">
                </else>
	    }
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		    <a href="clusterindex?index=@indexes.relname@&table=$table">Cluster</a> || <a href="reindexindex?index=@indexes.relname@&table=$table">Reindex </a> <a href="dropindex?index=@indexes.relname@&table=$table"><img src="/resources/dbm/images/b_drop.png" border="0"/></a>
	    }
	}
    } 

db_multirow indexes get_indexes {}
