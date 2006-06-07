ad_page_contract {
    Confirm resetting of a sequence
} {
    sequence
}

ad_form -name resetsequence -form {
    {sequence:text(hidden)
	{mode "display"}
	{value $sequence}}
} -on_submit {
    set minvalue [db_list get_minvalue "select min_value from $sequence"]
    db_1row reset_sequence "select setval('$sequence', $minvalue)"
} -after_submit {
    ad_returnredirect "sequenceproperties?sequence=$sequence"
    ad_script_abort
}