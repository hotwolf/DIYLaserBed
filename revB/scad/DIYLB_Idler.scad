//###############################################################################
//# DIY Laser Bed - Idler Mount                                                 #
//###############################################################################
//#    Copyright 2018 - 2023 v Dirk Heisswolf                                     #
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
//#   May 13, 2023                                                              #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <./vitamins/T-Nut.scad>
use <./vitamins/L-Bracket.scad>

//$explode=1;

module DIYLB_idler_stl() {  
    stl("DIYLB_idler");
    
    ioffs = 18/2+1;  //idler offset

    color(pp1_colour)
    difference() {
        union() {
            translate([ioffs,0,0])cylinder(20,d=18);
            translate([0,-16,0]) cube([ioffs,32,20]);
            translate([0,-16,10])
            rotate([90,0,180])
            linear_extrude(32)
            polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            
        }    
        union() {
            translate([ioffs,0,-10]) poly_cylinder(h=50,r=screw_clearance_radius(M5_cap_screw));
            translate([ioffs,0,-10]) cylinder(h=18,r=screw_nut_radius(M5_cap_screw),$fn=6);
            translate([-4,9,10])                 rotate([90,0,90]) cylinder(30,d=4.9);
            translate([($bb_diameter/2)-5,9,10]) rotate([90,0,90]) cylinder(20,d=9.5);
            translate([-4,-9,10])                 rotate([90,0,90]) cylinder(30,d=4.9);
            translate([($bb_diameter/2)-5,-9,10]) rotate([90,0,90]) cylinder(20,d=9.5);
        }
    }
}
//DIYLB_idler_stl();

//! 1. Screw the idler onto the holder.
//! 2. Attach two T-nuts with screws and washers.
module DIYLB_idler_assembly() 
    pose([65,0,65], [0,40,30])
    assembly("DIYLB_idler") {
    
    ioffs = 18/2+1;  //idler offset
        
    //Idler
    translate([ioffs,0,20]) rotate([0,0,$rotation]) explode(2) pulley($ti_type);

    //T-nuts
    translate([0,-9,10]) rotate([90,180,90]) tnut(($bb_diameter/2)-5);
    translate([0,9,10])  rotate([90,0,90])   tnut(($bb_diameter/2)-5);

    //M5 screw
    translate([ioffs,0,28]) explode(20) screw_and_washer(M5_cap_screw, 28);
    translate([ioffs,0,4]) explode(-10) nut(M5_nut);

    //Bracket
    DIYLB_idler_stl();    

 }

if ($preview) {
    //$explode = 1;

    //Demo assembly
    DIYLB_idler_assembly();

    //Demo extrusions
    translate([-10,-35,10]) rotate([-90,0,0]) extrusion(E2020, 70, center=false);
}



