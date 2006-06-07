template::list::create \
    -name info \
    -multirow info \
    -elements {
        name {
                label "Name"
        }
        setting {
                label "[_ dbm.setting]"
        }
    }


db_multirow info show_all "show all"