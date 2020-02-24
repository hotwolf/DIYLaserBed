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
$NopSCADlib = "../../Tools/NopSCADlib";
include <../../Tools/NopSCADlib/core.scad>
include <../../Tools/NopSCADlib/vitamins/extrusions.scad>
include <../../Tools/NopSCADlib/vitamins/screws.scad>
//include <../../Tools/NopSCADlib/vitamins/washers.scad>

module tnut(height=5, screw_type=M4_pan_screw) {

//Screw with washer
translate([0,0,height])
screw_and_washer(screw_type, height+4);

//T-nut
color(grey70)
translate([8,0,-1.4])
rotate([-90,0,90])
linear_extrude(12)
polygon([[-3,0],[3,0],[3,1],[4,1],[4,2],[2,4],[-2,4],[-4,2],[-4,1],[-3,1]]);
}


//Demo T-nut
tnut(10);

//Demo extrusion
translate([-5,0,-10])
rotate([0,90,0])
extrusion(E2020, 20);

