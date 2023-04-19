#!/bin/sh

#Generate animated title image
cd $(dirname $0)/..
mkdir -p tmp
rm -f tmp/*.png

openscad -o tmp/lb.png \
	 --projection p \
	 --imgsize 800,600 \
	 --colorscheme Solarized \
	 --animate 240 \
	 scad/DIYLB.scad

magick convert -delay 5 -loop 0 -dispose previous tmp/lb*.png doc/DIYLB.gif
