#!/bin/bash

find . -maxdepth 1 -name '*.py' -type l -delete
ln -s ${1}/*.py .
