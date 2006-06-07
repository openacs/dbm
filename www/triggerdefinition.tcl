ad_page_contract {
    Show trigger definition
} {
    table
    trigger

}


set tgisconstraint [db_string get_const "select tgisconstraint from pg_trigger t, pg_class c where t.tgrelid=c.oid and c.relname='$table' and tgname='$trigger'"]
set tgtype [db_string get_type "select tgtype from pg_trigger t, pg_class c where t.tgrelid=c.oid and c.relname='$table' and tgname='$trigger'"]
set tgfname [db_string get_fname "select p.proname from pg_trigger t left join pg_proc p on t.tgfoid=p.oid, pg_class c where t.tgrelid=c.oid and c.relname='$table' and tgname='$trigger'"] 
set tgargs [db_string get_args "select t.tgargs from pg_trigger t, pg_class c where t.tgrelid=c.oid and c.relname='$table' and tgname='$trigger'"]

set TRIGGER_TYPE_ROW [expr 1 << 0]
set TRIGGER_TYPE_BEFORE [expr 1 << 1]
set TRIGGER_TYPE_INSERT [expr 1 << 2]
set TRIGGER_TYPE_DELETE [expr 1 << 3]
set TRIGGER_TYPE_UPDATE [expr 1 << 4]


if {$tgisconstraint == "t"} {
    set tgisconstraint "CREATE CONSTRAINT TRIGGER"
} else {
    set tgisconstraint "CREATE TRIGGER"
}

set findx 0

set expr1 [expr $tgtype & $TRIGGER_TYPE_ROW]
set expr2 [expr $tgtype & $TRIGGER_TYPE_BEFORE]
set expr3 [expr $tgtype & $TRIGGER_TYPE_INSERT]
set expr4 [expr $tgtype & $TRIGGER_TYPE_DELETE]
set expr5 [expr $tgtype & $TRIGGER_TYPE_UPDATE]

if {$expr2 == $TRIGGER_TYPE_BEFORE} {
    set def "BEFORE"
} else {
    set def "AFTER"
}

if {$expr3 == $TRIGGER_TYPE_INSERT} {
    set def [concat $def "INSERT"]
    set findx [expr $findx + 1]
}

if {$expr4 == $TRIGGER_TYPE_DELETE} {
    if {$findx > 0} {
	set def [concat $def "OR DELETE"]
    } else {
	set def [concat $def "DELETE"]
	set findx [expr $findx + 1]
    }
}

if {$expr5 == $TRIGGER_TYPE_UPDATE} {
    if {$findx > 0} {
	set def [concat $def "OR UPDATE"]
    } else {
	set def [concat $def "UPDATE"]
    }
}
if {$expr1 == $TRIGGER_TYPE_ROW} {
    set row "FOR EACH ROW"
} else {
    set row "FOR EACH STATEMENT"
}


set definition [concat $tgisconstraint $trigger $def "ON" $table $row "EXECUTE PROCEDURE" \"$tgfname\"($tgargs)]