<master src="/www/blank-master">
<h1>Database Manager</h1>
Authors: Michael Rieker, Nima Mazloumi

<h2>General</h2>
This package is a port of PhPMyAdmin, PhPPgAdmin and PgAdmin to
OpenACS. Currently only PostgreSQL is supported. All PostgreSQL specific stuff
has been sourced out though we have to say that still the code right now only
will work for PostgreSQL as we use PostgreSQL API. There is some work in the
community going on to write an db abstractional layer that might be used in
future to support several other database management systems. 

<h2>Installation</h2>
The package is fully internationalized and will be auto-mounted under <a
href="/dbm">/dbm</a>.

<h2>Restrictions</h2>
Please note that due to the AOLServer only the main database pool can be
accessed currently. You are able to create or remove other databases depending
on the permissions the user has under which the AOLServer is running but only
the main database is accessible right now.

<h2>Warning</h2>
Please note that only site-wide admins are permitted to
access it since <b><font color="red">THIS PACKAGE CAN SEVERELY HARM YOUR
OPENACS INSTALLATION</font></b>. Be therefore warned and do not use it on a production
sytems and also if you don't know what you are doing. 

<h2>Features</h2>
<ul>
<li>coverage of the most relevant features like management of tables, views,
functions, sequences, domains, databases, schemas, variables, privileges, db
management features, import and exports
<li>full i18n
<li>full list builder support (sorting, pagination)
<li>full form builder support
<li>graphical representation - If you have GraphViz installed. Set the correct path to a GraphViz command
like dot in the parameters. This will enable you to get a graphical
representation of the relationships between the tables and even allows you to navigate.
<li>Also along with this package comes two new templates for form and list
builder. Due to restrictions in acs-templating the templates are copied to
acs-templating when the package is installed and removed later on. While the
forms template is a full rewrite to support <code>div</code>-Tags (XHTML,CSS2)
and allows the vertical and horizontal positioning of form elements within a
given section (new form builder attributes) the lists template basically
provides support for vertical table headers (only for IE).
</ul>

<h2>Future Work</h2>
Future work will
<ul>
<li>provide more import and export formats and 
<li>allow the management of all databases and not only the main pool defined in the
AOLServer configuration file
<li>provide a SQL Shell
</ul>

<h2>License</h2>
This work is published under the <a
href="http://www.gnu.org/licenses/gpl.txt">GPL</a>.
<p>
    Copyright (C) 2006  Michael Rieker, Nima Mazloumi
<p>
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.
<p>
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
<p>
    You should have received a link to the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
    USA
