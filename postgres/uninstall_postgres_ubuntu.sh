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
        # <version> by your PostgreSQL version number (i.e.: 8.x, 9.x, 10).
# @HowTo: Follow the steps below:
        # open <filename>
        # open your os shell window (command window);
        # cd <directory> ("opens" the <directory> where this file is located);
        # chmod +x <filename> (grants execution permission to this <filename>);
        # ./<filename> (executes the <filename>; do not forget to include the file extension).



#!/usr/bin/env bash


# Stops PostgreSQL service 
sudo pg_dropcluster --stop <version> main

# Removes psycopg2
sudo pip3 uninstall psycopg2-binary

# Uninstalls PostgreSQL
sudo apt-get --purge remove postgresql*

# Sometimes, uninstall leaves some traces.
# If so, removes files/directories "manually". Otherwise, just fails and move on.
sudo rm -rf /etc/postgresql/
sudo rm -rf /etc/postgresql-common/
sudo rm -rf /var/lib/postgresql/
sudo userdel -r postgres
sudo groupdel postgres

# Tries to reload postgres. An ERROR is EXPECTED as confirmation of uninstall.
# Error should be similar to "Failed to reload postgres.service: Unit postgres.service not found.".
systemctl reload postgres