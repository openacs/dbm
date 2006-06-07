ad_page_contract {
    Insert rows
} {
    table
    
}

set elements [db_list_of_lists get_fields {}] 

set dummy 1


foreach element $elements {
  
    set temp1 "{"
    set temp2 ":text\n {mode \"display\"}\n {text_align \"left\"}\n {section \"[_ dbm.insert]\"}\n {label \"$element\"}}\n {$element:text,optional\n {mode \"edit\"}\n {section \"[_ dbm.insert]\"}\n {label \"\"}}\n"
    append output $temp1$dummy $temp2
    lappend values $element 
    set dummy [expr $dummy + 1]
}


append output "{table:text(hidden)\n {value $table}}\n"

ad_form -name insert -form $output \
 -on_submit {
     foreach el $values {
         set temp [set [set el]]
	 if {$temp != ""} {
	     lappend output3 '$temp'
	     lappend output2 [concat \"$el\"]
	 }
     }
     
     set columnslist [dbm::format_list -name $output2]
        
     set valuelist [dbm::format_list -name $output3]

     db_dml insert "insert into \"$table\" ($columnslist) values ($valuelist)"
      
     ad_returnredirect "showtables"
    
}