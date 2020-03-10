//###############################################################################
//# DIY Laser Bed - Bracket for the Lower Ball Bearings                         #
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
use <./vitamins/Cent.scad>

//$explode=1;

module DIYLB_lower_bearing_stl() {  
    stl("DIYLB_lower_bearing");
    
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
    color(pp1_colour)
    difference() {
        union() {
            translate([0,15,0]) cube([($bb_diameter/2)+1,$bb_diameter+28,20]);
            intersection() {
                translate([aoffs,40,0])cylinder(14,d=$bb_diameter+4.5);
                translate([0,15,0]) cube([($bb_diameter)+4,$bb_diameter+28,20]);
            }

            translate([0,15,10])
            rotate([90,0,180])
            linear_extrude($bb_diameter+28)
            polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            
        }    
        union() {
            translate([aoffs,40,2])                     poly_cylinder(h=40,r=$cent_diameter/2);
            translate([aoffs,40,20-$bb_height-$p_hubl]) poly_cylinder(h=40,r=$bb_diameter/2);
            translate([-4,58,10])                 rotate([90,0,90]) cylinder(20,d=4.9);
            translate([($bb_diameter/2)-5,58,10]) rotate([90,0,90]) cylinder(10,d=10);
            translate([-4,22,10])                 rotate([90,0,90]) cylinder(20,d=4.9);
            translate([($bb_diameter/2)-5,22,10]) rotate([90,0,90]) cylinder(10,d=10);        
        }
    }
}

//! 1. Put a EuroCent coin in the bottom of the lower ball bearing holder.
//! 2. Squeze the ball bearing into the holder.
//! 3. Attach two T-nuts with screws and washers.
//! 4. Put the pulley loosely onto the threaded rod and insert them into the ball bearingpulles.  
module DIYLB_lower_bearing_assembly() 
    pose([65,0,65], [0,40,30])
    assembly("DIYLB_lower_bearing") {
    
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
    
    //Cent
    translate([aoffs,40,2]) explode(15) Cent();    

    //Threaded rod   
    translate([aoffs,40,52+$cent_thickness]) explode(55) studding(8, 100);

    //Ball bearing
    translate([aoffs,40,20-($bb_height/2)-$p_hubl]) explode(20) ball_bearing($bb_type);

    //Pulley
    translate([aoffs,40,$p_offs]) rotate([0,0,$rotation]) explode(25) pulley_assembly($p_type); 

    //T-nuts
    translate([0,58,10]) rotate([90,180,90]) tnut(($bb_diameter/2)-5);
    translate([0,22,10]) rotate([90,0,90])   tnut(($bb_diameter/2)-5);

    //Bracket
    DIYLB_lower_bearing_stl();    
 }

if ($preview) {

    //Demo assembly
    DIYLB_lower_bearing_assembly();

    //Demo extrusions
    translate([-10,0,10]) rotate([-90,0,0]) extrusion(E2020, 70, center=false);
}



