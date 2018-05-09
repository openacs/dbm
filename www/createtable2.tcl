ad_page_contract {
    Create table
} {
    name
    amount
    oids
}


# now retrieve the data
set field_ids [list]
for {set i 0} {$i<$amount} {incr i} {
    lappend field_ids f_$i
}

set form_name createtable2

set elements [list]
for {set i 0} {$i<$amount} {incr i} {
    lappend elements $i
}
set prefix "myprefix"

set fields [dbm::create_form_def -form_name $form_name -elements $elements -prefix $prefix]

lappend fields [list "name:text(hidden)" \
		    [list value "$name"] \
		    ]
lappend fields [list "oids:text(hidden)" \
                    [list value "$oids"] \
                    ]
lappend fields [list "amount:text(hidden)" \
                    [list value "$amount"] \
                    ]

#length:myprefix1_dummy2 etc

ad_form -name $form_name -form $fields -after_submit {

    for {set i 1} {$i<=$amount} {incr i} {
	set x [concat myprefix${i}_dummy]
	set x2 [concat myprefix${i}_dummy2]
	set x3 [concat myprefix${i}_dummy3]
        set x4 [concat myprefix${i}_dummy4]
        set x5 [concat myprefix${i}_dummy5] 
	set y [set [set x]]
	set y2 [set [set x2]]
        set y3 [set [set x3]]
        set y4 [set [set x4]]
        set y5 [set [set x5]]

	set temp 0
	if {$i == $amount} {
	    set temp 1
	}

	if {$y2 != ""} {
	    set z2 "($y2)"
	} else {
	    set z2 ""
	}

        if {$y4 != ""} {
            set z4 "NOT NULL"
        } else {
            set z4 ""
        }

        if {$y5 != ""} {
            set z5 "DEFAULT $y5"
        } else {
            set z5 ""
        }
	
	if {$temp == 0} {
	    set temp2 ","
	} else {
	    set temp2 ""
	}

	append output [concat $y $y3$z2 $z4 $z5$temp2] " " 
    }

    if {$oids != ""} {
	set oids2 "WITHOUT OIDS"
    } else {
	set oids2 "WITH OIDS"
    }

    set alpha [concat "create table \"$name\"\(" $output "\)" $oids2]
    db_dml create_table "$alpha"

   ad_returnredirect "showtables"
   ad_script_abort

}