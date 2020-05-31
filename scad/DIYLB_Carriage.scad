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
use <./vitamins/T-Nut.scad>
use <./vitamins/T8Nut.scad>

//$explode = 1;
//$vpr = [95, 0, 160];
//$vpt = [0,0,50];

module DIYLB_carriage_shape() {    
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
                    translate([0.1,0.2,0])  carriage(MGN7_carriage, MGN7);
                    translate([-0.1,0.2,0]) carriage(MGN7_carriage, MGN7);
                    translate([0.1,-0.2,0])  carriage(MGN7_carriage, MGN7);
                    translate([-0.1,-0.2,0]) carriage(MGN7_carriage, MGN7);
                    }

                //T-Nuts
                translate([aoffs-5,55,10])
                rotate([0,90,0])
                cylinder(13,d=4.5);

                translate([aoffs-7,55,10])
                rotate([0,90,0])
                cylinder(10,d=10);

                translate([aoffs-5,25,10])
                rotate([0,90,0])
                cylinder(13,d=4.5);

                translate([aoffs-7,25,10])
                rotate([0,90,0])
                cylinder(10,d=10);

                translate([aoffs-5,-5,10])
                rotate([0,90,0])
                cylinder(13,d=4.5);

                translate([aoffs-7,-5,10])
                rotate([0,90,0])
                cylinder(10,d=10);
      
                //T8-Nut
                translate([aoffs,40,-1])
                poly_cylinder(h=22,r=4.5);
 
                translate([aoffs,40,-1])
                poly_cylinder(h=18,r=5.2);
 
                translate([aoffs,40,-1])
                poly_cylinder(h=6,r=11);
                
                translate([aoffs,32,20])
                rotate([0,0,0])
                nut_trap(M3_cap_screw,M3_nut, depth=5, h=50, horizontal=true);
 
                translate([aoffs,48,20])
                rotate([0,0,0])
                nut_trap(M3_cap_screw,M3_nut, depth=5, h=50, horizontal=true);
              
            }
        }
    }
}

module DIYLB_carriage_right_stl() {
    stl("DIYLB_carriage_right");

    DIYLB_carriage_shape();
}

module DIYLB_carriage_left_stl() {
    stl("DIYLB_carriage_left");

    mirror([0,1,0]) DIYLB_carriage_shape();
}

module DIYLB_carriage_vitamins() {
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
    //Carriage
    translate([0,10,10]) rotate([0,90,0]) {
        explode(-10) carriage(MGN7_carriage, MGN7);

        carriage_hole_positions(MGN7_carriage)                 
            translate([0,0,7]) explode(20) screw_and_washer(M2_cap_screw, 10);
    }
     
    //T-Nuts
    translate([aoffs+9,55,10])
    rotate([90,0,-90])
    tnut(6);

    translate([aoffs+9,25,10])
    rotate([90,180,-90])
    tnut(6);

    translate([aoffs+9,-5,10])
    rotate([90,180,-90])
    tnut(6);

    //T8-Nut
    translate([aoffs,40,-0.5])    
    rotate([0,0,0])
    t8nut();

    translate([aoffs,48,2])
    rotate([180,0,0])
    screw(M3_pan_screw, 16);

    translate([aoffs,48,15])
    rotate([0,0,0])
    explode(20) nut(M3_nut);

    translate([aoffs,32,2])
    rotate([180,0,0])
    screw(M3_pan_screw, 16);

    translate([aoffs,32,15])
    rotate([0,0,0])
    explode(20) nut(M3_nut);
}

//! 1. Attatch T8-nut to the carriage holder, using M3 screws,
//! 2. Attatch the rail carriage to the carriage holder using M2 screws.
//! 3. Put three T-nuts into the mounting holes.
module DIYLB_carriage_right_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_right") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
        translate([0,0,$elevation]) {
    
            DIYLB_carriage_right_stl();

            DIYLB_carriage_vitamins();
        }
    }
}
        
//! 1. Attatch T8-nut to the carriage holder, using M3 screws,
//! 2. Attatch the rail carriage to the carriage holder using M2 screws.
//! 3. Put three T-nuts into the mounting holes.
module DIYLB_carriage_left_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_left") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
        translate([0,0,$elevation]) {
    
            DIYLB_carriage_left_stl();

            mirror([0,1,0]) DIYLB_carriage_vitamins();
        }
    }
}
 
if ($preview) {

    //Axis offset
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
    
    //Demo Carriage (right side)
    DIYLB_carriage_right_assembly();
    
    //Demo Carriage (left side)
    translate([0,200,0]) DIYLB_carriage_left_assembly();
    
    //Demo extrusions
    translate([16+aoffs,220,$elevation+10]) rotate([90,0,0]) extrusion(E2020, 240, center=false);
    
    //Demo rail
    translate([0,10,40])   rotate([0,90,0]) rail(MGN7, 60);
    translate([0,190,40]) rotate([0,90,0]) rail(MGN7, 60);
}