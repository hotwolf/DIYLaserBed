//###############################################################################
//# DIY Laser Bed - T-Nut                                                       #
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
//#   Model of a T-nut for 20x20 aluminium extrusions.                          #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 13, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <NopSCADlib/core.scad>
include <NopSCADlib/vitamins/extrusions.scad>
include <NopSCADlib/vitamins/screws.scad>

//$explode = 1;

module tnut(length=5, screw_type=M4_pan_screw) {//! Draw a nut for a 20x20 aluminium extrusion, including a screw
    description = str("T-Nut (20x20)");
    vitamin(str("tnut(", screw_type[0], "_screw, ", length+6, "): ", description));
    
    //Screw with washer
    translate([0,0,length])
    screw_and_washer(screw_type, length+6);

    //T-nut
    color(grey70) {
        difference() {
            translate([8,0,-1.4])
            rotate([-90,0,90])
            linear_extrude(12)
            polygon([[-3,0],[3,0],[3,1],[4,1],[4,2],[2,4],[-2,4],[-4,2],[-4,1],[-3,1]]);

            translate([0,0,-6])
            cylinder(8, d=screw_type[3]);
        } 
        translate([5,0,-4.5]) sphere(d=3);
    }
}

if ($preview) {

    //Demo T-nut
    tnut(10);

    //Demo extrusion
    translate([-5,0,-10])
    rotate([0,90,0])
    extrusion(E2020, 20);
}