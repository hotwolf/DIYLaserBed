//###############################################################################
//# DIY Laser Bed - Lead Nut Bracket                                            #
//###############################################################################
//#    Copyright 2020 Dirk Heisswolf                                            #
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
//#   A bracket for narrow lead nuts, compatible to the Openbuilds design.      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 13, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <T-Nut.scad>
use <T8nut.scad>

module DIYLB_Carriage_Print() {

    aoffs = 1 + ($bb_diameter/2);  //Axis offset


    //Z-nut
    color(pp1_colour) {

        difference() {

            union() {
                
                translate([aoffs,25,10])
                cube([12,74,20], true);
                
                translate([aoffs+6,-12,10])
                rotate([-90,0,0])
                linear_extrude(74)
                polygon([[0,3],[1,2],[1,-2],[0,-3]]);                
            }
            
            union() {

                
                //Carriage
                translate([0,10,10]) rotate([0,90,0]) {
                    carriage_hole_positions(MGN7_carriage) {                 
                        translate([0,0,-3]) cylinder(15,d=2.4);
                        translate([0,0,7]) cylinder(5,d=6);
                    }
                    carriage(MGN7_carriage, MGN7);
                }

                //T-Nuts
                translate([aoffs-5,55,10])
                rotate([0,90,0])
                cylinder(13,d=4.5);

                translate([aoffs-7,55,10])
                rotate([0,90,0])
                cylinder(4,d=10);

                translate([aoffs-5,25,10])
                rotate([0,90,0])
                cylinder(13,d=4.5);

                translate([aoffs-7,25,10])
                rotate([0,90,0])
                cylinder(4,d=10);

                translate([aoffs-5,-5,10])
                rotate([0,90,0])
                cylinder(13,d=4.5);

                translate([aoffs-7,-5,10])
                rotate([0,90,0])
                cylinder(4,d=10);
      
                //T8-Nut
                translate([aoffs,40,-1])
                cylinder(22,d=9);
 
                translate([aoffs,40,-1])
                cylinder(18,d=10);
 
                translate([aoffs,40,-1])
                cylinder(6,d=22);
                
                translate([aoffs,32,16])
                rotate([0,0,0])
                nut_trap(M3_cap_screw,M3_nut, depth=5, h=40, horizontal=true);
 
                translate([aoffs,48,16])
                rotate([0,0,0])
                nut_trap(M3_cap_screw,M3_nut, depth=5, h=40, horizontal=true);
              
            }
        }
    }
}


module DIYLB_Carriage(elevation=50) {

    aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
    translate([0,0,elevation]) {
    
        DIYLB_Carriage_Print();
 
        //Carriage
        translate([0,10,10]) rotate([0,90,0]) carriage(MGN7_carriage, MGN7);
     
        //T-Nuts
        translate([aoffs+6,55,10])
        rotate([90,0,-90])
        tnut(9);
    
        translate([aoffs+6,25,10])
        rotate([90,180,-90])
        tnut(9);
    
        translate([aoffs+6,-5,10])
        rotate([90,180,-90])
        tnut(9);

        //T8-Nut
        translate([aoffs,40,-0.5])    
        rotate([0,0,0])
        t8nut();

        translate([aoffs,48,2])
        rotate([180,0,0])
        screw(M3_pan_screw, 12);
    
        translate([aoffs,48,11])
        rotate([0,0,0])
        nut(M3_nut);
    
        translate([aoffs,32,2])
        rotate([180,0,0])
        screw(M3_pan_screw, 12);
    
        translate([aoffs,32,11])
        rotate([0,0,0])
        nut(M3_nut);
    }
}

//Axis offset
aoffs = 1 + ($bb_diameter/2);  //Axis offset

//Demo Carriage
DIYLB_Carriage(0);

//Demo extrusions
//translate([16+aoffs,30,10]) rotate([90,0,0]) extrusion(E2020, 60);

//Demo rail
translate([0,10,10]) rotate([0,90,0]) rail(MGN7, 60);
