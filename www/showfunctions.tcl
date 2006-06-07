ad_page_contract {
    
} {
    page:optional
    orderby:optional
}

set pagesize [parameter::get -parameter "PageSize"]


template::list::create \
    -name functions \
    -multirow functions \
    -key proname \
    -page_size $pagesize \
    -page_flush_p 0 \
    -page_query_name functions_pagination \
    -actions [list "[_ dbm.createfunction]" createfunction "[_ dbm.createfunction]"] \
    -elements {
	proname {
	    label "[_ dbm.function]"
	}
	typname {
	    label "[_ dbm.returns]"
	}
	oidvectortypes {
	    label "[_ dbm.arguments]"
	    display_template {
		<div style="font-size:x-small;width:200px">@functions.oidvectortypes;noquote@</div>
	    }	
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		<a href="functionproperties?function=@functions.proname@&args=@functions.oidvectortypes@" title="[_ dbm.properties]"><img src="/resources/dbm/images/b_props.png" border="0"></a> <a href="alterfunction?function=@functions.proname@&args=@functions.oidvectortypes@" title="[_ dbm.editfunction]"><img src="/resources/dbm/images/Edit16.gif" border="0"/></a> <a href="dropfunction?proname=@functions.proname@&args=@functions.oidvectortypes@" title="[_ dbm.dropfunction_1]"><img src="/resources/dbm/images/b_drop.png" border="0"></a> <a href="functionprivileges?function=@functions.proname@&args=@functions.oidvectortypes@&oid=@functions.oid@" title="[_ dbm.privileges]"><img src="/resources/dbm/images/s_rights.png" border="0"></a>
	    }
	}
    } -orderby {
	proname {orderby proname}
	default_value proname,asc
    }

db_multirow functions get_functions {}
