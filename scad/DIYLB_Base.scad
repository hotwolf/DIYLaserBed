//###############################################################################
//# DIY Laser Bed - Base Assembly                                               #
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
//#   The bottom layer of the framework.                                        #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 13, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <./DIYLB_LBearing.scad>
use <./vitamins/L-Bracket.scad>
use <./vitamins/T-Nut.scad>

//$explode = 1;
//$vpr = [55, 0, 0];
//$vpt = [100,200,0];

//! 1. Slide two T-nuts into the bottom slot of the 20x20 extrusions.
//! 2. Attach the 20x20 extrusions to the case of the laser cutter, using the 
//    screw holes of the original bed.
module DIYLB_CBase_assembly() {
    pose([45, 0, 0],[150, 150, 0])
    assembly("DIYLB_CBase") {
        
        //Extrusions
        translate([20,27,10])  rotate([0,90,0])  extrusion(E2020, 320, center=false);
        translate([20,270,10]) rotate([0,90,0])  extrusion(E2020, 320, center=false);

        //T-Nuts
        translate([160,27,0])   rotate([180,0,0]) explode(10) tnut();
        translate([280,27,0])   rotate([180,0,0]) explode(10) tnut();
        translate([160,270,0])  rotate([180,0,0]) explode(10) tnut();
        translate([280,270,0])  rotate([180,0,0]) explode(10) tnut();
    }
}

//! 1. Slide two idlers on T-nuts onto the top slot of the 20x20 extrusion.
//! 2. Slide four L-brackets onto the top slot of the 20x20 extrusion.
//! 3. Slide the two holders for the lower ball bearings onto the right-hand slot
//!    of the 20x20 extrusion.
//! 4. Slide two L-brackets onto the right-hand slot of the 20x20 extrusion.
//! 5. Slide two L-brackets onto the left-hand slot of the 20x20 extrusion.
module DIYLB_LBase_assembly() {
    pose([55, 0, 0],[100, 200, 0])
    assembly("DIYLB_LBase") {

        //Extrusions
        translate([10,0,10]) rotate([-90,0,0]) extrusion(E2020, 300, center=false);
    
        //Idlers
        translate([10,140.36,20]) rotate([0,0,270]) tnut(14);
        translate([10,140.36,20]) explode(2) pulley($i_type);
        translate([10,159.64,20]) rotate([0,0,90])  tnut(14);
        translate([10,159.64,20]) explode(2) pulley($i_type);
    
        //Ball bearings
        translate([20,32,0])   mirror([0,0,0]) explode([20,0,0]) DIYLB_LBearing_assembly();
        translate([20,268,0])  mirror([0,1,0]) explode([20,0,0]) DIYLB_LBearing_assembly();
          
        //Horizontal L-Brackets
        translate([0,130,10])    rotate([90,180,0])  explode([10,0,0]) lbracket();
        translate([0,170,10])   rotate([270,180,0]) explode([10,0,0]) lbracket();

        translate([20,17,10])  rotate([90,0,0])  explode([10,0,0]) lbracket();   
        //translate([20,260,10]) rotate([90,0,0])  explode([10,0,0]) lbracket();   
        //translate([20,37,10])  rotate([-90,0,0]) explode([10,0,0]) lbracket();   
        translate([20,280,10]) rotate([-90,0,0]) explode([10,0,0]) lbracket();   
    
        //Vertical L-Brackets
        translate([10,32,20])  rotate([0,270,90])  explode([10,0,0]) lbracket();
        translate([10,50,20])  rotate([0,270,270]) explode([10,0,0]) lbracket();    
        translate([10,248,20]) rotate([0,270,90])  explode([10,0,0]) lbracket();
        translate([10,268,20]) rotate([0,270,270]) explode([10,0,0]) lbracket();
    }
}   

//! 1. Slide four L-brackets onto the top slot of the 20x20 extrusion.
//! 2. Slide the two holders for the lower ball bearings onto the lef-thand slot
//!    of the 20x20 extrusion.
//! 3. Slide two L-brackets onto the left-hand slot of the 20x20 extrusion.
module DIYLB_RBase_assembly() {
    pose([45, 0, -40],[250, 150, 0])
    assembly("DIYLB_RBase") {

        //Extrusions
        translate([350,0,10])  rotate([-90,0,0]) extrusion(E2020, 300, center=false);
       
        //Ball bearings
        translate([340,32,0])  mirror([1,0,0])                 explode([20,0,0]) DIYLB_LBearing_assembly();
        translate([340,268,0]) mirror([1,0,0]) mirror([0,1,0]) explode([20,0,0]) DIYLB_LBearing_assembly();
         
        //Horizontal L-Brackets
        translate([340,17,10])  rotate([90,180,0])  explode([10,0,0]) lbracket();   
        //translate([340,260,10]) rotate([90,180,0])  explode([10,0,0]) lbracket();   
        //translate([340,37,10])  rotate([-90,180,0]) explode([10,0,0]) lbracket();   
        translate([340,280,10]) rotate([-90,180,0]) explode([10,0,0]) lbracket();   

        //Vertical L-Brackets
        translate([350,32,20])  rotate([0,270,90])  explode([10,0,0]) lbracket();
        translate([350,50,20])  rotate([0,270,270]) explode([10,0,0]) lbracket();    
        translate([350,248,20]) rotate([0,270,90])  explode([10,0,0]) lbracket();
        translate([350,268,20]) rotate([0,270,270]) explode([10,0,0]) lbracket();
    }
}   

//! 1. Attach the three parts of the base frame
//! 2. Tighten the screws of the L-brackets, connecting 20x20 extrusions
module DIYLB_Base_assembly() {
    pose([60, 0, 0],[240, 150, 0])
    assembly("DIYLB_Base") {

        //Left stud
        explode([-25,0,0])
        DIYLB_LBase_assembly();
        
        //Center
        DIYLB_CBase_assembly();
        
        //Right stud
        explode([25,0,0])
        DIYLB_RBase_assembly();
    }   
}

if ($preview) {

    //Base assembly
    DIYLB_Base_assembly();

}