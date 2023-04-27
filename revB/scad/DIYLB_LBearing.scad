//###############################################################################
//# DIY Laser Bed - Bracket for the Lower Ball Bearings                         #
//###############################################################################
//#    Copyright 2023 - 2019 Dirk Heisswolf                                     #
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
//#   April 20, 2023                                                            #
//#      - Modified for revB                                                    #
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
            translate([0,0,0]) cube([($bb_diameter/2)+1,36,20]);
            translate([0,0,0]) cube([36,($bb_diameter/2)+1,20]);
            intersection() {
                translate([aoffs,aoffs,0])cylinder(14,d=$bb_diameter+4.5);
                translate([0,0,0]) cube([($bb_diameter)+4,$bb_diameter+4,20]);
            }

            translate([0,0,10])
            rotate([90,0,180])
            linear_extrude(36)
            polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            
            translate([0,0,10])
            rotate([270,0,270])
            linear_extrude(36)
            polygon([[0,3],[1,2],[1,-2],[0,-3]]);
   
            intersection() {
               translate([0,-10,10])
               rotate([90,0,180])
               linear_extrude(20)
               polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            
               translate([-10,0,10])
               rotate([270,0,270])
               linear_extrude(20)
               polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            }
            
        }    
        union() {
            translate([aoffs,aoffs,2])                     poly_cylinder(h=40,r=($cent_diameter+0.4)/2);
            translate([aoffs,aoffs,20-$bb_height-$p_hubl]) poly_cylinder(h=40,r=($bb_diameter+0.0)/2);
            translate([aoffs,aoffs,-10])                   poly_cylinder(h=20,r=8/2);
           
            translate([-4,30,10])                 rotate([90,0,90])  poly_cylinder(h=20,r=4.9/2);
            translate([($bb_diameter/2)-5,30,10]) rotate([90,0,90])  poly_cylinder(h=10,r=9.5/2);
            translate([30,-4,10])                 rotate([90,0,180]) poly_cylinder(h=20,r=4.9/2);
            translate([30,($bb_diameter/2)-5,10]) rotate([90,0,180]) poly_cylinder(h=10,r=9.5/2);
    
            translate([($bb_diameter/2),1,15.6]) cube([40,40,20]);
            translate([1,($bb_diameter/2),15.6]) cube([40,40,20]);
            
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
    poffs = 24;
        
    //Cent
    translate([aoffs,aoffs,2]) explode(15) cent();    

    //Threaded rod   
    translate([aoffs,aoffs,52+$cent_thickness]) explode(55) studding(8, 100);

    //Ball bearing
    translate([aoffs,aoffs,20-($bb_height/2)-$p_hubl]) explode(20) ball_bearing($bb_type);

    //Pulley
    translate([aoffs,aoffs,poffs]) rotate([0,0,$rotation]) explode(25) pulley_assembly($p_type); 

    //T-nuts
    translate([0,30,10]) rotate([90,180,90]) tnut(($bb_diameter/2)-5);
    translate([30,0,10]) rotate([270,180,0]) explode(0.1) tnut(($bb_diameter/2)-5);

    //Bracket
     DIYLB_lower_bearing_stl();    
 }

if ($preview) {
    //$explode=1;
    
    //Demo assembly
    DIYLB_lower_bearing_assembly();

    //Demo extrusions
    *translate([-10,-20,10]) rotate([-90,0,0]) extrusion(E2020, 70, center=false);
    *translate([0,-10,10])  rotate([0,90,0]) extrusion(E2020, 70, center=false);
}



