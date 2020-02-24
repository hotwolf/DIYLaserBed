//###############################################################################
//# DIY Laser Bed - Z-Axis Assembly                                             #
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
//#   Preassembled Z-Axis.                                                      #
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
include <../../Tools/NopSCADlib/vitamins/rod.scad>
include <../../Tools/NopSCADlib/vitamins/screws.scad>
include <../../Tools/NopSCADlib/vitamins/belts.scad>
include <../../Tools/NopSCADlib/vitamins/pulleys.scad>
include <../../Tools/NopSCADlib/vitamins/leadnuts.scad>
use <./BB-bracket_old.scad>

module zaxis_assembly(rotation=0, bb_type=BB608, p_type=GT2x20ob_pulley) {

    //Top BB-bracket
    translate([0,0,70])
    rotate([0,180,0])
    bbbracket_assembly(bb_type);

    //Bottom BB-bracket
    bbbracket_assembly(bb_type);

    //Threaded rod
    translate([0,4,35])
    studding(8,70);

    //Pulley
    translate([0,4,(pulley_offset(p_type)+pulley_height(p_type)+bb_width(bb_type)+1)])
    rotate([0,180,rotation])
    pulley_assembly(p_type);
    
    //Stopper
    translate([0,4,((pulley_width(p_type)/2)+69)-bb_width(bb_type)])
    rotate([0,0,rotation])
    pulley_assembly(p_type);
     
    
}

//Demo L-bracket
zaxis_assembly();

//Demo lead nut
translate([0,4,40])
leadnut(LSN8x2);

//Demo extrusions
translate([-20,0,-10])   rotate([0,90,0]) extrusion(E2020, 40);
translate([-20,0,80])   rotate([0,90,0]) extrusion(E2020, 40);

