//###############################################################################
//# DIY Laser Bed - Rail and Frame Column                                       #
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
//#   The rail and column of the Z-axis.                                        #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 19, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//#   June 11, 2020                                                             #
//#      - Fixed design flaw:                                                   #
//#        Shortened the rail holder.                                           #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>

//$explode = 1;
//$vpr = [70, 0, 25];
//$vpt = [0,0,50];

module DIYLB_rail_stl() {
    stl("DIYLB_rail");   

    aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
    color(pp1_colour)
    difference() {
        union() {

            translate([0,10,22])
            rotate([0,0,180])
            linear_extrude(66)
            polygon([[3.5,4],[5.5,2],[5.5,-2],[3.5,-4],[1.5,-2.5],[1.5,2.5]]);
            
        }    
        union() {

            translate([0,10,55]) rotate([0,90,0]) rail_hole_positions(MGN7, 70) {
                translate([0,0,-5]) rotate([0,0,30]) nut_trap(M2_cap_screw, M2_nut, depth=2, horizontal=true, h=20);
            }
        }
    }    
}

//! 1. Insert the M2 nuts into the printed holder.
//! 2. Attach the rail loosely.
//! 3. Slide the printed holder into the 20x20 extrusion and tighten the screws.
module DIYLB_rail_assembly () {
    pose([70, 0, 25],[0, 0, 50])
    assembly("DIYLB_rail") {

        //Column
        translate([-10,10,20]) rotate([0,0,0]) extrusion(E2020, 70, center=false);

        //Rail
        translate([0,10,55]) rotate([0,90,0]) explode(30) rail(MGN7, 70);
        translate([0,10,55]) rotate([0,90,0]) rail_hole_positions(MGN7, 70) {     
            translate([0,0,2]) rotate([0,0,0]) explode(40) screw(M2_cap_screw, 6);
            translate([0,0,-4]) rotate([0,0,30]) explode(10) nut(M2_nut);
        }

        //Nut holder
        explode([20,0,0]) DIYLB_rail_stl();
    }
}

if ($preview) {

    //Demo assembly
    DIYLB_rail_assembly();

    //Demo extrusions
    translate([-10,-30,10])  rotate([-90,0,0]) extrusion(E2020, 80, center=false);
    translate([-10,-30,100]) rotate([-90,0,0]) extrusion(E2020, 80, center=false);
}