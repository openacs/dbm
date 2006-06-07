
set type_opts [db_list_of_lists get_types {}]

ad_form -name createdomain -form {
    {name:text
	{label "Name"}
	{float "left"}
	{section "Name"}
	{text_align "left"}}
    {type:text(select)
	{options {$type_opts}}
	{float "left"}
	{label ""}
	{text_align "center"}
	{section "[_ dbm.type]"}}
    {arg:text,optional
	{float "left"}
	{label ""}
	{section "[_ dbm.type]"}}
    {array:text(checkbox),optional
	{label ""}
	{float "left"}
	{section "[_ dbm.type]"}
	{options {{"Array" 1}}}}
    {notnull:text(checkbox),optional
	{label ""}
	{float "left"}
	{text_align "left"}
	{section "Not Null"}
	{options {{"Not Null" 1}}}}
    {default:text,optional
	{float "left"}
	{section "[_ dbm.default]"}
	{label "[_ dbm.default]"}}
    {check:text,optional
	{float "left"}
	{help_text "[_ dbm.enter]"}
	{section "Check"}
	{label "Check(...)"}}
} -on_submit {
    if {$check != ""} {
       set check "CHECK ($check)"
    }
    if {$default != ""} {
	set default "DEFAULT $default"
    }
    if {$array != ""} {
	set array "[]"
    }
    if {$notnull == ""} {
      set notnull "NULL"
    } else {
      set notnull "NOT NULL"
    }
    if {$arg != ""} {
	db_dml create_domain "create domain $name as $type ($arg)$array $notnull $default $check"
    } else {
	db_dml create_domain "create domain $name as $type$array $notnull $default $check"
    }
} -after_submit {
    ad_returnredirect "showdomains"
    ad_script_abort
}