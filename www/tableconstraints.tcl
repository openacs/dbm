ad_page_contract {
    
} {
    table
    {msg ""}
}


template::list::create \
    -name constraints \
    -multirow constraints \
    -key conname \
    -actions [list "[_ dbm.addcheck]" [export_vars -base addtablecheck {table}] "[_ dbm.addcheck]" \
		  "[_ dbm.adduniquekey]" [export_vars -base adduniquekey {table}] "[_ dbm.adduniquekey]" \
		  "[_ dbm.addprimarykey]" [export_vars -base addprimarykey {table}] "[_ dbm.addprimarykey]" \
		  "[_ dbm.addforeignkey]" [export_vars -base addforeignkey {table}] "[_ dbm.addforeignkey]"] \
    -elements {
	conname {
	            label "Name"
	}
	consrc {
	            label "Definition"
	}
	indisclustered {
	            label "Clustered?"
	    display_template {
		<if @constraints.indisclustered@ eq "t">
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
		<if @constraints.indisclustered@ ne "">
		    <a href="clusterconstraint?constraint=@constraints.conname@&table=$table">Cluster</a> || <a href="reindexconstraint?constraint=@constraints.conname@&table=$table">Reindex </a> <a href="dropconstraint?constraint=@constraints.conname@&table=$table"><img src="/resources/dbm/images/b_drop.png" border="0"/></a>
		</if>
		<else>
		<a href="dropconstraint?constraint=@constraints.conname@&table=$table"><img src="/resources/dbm/images/b_drop.png" \
border="0"/></a>
		</else>
	    }
	}
    } 

db_multirow constraints get_constraints {}