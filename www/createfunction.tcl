
set p1_opts [dbm::create_combo_opts -parameter Properties1]
set p2_opts [dbm::create_combo_opts -parameter Properties2 -split ";"] 
set p3_opts [dbm::create_combo_opts -parameter Properties3 -split ";"]
set r1_opts [dbm::create_combo_opts -parameter Returns1]
set lang_opts [dbm::create_combo_opts -parameter ProgrammingLanguages]
set r2_opts [db_list_of_lists get_returns {}]

ad_form -name createfunction -form {
    {name:text
	{label "Name"}
	{float "left"}
	{text_align "center"}
	{section "[_ dbm.general]"}
    }
    {arguments:text,optional
	{label "[_ dbm.arguments]"}
	{float "left"}
	{text_align "center"}
	{section "[_ dbm.general]"}
    }
    {return1:text(select),optional
	{options {$r1_opts}}
	{section "[_ dbm.returns]"}
	{label ""}
	{float "left"}
    }
    {return2:text(select)
	{options {$r2_opts}}
	{section "[_ dbm.returns]"}
	{label ""}
	{float "left"}
    }
    {language:text(select)
	{options {$lang_opts}}
	{float "left"}
	{section "[_ dbm.prolang]"}
	{label ""}
    }
    {definition:text(textarea)
	{label ""}
	{nospell}
	{section "Definition"}
	{html {rows 15 cols 70}}
    }
    {propertie1:text(select),optional
	{options {$p1_opts}}
	{section "[_ dbm.properties]"}
	{label ""}
    }
    {propertie2:text(select),optional
        {options {$p2_opts}}
        {section "[_ dbm.properties]"}
	{label ""}
    }
    {propertie3:text(select),optional
	{options {$p3_opts}}
	{section "[_ dbm.properties]"}
	{label ""}
	{help_text "[_ dbm.createfunction]"}
    }
    
} -on_submit {
    if {$arguments != ""} {
	db_dml create_function "create function $name ($arguments) returns $return1 $return2 as '$definition' language $language \n$propertie1 \n$propertie2 \n$propertie3;"
    } else {
	db_dml create_function "create function $name () returns $return1 $return2 as '$definition' language $language \n$propertie1 \n$propertie2 \n$propertie3;"
    }
} -after_submit {
    ad_returnredirect "showfunctions"
    ad_script_abort
}