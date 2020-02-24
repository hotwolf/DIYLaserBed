//###############################################################################
//# DIY Laser Bed - Lead Nut Bracket                                            #
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
//#   A bracket for narrow lead nuts, compatible to the Openbuilds design.      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 13, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <Config.scad>
use <t-Nut.scad>
use <T8nut.scad>
use <Wheel.scad>

module wbracket() {

    aoffs = 1 + ($bb_diameter/2);  //Axis offset


    //Z-nut
    color(pp1_colour) {

        difference() {

            union() {
                
                translate([-20,4,0])
                cube([20,24,20]);                 
            }
            
            union() {

                //wheel
                translate([-10,11.5,10])
                rotate([0,90,0])
                wheel(["neg", 9, $w_type[2]+4, $w_type[3]+4, $w_type[4]+4]);

                translate([-10,11.5,10])
                rotate([0,90,0])
                wheel(["neg", 0,  $w_type[2], $w_type[3], $w_type[4]]);

                translate([-10,1,10])
                cube([$w_type[2]+4,11.5,20],true);

                //Screw
                translate([0,11.5,10])
                rotate([0,-90,0])
                cylinder(20,d=4.5);

                translate([-17,11.5,10])
                rotate([0,-90,0])
                cylinder(4,d=10);

                translate([1,11.5,10])
                rotate([90,30,-90])
                cylinder(4,d=8.2, $fn=6);



        
            }
        }
            
        //difference() {

            union() {
                
                //translate([aoffs,aoffs,10])
                //cube([12,38,20], true);
                //cube([20,12,20], true);
                
                translate([aoffs+6,aoffs-19,10])
                rotate([-90,0,0])
                linear_extrude(38)
                polygon([[0,3],[1,2],[1,-2],[0,-3]]);
                 
            }
            
            union() {
                
                translate([aoffs,45,10])
                rotate([0,90,0])
                cylinder(8,d=4.5);

                translate([aoffs,45,10])
                rotate([0,90,0])
                cylinder(4,d=10);

                translate([aoffs,35,10])
                rotate([0,90,0])
                cylinder(8,d=4.5);

                translate([aoffs,35,10])
                rotate([0,90,0])
                cylinder(4,d=10);
            }            
        //}    
    }
}


module wbracket_assembly() {

    aoffs = 1 + ($bb_diameter/2);  //Axis offset

    //Wheel bracket 
    wbracket();

    //Screw
    translate([-12-($w_type[2]/2),11.5,10])
    rotate([0,-90,0])
    screw_and_washer(M4_pan_screw, 16);

    translate([0.2,11.5,10])
    rotate([90,30,-90])
    nut(M4_nut);
 
    //T-nuts
    translate([aoffs+6,45,10])
    rotate([90,0,-90])
    tnut(2);

    translate([aoffs+6,35,10])
    rotate([90,180,-90])
    tnut(2);

    //wheel
    translate([-10,11.5,10])
    rotate([0,90,0])
    //wheel(["Type D", 4.9,  8.8, 15.4, 5]);
    wheel($w_type);

}

//Axis offset
aoffs = 1 + ($bb_diameter/2);  //Axis offset

//Demo BB-bracket
wbracket_assembly();

//Demo extrusions
translate([-10,-10,-20]) rotate([0,0,0]) extrusion(E2020, 60);
translate([16+aoffs,60,10]) rotate([90,0,0]) extrusion(E2020, 80);
