#!/bin/bash

[ -f ~/.env/sphinx/bin/activate ] && . ~/.env/sphinx/bin/activate

make html
make LATEXOPTS=' -interaction=batchmode ' latexpdf
make epub
