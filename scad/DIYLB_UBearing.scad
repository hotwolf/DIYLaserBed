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
//#   A bracket for the upper ball bearing.                                     #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 14, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use     <./vitamins/T-nut.scad>
use     <./vitamins/T8Lock.scad>

//$explode = 1;
//$vpr = [95, 0, 160];
//$vpt = [0,0,50];

module DIYLB_UBearing_stl() {
    stl("DIYLB_UBearing");

    aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
    color(pp1_colour)
    difference() {
        union() {
            translate([0,15,90]) cube([($bb_diameter/2)+1,$bb_diameter+28,20]);
            intersection() {
                translate([aoffs,40,96])cylinder(14,d=$bb_diameter+4.5);
                translate([0,15,90]) cube([($bb_diameter)+4,$bb_diameter+28,20]);
            }

            translate([0,15,100])
            rotate([90,0,180])
            linear_extrude($bb_diameter+28)
            polygon([[0,3],[1,2],[1,-2],[0,-3]]);

        }    
        union() {
            translate([aoffs,40,83]) cylinder(20,d=$bb_diameter);
            translate([aoffs,40,100]) cylinder(20,d=10);
            translate([-8,58,100]) rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=4.5);
            translate([9,58,100])  rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=10);
            translate([-8,22,100]) rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=4.5);
            translate([9,22,100])  rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=10);        
        }
    }
}

//! 1. Squeze the ball bearing into the holder.
//! 2. Attach two T-nuts with screws and washers.
//! 3. Put lock ring onto the threaded rod.  
module DIYLB_UBearing_assembly () {
    pose([95,0,160], [0,0,50])
    assembly("DIYLB_UBearing") {
    
        aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
        //Ball bearing
        translate([aoffs,40,103-($bb_height/2)]) explode(-15) ball_bearing($bb_type);
    
        //t8lock
        translate([aoffs,40,97-$bb_height]) rotate([0,0,$rotation]) explode(-20) t8lock(); 
    
        //T-nuts
        translate([0,58,100]) rotate([90,180,90]) tnut(($bb_diameter/2)-2);
        translate([0,22,100]) rotate([90,0,90])   tnut(($bb_diameter/2)-2);
    
        //Bracket
        DIYLB_UBearing_stl();
    }
 }

if ($preview) {

    //Demo assembly
    DIYLB_UBearing_assembly();
    
    //Demo extrusions
    translate([-10,0,100]) rotate([-90,0,0]) extrusion(E2020, 70);
    
    //Demo rod
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
    translate([aoffs,40,52+$cent_thickness]) studding(8, 100);
}


