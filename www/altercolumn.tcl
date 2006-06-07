ad_page_contract {
    Alter column
} {
    table
    column
}



set notnull [db_string get_null "SELECT a.attnotnull FROM pg_class c, pg_attribute a, pg_type t WHERE c.relname = '$table' AND a.attnum > 0 AND a.attrelid = c.oid AND a.atttypid = t.oid AND a.attname = '$column'"]

set type [db_string get_type "SELECT t.typname FROM pg_class c, pg_attribute a, pg_type t WHERE c.relname = '$table' AND a.attnum > 0 AND a.attrelid = c.oid AND a.atttypid = t.oid AND a.attname = '$column'"]

set hasdefault [db_string has_default "SELECT a.atthasdef FROM pg_class c, pg_attribute a, pg_type t WHERE c.relname = '$table' AND a.attnum > 0 AND a.attrelid = c.oid AND a.atttypid = t.oid AND a.attname = '$column'"]

if {$hasdefault == "f"} {
    set default ""
} else {
    set default [db_string get_default "SELECT a.adsrc FROM pg_class c, pg_attrdef a, pg_attribute b, pg_type t WHERE c.relname = '$table' AND a.adrelid = c.oid AND b.attnum > 0 AND b.attrelid = c.oid AND b.attname = '$column' AND b.atttypid = t.oid AND b.atthasdef='t'"]
}



if {$notnull == "t"} {
    set checked_p [list checked ""]
} else {
    set checked_p ""
}

ad_form -name altercolumn -form {
    {table:text(hidden)
	{value $table}}
    {column:text(hidden)
	{value $column}}
    {name:text
	{label "Name"}
	{value $column}}
    {type:text
	{mode "display"}
	{label "[_ dbm.type]"}
	{value $type}}
    {notnull:text(checkbox),optional
	{label "Not Null"}
	{options {{"" "t"}}}
	{html $checked_p}}
    {default2:text,optional
	{label "[_ dbm.default]"}
	{value $default}}
} -on_submit {
    if {$notnull != "" && $checked_p == ""} {
	db_dml alter_column "alter table \"$table\" alter column \"$column\" set not null"
    } elseif {$notnull == "" && $checked_p != ""} {
	db_dml alter_column "alter table \"$table\" alter column \"$column\" drop not null"
    }
    if {$name != $column} {
    db_dml alter_column "alter table \"$table\" rename column \"$column\" to \"$name\""
    }
    if {$default2 != ""} {
	db_dml alter_column "alter table \"$table\" alter column \"$column\" set default '$default2'"
    } 
    
} -after_submit {
    ad_returnredirect "showtables"
    ad_script_abort
}