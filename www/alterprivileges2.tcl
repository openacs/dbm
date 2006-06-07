ad_page_contract {
    Alter privileges
} {
    {function ""}
    {args ""}
    {oid ""}
    {schema ""}
    {sequence ""}
    {table ""}
    {view ""}
    {database ""}
}

set users [db_list_of_lists get_users {}]
set groups [db_list_of_lists get_groups {}]

if {$function != ""} {
    set opts "{\"EXECUTE\" \"EXECUTE\"}"
    set returnurl "functionprivileges?function=$function&args=$args&oid=$oid"
}

if {$schema != ""} {
    set opts "{\"CREATE\" \"CREATE\"} {\"USAGE\" \"USAGE\"}"
    set returnurl "schemaprivileges?schema=$schema"
}

if {$sequence != ""} {
    set opts "{\"SELECT\" \"SELECT\"} {\"UPDATE\" \"UPDATE\"}"
    set returnurl "sequenceprivileges?sequence=$sequence"
}

if {$table != ""} {
    set opts "{\"SELECT\" \"SELECT\"} {\"INSERT\" \"INSERT\"} {\"UPDATE\" \"UPDATE\"} {\"DELETE\" \"DELETE\"} {\"RULE\" \"RULE\"} {\"REFERENCES\" \"REFERENCES\"} {\"TRIGGER\" \"TRIGGER\"}"
    set returnurl "tableprivileges?table=$table"
}

if {$view != ""} {
    set opts "{\"SELECT\" \"SELECT\"} {\"RULE\" \"RULE\"}"
    set returnurl "viewprivileges?view=$view"
}

if {$database != ""} {
    set opts "{\"CREATE\" \"CREATE\"} {\"TEMPORARY\" \"TEMPORARY\"}"
    set returnurl "privileges"
}

    ad_form -name alterprivileges -form {
	{function:text(hidden)
	    {value $function}
	}
	{args:text(hidden)
	    {value $args}
	}
	{oid:text(hidden)
	    {value $oid}
	}
        {schema:text(hidden)
	    {value $schema}
	}
	{sequence:text(hidden)
	    {value $sequence}
	}
	{table:text(hidden)
	    {value $table}
	}
	{view:text(hidden)
	    {value $view}
	}
	{database:text(hidden)
	    {value $database}
	}
	{user:text(multiselect),multiple,optional
	    {label ""}
	    {options {$users}}
	    {section "[_ dbm.users]"}
	}
	{public:text(checkbox),optional
	    {label ""}
	    {section "[_ dbm.groups]"}
	    {options {{"PUBLIC" 1}}}
	}
	{group:text(multiselect),multiple,optional
	    {label ""}
	    {options {$groups}}
	    {section "[_ dbm.groups]"}
	}
	{privs:text(checkbox),multiple
	    {label ""}
	    {section "[_ dbm.privileges]"}
	    {options $opts}
	}
	{grant:text(checkbox),optional
	    {label ""}
	    {section "[_ dbm.options]"}
	    {options {{"GRANT OPTION" 1}}}
	}
	{cascade:text(checkbox),optional
	    {label ""}
	    {section "[_ dbm.options]"}
	    {options {{"CASCADE (Revoke)" 1}}}
	}
	{revoke:text(checkbox),optional
	    {label ""}
	    {section "[_ dbm.options]"}
	    {options {{"Revoke" 1}}}
	}
    } -on_submit {
    
	foreach el $group {
	    set temp $el
	    set el [concat "GROUP" $temp]
	}

	set userlist [dbm::format_list -name $user]
	set grouplist [dbm::format_list -name $group]

	if {$revoke == ""} {
	    set sql "grant"
	} else {
	    set sql "revoke"
	}

	if {$grant != "" && $revoke != ""} {
	    set sql [concat $sql "grant option for"]
	}

	set privlist [dbm::format_list -name $privs]
	set sql [concat $sql $privlist]

	if {$function != ""} {
	    if {$revoke == ""} {
		set sql [concat $sql "on function \"$function\" ($args) to"]
	    } else {
		set sql [concat $sql "on function \"$function\" ($args) from"]
	    }
	}

	if {$schema != ""} {
	    if {$revoke == ""} {
		set sql [concat $sql "on schema \"$schema\" to"]
	    } else {
		set sql [concat $sql "on schema \"$schema\" from"]
	    }
	}

	if {$sequence != ""} {
	    if {$revoke == ""} {
		set sql [concat $sql "on \"$sequence\" to"]
	    } else {
		set sql [concat $sql "on \"$sequence\" from"]
	    }
	}

	if {$table != ""} {
	    if {$revoke == ""} {
		set sql [concat $sql "on \"$table\" to"]
	    } else {
		set sql [concat $sql "on \"$table\" from"]
	    }
	}

	if {$view != ""} {
	    if {$revoke == ""} {
		set sql [concat $sql "on \"$view\" to"]
	    } else {
		set sql [concat $sql "on \"$view\" from"]
	    }
	}

	if {$database != ""} {
	    if {$revoke == ""} {
		set sql [concat $sql "on database \"$database\" to"]
	    } else {
		set sql [concat $sql "on database \"$database\" from"]
	    }
	}

	if {$public != ""} {
	    set sql [concat $sql "public"]
	}

	if {$user != "" && $public == ""} {
	    set sql [concat $sql $userlist]
	}

	if {$user != "" && $public != ""} {
	    set sql [concat $sql "," $userlist]
	}
    
	if {$group != "" && $public == "" && $user == ""} {
	    set sql [concat $sql $grouplist]
	}

	if {$group != "" && $public != ""} {
	    set sql [concat $sql "," $grouplist]
	} elseif {$group != "" && $user != ""} {
	    set sql [concat $sql "," $grouplist]
	}

	if {$grant != "" && $revoke == ""} {
	    set sql [concat $sql "with grant option"]
	}
    
	if {$cascade != "" && $revoke != ""} {
	    set sql [concat $sql "CASCADE"]
	}

    db_dml alter_privs "$sql"
    ad_returnredirect "$returnurl"
    ad_script_abort
    }



 
