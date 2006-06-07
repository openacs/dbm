ad_page_contract {
    Show function properties
} {
    function
    args
}


set prosrc [db_string get_definition "select prosrc from pg_proc where proname='$function' and oidvectortypes(proargtypes)='$args'"]
set proarguments $args
set proresult [db_string get_result "select pt.typname from pg_type pt, pg_proc pc where proname = '$function' and pc.prorettype = pt.oid and oidvectortypes(proargtypes)='$args'"]
set prolanguage [db_string get_lang "select lanname from pg_proc pc, pg_language pl where proname = '$function' and pc.prolang = pl.oid and oidvectortypes(proargtypes)='$args'"]
set provolatile [db_string get_prop1 "select provolatile from pg_proc where proname='$function' and oidvectortypes(proargtypes)='$args'"]
set proisstrict [db_string get_prop2 "select proisstrict from pg_proc where proname='$function' and oidvectortypes(proargtypes)='$args'"]
set prosecdef [db_string get_prop3 "select prosecdef from pg_proc where proname='$function' and oidvectortypes(proargtypes)='$args'"]

if {$provolatile == "v"} {
    set provolatile "VOLATILE"
} elseif {$provolatile == "i"} {
    set provolatile "IMMUTABLE"
} elseif {$provolatile == "s"} {
    set provolatile "STABLE"
} else {
    set provolatile "Error"
}

if {$proisstrict == "t"} {
    set proisstrict "RETURNS NULL ON NULL INPUT"
} else {
    set proisstrict "CALLED ON NULL INPUT"
}

if {$prosecdef == "t"} {
    set prosecdef "SECURITY DEFINER"
} else {
    set prosecdef "SECURITY INVOKER"
}

ad_form -name displayfunction -form {
    {function:text
	{value $function}
	{mode "display"}
	{label "[_ dbm.function]"}
    }
    {proarguments:text
	{label "[_ dbm.arguments]"}
	{mode "display"}
	{value $proarguments}
    }
    {proresult:text
	{value $proresult}
	{mode "display"}
	{label "[_ dbm.returns]"}
    }
    
    {prolanguage:text
	{value $prolanguage}
	{mode "display"}
	{label "[_ dbm.prolang]"}
    }
    {prosrc:text(textarea)
	{label ""}
	{nospell}
	{section "Definition"}
	{mode "display"}
	{value $prosrc}
	{html {rows 15 cols 70}}
    }
    {provolatile:text
	{value $provolatile}
	{mode "display"}
	{label ""}
	{section "[_ dbm.properties]"}
    }
    {proisstrict:text
        {value $proisstrict}
        {mode "display"}
        {label ""}
        {section "[_ dbm.properties]"}
    }
    {prosecdef:text
        {value $prosecdef}
        {mode "display"}
        {label ""}
        {section "[_ dbm.properties]"}
    }

} -has_submit { 
    1
}
	