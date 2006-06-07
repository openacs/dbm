ad_page_contract {
    Export a table
} {
    table
} 

set path "/tmp/tableexport"
db_dml export "copy $table to '$path' with delimiter ','"

set file_inp [open $path r]
set csv [read $file_inp]
close $file_inp
ns_return 200 text/text $csv

ad_script_abort