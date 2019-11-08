#!/bin/bash

if [ -f ~/.venv/sphinx/bin/activate ]; then
	. ~/.venv/sphinx/bin/activate
fi

python get-examples.py
make html
make latexpdf
