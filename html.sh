#!/bin/bash

# This is code that only matters if you use virtual env
# If you are not George and want this rule to have effect:
#   virtualenv ~/.venv/sphinx (to create your virtualenv)
#   . ~/.venv/sphinx/bin/activate
#   easy_install sphinx
#
# Otherwise, you need your own Python/Sphinx environment

if [ -f ~/.venv/sphinx/bin/activate ]; then
	. ~/.venv/sphinx/bin/activate
fi

make html
