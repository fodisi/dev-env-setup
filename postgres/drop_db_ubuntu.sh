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
# @env: dev | test
# @Note: Before you execute this file, replace the identifiers using your favorite test editor:
        # <db_name> by the database name;
        # <admin_role> by the database admin/owner user;
        # <app_role> by the user used by your application (if not used, comment lines with reference to <app_role>);
        # <schema_name> by the schema used by the database.
# @HowTo: Follow the steps below:
        # open <filename>
        # open your os shell window (command window);
        # cd <directory> ("opens" the <directory> where this file is located);
        # chmod +x <filename> (grants execution permission to this <filename>);
        # ./<filename> (executes the <filename>; do not forget to include the file extension).



#!/usr/bin/env bash


sudo su - postgres -c 'psql <db_name> -c "DROP SCHEMA <schema_name> CASCADE;"'
sudo su - postgres -c 'psql -c "DROP DATABASE <db_name>;"'
sudo su - postgres -c 'psql -c "DROP ROLE <app_role>;"'
sudo su - postgres -c 'psql -c "DROP ROLE <admin_role>;"'
sudo userdel <admin_role>
sudo groupdel <admin_role>
sudo rm -rf /home/<admin_role>/
