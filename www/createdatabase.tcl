ad_page_contract {
    Create Database
} {
    {name ""}
    {encoding_type ""}
 
}

db_multirow databases get_information {}

template::list::create \
    -name database_information \
    -multirow databases \
    -key Name \
    -elements {
	Name {
	    label "[_ dbm.database]"
	}
	Owner {
	    label "[_ dbm.owner]"
	}
	Encoding {
	    label "[_ dbm.encoding]"
	}
	mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		    <a href="dropdatabase?database=@databases.Name@" title="[_ dbm.dropdatabase_1]"><img src="/resources/dbm/images/b_drop.png" border="0"></a>
	    }
	}
    }

set encoding_opts [dbm::create_combo_opts -parameter EncodingTypes]    

ad_form -name createdatabase -form {
    {name:text
	{label "Name"}}
    {encoding_type:text(select),optional
	{label "[_ dbm.encoding]"}
	{options {$encoding_opts}}}
} -validate {
    {name
	{[string length $name] >= 1}
         "\"Name\" must be a string containing 1 character"
    }
} -on_submit {
    if {$encoding_type == ""} {
	db_dml create_database "create database $name"
    } else {
	db_dml create_database "create database $name with encoding=:encoding_type"
    }
} -after_submit {
        ad_returnredirect "createdatabase"
        ad_script_abort
}


