//###############################################################################
//# DIY Laser Bed - Magnet Mount                         #
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
//#   A bracket for the lower ball bearing.                                     #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 14, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <./vitamins/T-Nut.scad>
use <./vitamins/L-Bracket.scad>
use <./vitamins/Magnet.scad>

//$explode=1;

module DIYLB_magnet_stl() {  
    stl("DIYLB_magnet");
    
    moffs = 1 + ($magnet_diameter/2);  //Axis offset
        
    color(pp1_colour)
    difference() {
        union() {
            translate([0,-25,0]) cube([($magnet_diameter/2)+1,50,20]);
            intersection() {
                translate([moffs,0,0])cylinder($magnet_thickness+0.4,d=$magnet_diameter+4.5);
                translate([0,-25,0]) cube([($magnet_diameter)+4,50,20]);
            }

            translate([0,-25,10])
            rotate([90,0,180])
            linear_extrude(50)
            polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            
        }    
        union() {
            translate([moffs,0,-10]) poly_cylinder(h=20,r=8/2);
            translate([moffs,0,0.4]) poly_cylinder(h=40,r=($magnet_diameter+0.0)/2);
            translate([-4,20,10])                 rotate([90,0,90]) cylinder(20,d=4.9);
            translate([($bb_diameter/2)-5,20,10]) rotate([90,0,90]) cylinder(10,d=9.5);
            translate([-4,-20,10])                 rotate([90,0,90]) cylinder(20,d=4.9);
            translate([($bb_diameter/2)-5,-20,10]) rotate([90,0,90]) cylinder(10,d=9.5);        
        }
    }
}

//! 1. Squeze the magnet into the holder.
//! 2. Attach two T-nuts with screws and washers.
module DIYLB_magnet_assembly() 
    pose([65,0,65], [0,40,30])
    assembly("DIYLB_magnet") {
    
    moffs = 1 + ($magnet_diameter/2);  //Magnet offset
        
    //Magnet
    translate([moffs,0,0.41]) explode(30) magnet();    

    //T-nuts
    translate([0,20,10]) rotate([90,180,90]) tnut(($bb_diameter/2)-5);
    translate([0,-20,10]) rotate([90,0,90])   tnut(($bb_diameter/2)-5);

    //Bracket
    DIYLB_magnet_stl();    
 }

if ($preview) {
    //$explode = 1;

    //Demo assembly
    DIYLB_magnet_assembly();

    //Demo extrusions
    *translate([-10,-35,10]) rotate([-90,0,0]) extrusion(E2020, 70, center=false);
}



