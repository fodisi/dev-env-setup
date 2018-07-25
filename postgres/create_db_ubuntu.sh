# MIT License

# Copyright (c) 2018 fodisi - https://github.com/fodisi/

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.



# @Author: fodisi
# @Description: Uninstalls "PostgreSQL database" and "psycopg2", a PostgreSQL adapter for the Python programming language.
# @Filename: install_postgres_ubuntu.sh
# @OS: ubuntu 16.0 or later
# @Note: Before you execute this file, replace the identifiers using your favorite test editor:
        # <db_name> by the database name;
        # <admin_role> by the database admin/owner user;
        # <admin_role_pwd> by the database admin/owner user's password;
        # <app_role> by the user used by your application (if not used, comment lines with reference to <app_role>);
        # <app_role_pwd> by the user's password used by your application (if not used, comment lines with reference to <app_role_pwd>);
        # <schema_name> by the schema used by the database.
# @HowTo: Follow the steps below:
        # open <filename>
        # open your os shell window (command window);
        # cd <directory> ("opens" the <directory> where this file is located);
        # chmod +x <filename> (grants execution permission to this <filename>);
        # ./<filename> (executes the <filename>; do not forget to include the file extension).



#!/usr/bin/env bash


# Creates an OS system user with no home directory, no access to shell and unable to login.
# Username and user group will have the same name.
# The OS user will have the same username as the database owner/admin user.
sudo adduser <admin_role> --system --group --no-create-home --shell=/bin/false


# Creates database admin/owner role/user.
sudo su - postgres -c 'psql -c "CREATE ROLE <admin_role> WITH LOGIN ENCRYPTED PASSWORD '\''<admin_role_pwd>'\'';"'

# Creates the database and revokes / grants permission to public / owner.
sudo su - postgres -c 'psql -c "CREATE DATABASE <db_name> WITH OWNER <admin_role>;"'
sudo su - postgres -c 'psql -c "REVOKE CONNECT ON DATABASE <db_name> FROM PUBLIC;"'
sudo su - postgres -c 'psql -c "GRANT ALL ON DATABASE <db_name> TO <admin_role>;"'

# Creates schema and revoke / grants privileges to public and owner.
sudo -H -u postgres psql <db_name> -c "CREATE SCHEMA <schema_name> AUTHORIZATION <admin_role>;"
sudo -H -u postgres psql <db_name> -c "REVOKE ALL ON SCHEMA <schema_name> FROM public;"
sudo -H -u postgres psql <db_name> -c "GRANT ALL PRIVILEGES ON SCHEMA <schema_name> TO <admin_role>;"
sudo -H -u postgres psql <db_name> -c "ALTER DEFAULT PRIVILEGES IN SCHEMA <schema_name> GRANT ALL PRIVILEGES ON TABLES TO <admin_role>;"


# IF YOUR APPLICATION DOES NOT USE A DIFFERENT USER OTHER THAN THE DB OWNER, COMMENT ALL THE LINES BELOW.
# Creates the role/user used by the application to connect to database.
sudo su - postgres -c 'psql -c "CREATE ROLE <app_role> NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"'
sudo su - postgres -c 'psql -c "ALTER ROLE <app_role> WITH LOGIN ENCRYPTED PASSWORD '\''<app_role_pwd>'\'';"'

# Grants privileges on the database and schema to the application user.
sudo -H -u postgres psql <db_name> -c "GRANT CONNECT ON DATABASE <db_name> TO <app_role>;"
sudo -H -u postgres psql <db_name> -c "GRANT USAGE ON SCHEMA <schema_name> TO <app_role>;"
sudo -H -u postgres psql <db_name> -c "ALTER DEFAULT PRIVILEGES IN SCHEMA <schema_name> GRANT ALL PRIVILEGES ON TABLES TO <app_role>;"



# COMMENTS:
# Commands "sudo -H -u USERNAME psql..." are being executed by postgres user, but could be executed by the created OS user if you wish so."
# in such case, the command "sudo -H -u USERNAME psql..." would be required instead of "sudo su - USERNAME",
# since the new user does not have a home directory nor access to sheel.
#
# The relevant parts of man sudo (commands "sudo -H -u USERNAME psql..."):
# -H   The -H (HOME) option requests that the security policy set
#      the HOME environment variable to the home directory of the
#      target user (root by default) as specified by the password
#      database.  Depending on the policy, this may be the default
#      behavior.
# -u user     The -u (user) option causes sudo to run the specified
#       command as a user other than root.  To specify a uid
#       instead of a user name, use #uid.  When running commands as
#       a uid, many shells require that the '#' be escaped with a
#       backslash ('\').  Security policies may restrict uids to
#       those listed in the password database.  The sudoers policy
#       allows uids that are not in the password database as long
#       as the targetpw option is not set.  Other security policies
#       may not support this.