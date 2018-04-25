ad_library {
    Helper Procs for dbm
}

namespace eval dbm {}

ad_proc dbm::create_combo_opts {
    -parameter
    {-split " "}
    -no_empty_option:boolean
} {
    Simple procedure to create options for dropdown menu
} {
    set opts {}
    if {!$no_empty_option_p} {
        set opts [linsert $opts 0 ""]
    }
    set props [split [parameter::get -parameter $parameter] "$split"]
    foreach prop $props {
        lappend opts [list $prop $prop]
    }
    return $opts
}

ad_proc dbm::format_list {
    -name
} {
    Simple procedure to format a list for output
} {
    set format [join $name ","]
    return $format
}


ad_proc dbm::highlight_sql {
    -sql
} {
    A simple proc to highlight sql
} {
    set result {}

    regsub -all {([^ \n\t]+)} $sql {\0} sql
    set sql [split $sql " "]
    set commands [split [parameter::get -parameter "HighlightingCommands"] " "]

    foreach el $sql {
	foreach cmd $commands {
	    if {[regsub -all -nocase "^$cmd" $el {<div style="color:#787878;text-transform:uppercase;font-family:courier;font-weight:bold;">\0</div>} el]} {
		break
	    }
	}
	lappend result $el
    }
    return [join $result " "]
}

ad_proc dbm::replace_arguments {
    -args
} {
    A simple proc to replace arguments
} {
   
    set arguments [parameter::get -parameter "FunctionArguments"]
    
    foreach pair $arguments {
	set p1 [lindex $pair 0]
	set p2 [lindex $pair 1]
	regsub -all $p1 $args $p2 args
    }
    return $args
}

ad_proc dbm::table_icon {
    -name
    -show_labels:boolean
    {-cmd fdp}
} {
    Simple proc that generates a graphical representation of the table
    @param  name       The name of the relation
    @param  colspec    List of columns
    @return string     img-tag with path to the icon
} {

    db_1row get_table_info {}
    set constraints [db_list_of_lists get_table_constraints {}]
    #ns_log Notice "$constraints"

    set graph "digraph g {
label=\"$name\" fontsize=\"9\";
graph \[size=\"8.5,11\",ratio=\"1.5\",rankdir = \"LR\"\,fontname=\"Arial\" \];
node \[fontcolor=\"red\",color=\"blue\",fontsize=\"9\" \];
\"$name\" \[shape=\"box\"\]"

#label = \""

#first we get the columns of the table
#    db_foreach get_table_properties {} {
#	append graph "$field $type|"
#    } if_no_rows {
#        append graph "no cols|"
#    }

#    set graph "[string range $graph 0 end-1]\""
#    append graph "shape = \"record\"\];"

#now we create nodes for all referenced relations
foreach constraint $constraints {
    append graph "
\"[lindex $constraint 5]\" \[ label = \"[lindex $constraint 5]\",URL= \"graph?table=[lindex $constraint 5]\",shape = \"record\" \];"
}

#and for all referencing relations
db_foreach get_referencing_tables {} {
    if {$table_name != $name} {
	append graph "
\"$table_name\" \[fontcolor=\"blue\",label = \"$table_name\",URL= \"graph?table=$table_name\",shape = \"ellipse\" \];"
    }
}

#and created the edges between source and target relation
foreach constraint $constraints {
    append graph "
\"$name\" -> \"[lindex $constraint 5]\" \["
    if {$show_labels_p} {
	append graph "label=\"[lindex $constraint 2]\", "
    }
    append graph "fontsize=\"7\"];"
}

#finally we add referencing relations
db_foreach get_referencing_tables {} {
    append graph "
\"$ref_table_name\" -> \"$table_name\" \[color=\"grey\",arrowhead=\"none\","
    if {$show_labels_p} {
	append graph "label=\"constraint_name\","
    }
    append graph "fontsize=\"7\"];"
}

append graph "
}"
    
set fileId [open /tmp/dot w 0600]
puts $fileId $graph
close $fileId
exec /usr/local/bin/$cmd -Tpng -o[acs_root_dir]/www/table.png < /tmp/dot
exec /usr/local/bin/$cmd -Tcmapx -o[acs_root_dir]/www/table.cmap < /tmp/dot


set html "<img border=\"0\" src=\"/table.png\" usemap=\"#g\">";
#get the image map
set fileId [open "[acs_root_dir]/www/table.cmap" r]
append html "[read $fileId]"
close $fileId
return $html
}

ad_proc -private dbm::create_form_def {
    {-elements:required}
    {-form_name:required}
    {-prefix:required}
} {
    Generate a form given the size, field prefixes and name
    @param   elements     A list of lists with touples. The first should be the Id the second the pretty name
    @param   prefix       The prefix to be used for the form fields

    @return  list      A list that contains the full definition of the form.

    @author Nima Mazloumi
    @creation-date 2005-08-24
} {
    set fields {}

    set count [llength $elements]

    for {set j 1} {$j <= $count} {incr j} {
        upvar "$prefix$j" local$j
        #ns_log Notice "Variable $prefix$j is [set local$j]"
    }

    for {set j 1} {$j <= $count} {incr j} {
        set field_p 0
     
        if {[exists_and_not_null local$j]} {
            set value [set local$j]
            for {set i 0} {$i < $count} {incr i} {
                if { $value == [lindex $elements $i 0]} {
		    
		    lappend fields [list "$prefix${j}_dummy:text" \
					[list label "$j. Field"] \
					[list value [lindex $elements $i 1]] \
					[list mode "display"] \
					]
        
		    lappend fields [list "$prefix${j}_dummy2:text" \
					[list label "Length"] \
					]
		    lappend fields [list "$prefix${j}_dummy5:text" \
				    [list label "Default"] \
				    ]

                    set field_p 1
                }
            }
        }

        if {!$field_p} {

	    lappend fields [list "$prefix${j}_dummy:text" \
				[list label "$j. Field"] \
				]
	    lappend fields [list "$prefix${j}_dummy3:text" \
				[list label "[_ dbm.type]"] \
				]
	    lappend fields [list "$prefix${j}_dummy2:text,optional" \
				[list label "[_ dbm.length]"] \
			       	]
            lappend fields [list "$prefix${j}_dummy5:text,optional" \
				[list label "[_ dbm.default]"] \
			        ]
            lappend fields [list "$prefix${j}_dummy4:text(checkbox),optional" \
                                [list label ""] \
				[list options [list [list "Not Null" 1]]] \
                                ]




        }
    }
    return $fields
}

ad_proc dbm::after-install {
} {
    Copies the form and list builder templates to acs-templating
} {
    file copy -force [acs_root_dir]/packages/dbm/templates/forms/dbm.adp [acs_root_dir]/packages/acs-templating/resources/forms
    file copy -force [acs_root_dir]/packages/dbm/templates/lists/dbm.adp [acs_root_dir]/packages/acs-templating/resources/lists
}

ad_proc dbm::before-uninstall {
} {
    Removes the form and list builder templates from acs-templating
} {
    file delete -force [acs_root_dir]/packages/acs-templating/resources/forms/dbm.adp
    file delete -force [acs_root_dir]/packages/acs-templating/resources/lists/dbm.adp
}

ad_proc dbm::graphVizP {
} {
    Returns 1 if GraphViz is installed and 0 if not
} {
    set graphVizP [parameter::get -parameter "GraphViz"]

    if {$graphVizP == ""} {
	set graphCmd [parameter::get -parameter "GraphCmd"]
	if {[catch {exec $graphCmd} results]} {
	    parameter::set_value -parameter "GraphVizP" -value 0
	    return 0
	} else {
	    parameter::set_value -parameter "GraphVizP" -value 1
	    return 1
	}
    } else {
	return $graphVizP
    }
}
