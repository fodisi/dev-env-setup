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
# @Description: Installs "PostgreSQL database" and "psycopg2", a PostgreSQL adapter for the Python programming language.
# @Filename: install_postgres_ubuntu.sh
# @OS: ubuntu 16.0 or later
# @HowTo: Follow the steps below:
        # open your os shell window (command window);
        # cd <directory> ("opens" the <directory> where this file is located);
        # chmod +x <filename> (grants execution permission to this <filename>);
        # ./<filename> (executes the <filename>; do not forget to include the file extension).



#!/usr/bin/env bash


# Installs PostgreSQL
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y postgresql postgresql-contrib

# Installs psycopg2
sudo python3 -m pip install --upgrade pip
sudo pip3 install psycopg2-binary