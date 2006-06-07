ad_page_contract {
    Import a table
} {
    table
}

ad_form -name import -html {enctype multipart/form-data} -form {
    {upload_file:file
        {label "[_ dbm.filename]"}
	{html {size 50}}
    }
    {table:text(hidden)
        {value $table}
    }
} -on_submit {
    
    set filename [template::util::file::get_property filename $upload_file]
    set tmp_filename [template::util::file::get_property tmp_filename $upload_file]
    
    db_dml import "copy $table from '$tmp_filename' with delimiter ','"
    ad_returnredirect "showtables"

} -after_submit {
    ad_script_abort
}
