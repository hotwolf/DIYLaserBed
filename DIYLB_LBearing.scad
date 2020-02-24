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
//#   A bracket for the lower ball bearing.                             #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 14, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <T-Nut.scad>
use <L-Bracket.scad>
use <Cent.scad>

module DIYLB_LBearing_Print() {
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
            translate([aoffs,40,2]) cylinder(40,d=$cent_diameter);
            translate([aoffs,40,2+$cent_thickness]) cylinder(40,d=$bb_diameter);
            translate([0,58,10]) rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=4.9);
            translate([0,58,10]) rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=10);
            translate([0,22,10]) rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=4.9);
            translate([0,22,10]) rotate([90,0,90]) cylinder(($bb_diameter/2)+10,d=10);        
        }
    }
}

module DIYLB_LBearing (rotation=0) {
    
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
    
    //Cent
    translate([aoffs,40,2]) Cent();    

    //Threaded rod
    translate([aoffs,40,52+$cent_thickness]) studding(8, 100);

    //Ball bearing
    translate([aoffs,40,20-($bb_height/2)-$p_hubl]) ball_bearing($bb_type);

    //Pulley
    translate([aoffs,40,$p_offs]) rotate([0,0,rotation]) pulley_assembly($p_type); 

    //T-nuts
    translate([0,58,10]) rotate([90,180,90]) tnut(($bb_diameter/2)+1);
    translate([0,22,10]) rotate([90,0,90])   tnut(($bb_diameter/2)+1);

    //Bracket
    DIYLB_LBearing_Print();
 }

//Demo assembly
DIYLB_LBearing();

//Demo extrusions
//translate([-10,0,10]) rotate([-90,0,0]) extrusion(E2020, 70);




