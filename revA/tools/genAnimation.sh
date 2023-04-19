#!/bin/sh

#Generate animated title image
cd $(dirname $0)/..
mkdir -p tmp
rm -f tmp/*.png

openscad -o tmp/wp.png \
	 --camera 610,-400,0,10,30,0,3500 \
	 --projection p \
	 --imgsize 800,800 \
	 --colorscheme Sunset \
	 --animate 120 \
	 scad/WPMain.scad

magick convert -delay 5 -loop 0 -dispose previous tmp/wp*.png img/wp.gif
