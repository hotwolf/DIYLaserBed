#!/bin/sh

#Run NopSCADlib scripts
cd $(dirname $0)/..
python3 ../lib/NopSCADlib/scripts/make_all.py
