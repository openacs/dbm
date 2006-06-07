ad_page_contract {
    Alter function properties
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

set p1_opts [dbm::create_combo_opts -parameter Properties1]
set p2_opts [dbm::create_combo_opts -parameter Properties2 -split ";"] 
set p3_opts [dbm::create_combo_opts -parameter Properties3 -split ";"]

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

ad_form -name alterfunction -form {
    {function:text
	{value $function}
	{mode "display"}
	{label "[_ dbm.function]"}
    }
    {args:text(hidden)
	{value $args}
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
	{value $prosrc}
	{html {rows 15 cols 70}}
    }
    {provolatile:text(select),optional
	{value $provolatile}
	{options {$p1_opts}}
	{label ""}
	{section "[_ dbm.properties]"}
    }
    {proisstrict:text(select),optional
        {value $proisstrict}
        {options {$p2_opts}}
        {label ""}
        {section "[_ dbm.properties]"}
    }
    {prosecdef:text(select),optional
        {value $prosecdef}
        {options {$p3_opts}}
        {label ""}
        {section "[_ dbm.properties]"}
    }

} -on_submit {
    if {$proarguments != ""} {
	db_dml alter_function "create or replace function $function ($proarguments) returns $proresult as '$prosrc' language $prolanguage \n$provolatile \n$proisstrict \n$prosecdef;"
    } else {
	db_dml alter_function "create or replace function $function () returns $proresult as '$prosrc' language $prolanguage \n$provolatile \n$proisstrict \n$prosecdef;"
    }
} -after_submit {
    ad_returnredirect "showfunctions"
    ad_script_abort
}