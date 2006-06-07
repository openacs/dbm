ad_page_contract {
    
} {
    page:optional
    orderby:optional
}

set pagesize [parameter::get -parameter "PageSize"]

set graphVizP [dbm::graphVizP]

template::list::create \
    -name tables \
    -pass_properties {graphVizP} \
    -multirow tables \
    -key tablename \
    -page_size $pagesize \
    -page_flush_p 0 \
    -page_query_name tables_pagination \
    -actions [list "[_ dbm.createtable]" createtable "[_ dbm.createtable]"] \
    -elements {
	tablename {
	        label "[_ dbm.table]"
	}
	tableowner {
	        label "[_ dbm.owner]"
	}
	schemaname {
	        label "Schema"
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		<a href="tableproperties?table=@tables.tablename@" title="[_ dbm.properties]"><img src="/resources/dbm/images/b_props.png" border="0"></a> <a href="browsetable?table=@tables.tablename@" title="[_ dbm.browse]"><img src="/resources/dbm/images/b_browse.png" border="0"></a> <if @graphVizP@><a href="graph?table=@tables.tablename@" title="Graph"><img src="/resources/dbm/images/b_view.png" border="0"></a> </if><a href="insertrows?table=@tables.tablename@" title="[_ dbm.insert]"><img src="/resources/dbm/images/b_insrow.png" border="0"></a> <a href="addcolumn?table=@tables.tablename@" title="[_ dbm.add_column]"><img src="/resources/dbm/images/b_addcolumn.png" border="0"></a> <a href="tableindex?table=@tables.tablename@" title="[_ dbm.indexes]"><img src="/resources/dbm/images/b_index.png" border="0"></a> <a href="tableconstraints?table=@tables.tablename@" title="Constraints"><img src="/resources/dbm/images/b_constraints.png" border="0"></a> <a href="tabletriggers?table=@tables.tablename@" title="[_ dbm.triggers]"><img src="/resources/dbm/images/b_triggers.png" border="0"></a> <a href="showrules?table=@tables.tablename@" title="[_ dbm.rules]"><img src="/resources/dbm/images/b_rules.png" border="0"></a> <a href="tableprivileges?table=@tables.tablename@" title="[_ dbm.privileges]"><img src="/resources/dbm/images/s_rights.png" border="0"></a> <a href="tableimport?table=@tables.tablename@" title="Import"><img src="/resources/dbm/images/b_tblimport.png" border="0"></a> <a href="tableexport?table=@tables.tablename@" title="Export"><img src="/resources/dbm/images/b_tblexport.png" border="0"></a> <a href="altertable?table=@tables.tablename@" title="[_ dbm.edit]"><img src="/resources/dbm/images/Edit16.gif" border="0"></a> <a href="emptytable?table=@tables.tablename@" title="[_ dbm.empty]"><img src="/resources/dbm/images/b_empty.png" border="0"></a> <a href="droptable?table=@tables.tablename@" title="[_ dbm.remove]"><img src="/resources/dbm/images/b_drop.png" border="0"></a> 
	    }
	}
    } -orderby {
	tablename {orderby tablename}
	tableowner {orderby tableowner}
	schemaname {orderby schemaname}
	default_value tablename,asc
    }


db_multirow tables get_tablename {}
