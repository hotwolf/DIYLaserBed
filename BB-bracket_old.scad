//###############################################################################
//# DIY Laser Bed - Ball Bearing Bracket                                        #
//###############################################################################
//#    Copyright 2018 - 2019 Dirk Heisswolf                                     #
//#    This file is part of the DIY Laser Bed project.                          #
//#                                                                             #
//#    This project is free software: you can redistribute it and/or modify     #
//#    it under the terms of the GNU General Public License as published by     #
//#    the Free Software Foundation, either version 3 of the License, or        #
//#    (at your option) any later version.                                      #
//#                                                                             #
//#    This project is distributed in the hope that it will be useful,          #
//#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
//#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
//#    GNU General Public License for more details.                             #
//#                                                                             #
//#    You should have received a copy of the GNU General Public License        #
//#    along with this project.  If not, see <http://www.gnu.org/licenses/>.    #
//#                                                                             #
//#    This project makes use of the NopSCADlib library                         #
//#    (see https://github.com/nophead/NopSCADlib).                             #
//#                                                                             #
//###############################################################################
//# Description:                                                                #
//#   #D-printed backet for various ball bearings.                              #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 13, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
$NopSCADlib = "../../Tools/NopSCADlib";
include <../../Tools/NopSCADlib/core.scad>
include <../../Tools/NopSCADlib/vitamins/extrusions.scad>
include <../../Tools/NopSCADlib/vitamins/ball_bearings.scad>
use <./T-nut.scad>

module bbbracket(bb_type=BB608) {

    //T-nut
    color(pp1_colour) {

        difference() {

            union() {
                translate([0,4,0])
                cylinder((bb_width(bb_type)+1),d=(bb_diameter(bb_type)+4));

                translate([-(bb_diameter(bb_type)+22)/2,-10,0])
                cube([(bb_diameter(bb_type)+22),20,(bb_width(bb_type)+1)]);
            }
        
            union() {
 
                translate([0,4,1])
                cylinder((bb_width(bb_type)+1),d=bb_diameter(bb_type));

                translate([((bb_diameter(bb_type)/2)+5),0,0])
                cylinder((bb_width(bb_type)+2),d=4.5);

                translate([((bb_diameter(bb_type)/2)+5),0,(bb_width(bb_type)-3)])
                cylinder(5,d=10);

                translate([-((bb_diameter(bb_type)/2)+5),0,0])
                cylinder((bb_width(bb_type)+2),d=4.5);

                translate([-((bb_diameter(bb_type)/2)+5),0,(bb_width(bb_type)-3)])
                cylinder(5,d=10);
        
            }
        }
    }
}


module bbbracket_assembly(bb_type=BB608) {

    bbbracket();

    translate([0,4,(bb_width(bb_type)/2)+1])
    ball_bearing(bb_type);

    translate([((bb_diameter(bb_type)/2)+5),0,0])
    rotate([0,0,180])
    tnut((bb_width(bb_type)-3));

    translate([-((bb_diameter(bb_type)/2)+5),0,0])
    rotate([0,0,0])
    tnut((bb_width(bb_type)-3));
}


//Demo BB-bracket
bbbracket_assembly();

//Demo extrusions
translate([-20,0,-10])   rotate([0,90,0]) extrusion(E2020, 40);

