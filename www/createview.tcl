ad_form -name createview -form {
    {name:text
	{label "Name"}}
    {definition:text(textarea)
	{label "Definition"}
	{nospell}
	{html {rows 8 cols 50}}}
} -validate {
    {name
	{[string length $name] >= 1}
         "\"Name\" must be a string containing 1 character"
    }
    {definition
	{[string length $definition] >= 1}
	 "\"Definition\" must be a string containing 1 character"
  }  
} -on_submit {   
    db_dml create_view "create view $name as $definition;"        
} -after_submit {
        ad_returnredirect "views"
        ad_script_abort
}