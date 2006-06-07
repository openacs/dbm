# master.tcl
#
# Set basic attributes and provide the logical defaults for variables that
# aren't provided by the slave page.
#
# Author: Nima Mazloumi
# Creation Date: 20.04.06
#

# fall back on defaults

set admin_p [acs_user::site_wide_admin_p]

if { [template::util::is_nil doc_type] } { 
    set doc_type {<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">}
}

if { [template::util::is_nil title] } { 
    set title [ad_conn instance_name]  
}

#AG: Markup in <title> tags doesn't render well.
set title [ns_striphtml $title]


if { ![info exists header_stuff] } {
    set header_stuff {} 
}


# Attributes

multirow create attribute key value

set onload {}

# Handle RTE widget, which needs special javascript and css in the page header
global acs_blank_master__htmlareas
if {[info exists acs_blank_master__htmlareas] } {
    foreach htmlarea_id [lsort -unique $acs_blank_master__htmlareas] {
        lappend onload "acs_rteInit('${htmlarea_id}');"
    }
}

if { ![template::util::is_nil focus] } {
    # Handle elements where the name contains a dot
    if { [regexp {^([^.]*)\.(.*)$} $focus match form_name element_name] } {
        lappend onload "acs_Focus('${form_name}', '${element_name}');"
    }
}

if {![empty_string_p $onload]} { 
    multirow append attribute onload [join $onload " "]
}

# Additional Body Attributes

if {[exists_and_not_null body_attributes]} {
    foreach body_attribute $body_attributes {
	multirow append attribute [lindex $body_attribute 0] [lindex $body_attribute 1]
    }
} else {
    set body_attributes ""
}

# Header links (stylesheets, javascript)
multirow create header_links rel type href media
multirow append header_links "stylesheet" "text/css" "/resources/acs-templating/lists.css" "all"
multirow append header_links "stylesheet" "text/css" "/resources/acs-templating/forms.css" "all"
#multirow append header_links "stylesheet" "text/css" "/resources/acs-subsite/default-master.css" "all"