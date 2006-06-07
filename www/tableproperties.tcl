ad_page_contract {
    Display table properties
} {
    table
}

db_multirow properties get_properties {}

template::list::create \
    -name table_properties \
    -multirow properties \
    -key field \
    -elements {
	field {
	    label "[_ dbm.field]"
        }
        type {
	    label "[_ dbm.type]"
        }
        not_null {
	    label "Not Null"
            display_template {
                <if @properties.not_null@ eq "t">
                <img src="/shared/images/checkboxchecked" height="13" width="13" border="0" style="background-color: white;">
                </if>
                <else>
                <img src="/shared/images/checkbox" height="13" width="13" border="0" style="background-color: white;">
                </else>
            }
        }
        has_default {
	    label "[_ dbm.default]"
            display_template {
                <if @properties.has_default@ eq "t">
                <img src="/shared/images/checkboxchecked" height="13" width="13" border="0" style="background-color: white;">
                </if>
                <else>
                <img src="/shared/images/checkbox" height="13" width="13" border="0" style="background-color: white;">
                </else>
            }
        }
        mycolumn {
	    label "[_ dbm.actions]"
	    display_template {
		<if @properties.has_default@ eq "t">
                <a href="dropcolumn?column=@properties.field@&table=$table" title="[_ dbm.remove]"><img src="/resources/dbm/images/b_drop.png" border="0"></a> <a href="altercolumn?column=@properties.field@&table=$table" title="[_ dbm.edit]"><img src="/resources/dbm/images/Edit16.gif" border="0"></a> <a href="dropdefault?column=@properties.field@&table=$table" title="[_ dbm.dropdefault]"><img src="/resources/dbm/images/Delete16.gif" border="0"></a>
		</if>
		<else>
		<a href="dropcolumn?column=@properties.field@&table=$table" title="[_ dbm.remove]"><img src="/resources/dbm/images/b_drop.png" border="0"></a> <a href="altercolumn?column=@properties.field@&table=$table" title="[_ dbm.edit]"><img src="/resources/dbm/images/Edit16.gif" border="0"></a>
		</else>
	    }
        }
    }