ad_page_contract {
    Create Sequence
} {
    {name ""}
 
}

ad_form -name createsequence -form {
    {name:text
	{label "Name"}}
    {increment:text,optional
	{label "[_ dbm.increment_by]"}}
    {min:text
	{label "[_ dbm.minvalue]"}}
    {max:text
	{label "[_ dbm.maxvalue]"}}
    {start:text,optional
	{label "[_ dbm.startvalue]"}}
    {cache:text,optional
	{label "[_ dbm.cachevalue]"}}
    {cycle:text(checkbox),optional
	{label "[_ dbm.iscycle]"}
	{options {{[_ dbm.yes] 1}}}}
} -validate {
    {name
	{[string length $name] >= 1}
         "\"Name\" must be a string containing 1 character"
    }
} -on_submit {
    if {$increment == ""} {
	set increment2 "INCREMENT 1"
    } else {
	set increment2 "INCREMENT $increment"
    }
    if {$start < 0} {
	set start2 "START $max"
    } else {
	set start2 "START $min"
    }
    if {$cache == ""} {
	set cache2 "CACHE 1"
    } else {
	set cache2 "CACHE $cache"
    }
    if {$cycle == ""} {
      set cycle2 "NO CYCLE"
    } else {
      set cycle2 "CYCLE"
    }
      db_dml create_sequence "create sequence $name $increment2 minvalue $min maxvalue $max $start2 $cache2 $cycle2"
} -after_submit {
    ad_returnredirect "showsequences"
    ad_script_abort
}
