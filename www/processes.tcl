
template::list::create \
    -name processes \
    -multirow processes \
    -elements {
        usename {
	    label "[_ dbm.users]"
        }
        procpid {
                label "[_ dbm.process]"
        }
	current_query {
	    label "SQL"
	}
    }


db_multirow processes show_processes "select usename,procpid,current_query from pg_stat_activity where datname='oacs-5-2' order by usename, procpid"