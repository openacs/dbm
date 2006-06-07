set params "table"

ad_page_contract {
    Edit a row
} $params

set elements [db_list_of_lists get_fields {}] 
set params $elements

ad_page_contract {
    Edit a row
} $params


set dummy 1

foreach element $elements {
  
    set value [set [set element]]

    set temp1 "{"
    set temp2 ":text\n {mode \"display\"}\n {label \"$element\"}}\n {$element$dummy:text(hidden)\n {value $value}}\n {$element:text,optional\n {mode \"edit\"}\n {value $value}\n {float \"left\"}\n {label \"\"}}\n"
    append form $temp1$dummy $temp2
    lappend oldvalues $element$dummy
    set dummy [expr $dummy + 1]
}


append form "{table:text(hidden)\n {value $table}}\n"


ad_form -name edit -form $form \
    -on_submit {

set output "where"
set count [llength $elements]
set i 1

foreach element $elements {

    set old [concat $element$i]
  
    set temp [set [set old]]

    set type [db_string get_type "select t.typname from pg_class c, pg_attribute a, pg_type t where c.relname = '$table' and a.attnum > 0 and a.attrelid = c.oid and a.atttypid = t.oid and a.attname='$element'"]

    if {$type == "int4" || $type == "int8" || $type == "serial8" || $type == "float8" || $type == "decimal" || $type == "int2" || $type == "serial4"} {
	set integer 1
    } else {
	set integer 0
    }

    if {$i != $count} {
    
	if {$integer == 0 && $temp != ""} {
	    append output " " [concat \"$element\" "='$temp' and"] " "
	} elseif {$integer == 0 && $temp == ""} {
	    append output " " [concat \"$element\" "is null and"] " "
	} elseif {$integer == 1 && $temp != ""} {
	    append output " " [concat \"$element\" "=$temp and"] " "
	} elseif {$integer == 1 && $temp == ""} {
            append output " " [concat \"$element\" "is null and"] " "
	}
       

    } else {

	if {$integer == 0 && $temp != ""} {
	    append output " " [concat \"$element\" "='$temp'"] " "
	} elseif {$integer == 1 && $temp != ""} {
	    append output " " [concat \"$element\" "=$temp"] " "
	} elseif {$integer == 0 && $temp == ""} {
	    append output " " [concat \"$element\" "is null"] " "
	} elseif {$integer == 1 && $temp == ""} {
	    append output " " [concat \"$element\" "is null"] " "
	}
    }
    
    set i [expr $i + 1]
}

	foreach element $elements {
	    set temp [set [set element]]
	   

	    set type [db_string get_type "select t.typname from pg_class c, pg_attribute a, pg_type t where c.relname = '$table' and a.attnum > 0 and a.attrelid = c.oid and a.atttypid = t.oid and a.attname='$element'"]

	    if {$type == "int4" || $type == "int8" || $type == "serial8" || $type == "float8" || $type == "decimal" || $type == "int2" || $type == "serial4"} {
		set integer 1
	    } else {
		set integer 0
	    }

	    if {$integer == 0 && $temp != ""} {
		lappend update "\"$element\"='$temp'"
	    } elseif {$integer == 0 && $temp == ""} {
		lappend update "\"$element\"=null"
	    } elseif {$integer == 1 && $temp != ""} {
		lappend update "\"$element\"=$temp"
	    } elseif {$integer == 1 && $temp == ""} {
		lappend update "\"$element\"=null"
	    }
	}

	set updatelist [dbm::format_list -name $update]


	db_dml edit_row "update $table set $updatelist $output"
	ad_returnredirect "browsetable?table=$table"

      
}
