ad_form -name createtable -form {
    {name:text
	{label "Name"}
    }
    {amount:text
	{label "[_ dbm.numfields]"}
    }  
    {oids:text(checkbox),optional
	{label "[_ dbm.options]"}
	{options {{"WITHOUT OIDS" 1}}}} 
    } -on_submit {
	if {$oids == ""} {
      set oids "WITH OIDS"
	} else {
      set oids "WITHOUT OIDS"
	}
    ad_returnredirect "createtable2?name=$name&amount=$amount&oids=$oids"   
}