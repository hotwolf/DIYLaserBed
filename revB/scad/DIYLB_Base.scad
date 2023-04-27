//###############################################################################
//# DIY Laser Bed - Base Assembly                                               #
//###############################################################################
//#    Copyright 2023 Dirk Heisswolf                                            #
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
//#   April 20, 2023                                                            #
//#      - Modified for revB                                                    #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <./DIYLB_LBearing.scad>
use <./DIYLB_Magnet.scad>
use <./vitamins/L-Bracket.scad>
use <./vitamins/T-Nut.scad>

//$explode = 1;
//$vpr = [55, 0, 0];
//$vpt = [100,200,0];

//! 1. Attach two magnet holders to the 320mm 20x20 extrusion.

module DIYLB_base_center_assembly() {
    pose([45, 0, 0],[150, 150, 0])
    assembly("DIYLB_base_center") {
        
        //Extrusion
        translate([20,10,10])  rotate([0,90,0])  extrusion(E2020, 320, center=false);

        //Magnets
        translate([100,20,0])  rotate([0,0,90])  DIYLB_magnet_assembly();
        translate([260,20,0])  rotate([0,0,90])  DIYLB_magnet_assembly();

    }
}

//! 1. Slide two L-brackets onto the top slot of the 20x20 extrusion.
//! 2. Slide the two holders for the ball bearings onto the right-hand slot
//!    of the 20x20 extrusion.
//! 3. Slide two L-brackets onto the left-hand slot of the 20x20 extrusion.
module DIYLB_base_left_assembly() {
    pose([55, 0, 0],[100, 200, 0])
    assembly("DIYLB_base_left") {

        //Extrusions
        translate([10,($frame_depth-300)/2,10]) rotate([-90,0,0]) extrusion(E2020, 300, center=false);
    
        //Idlers
        //translate([10,140.36,20]) rotate([0,0,270]) tnut(9);
        //translate([10,140.36,20]) explode(2) pulley($i_type);
        //translate([10,159.64,20]) rotate([0,0,90])  tnut(9);
        //translate([10,159.64,20]) explode(2) pulley($i_type);
    
        //Ball bearings
        translate([20,20,0])              mirror([0,0,0]) explode([20,0,0]) DIYLB_lower_bearing_assembly();
        translate([20,$frame_depth-20,0]) mirror([0,1,0]) explode([20,0,0]) DIYLB_lower_bearing_assembly();
          
        //Horizontal L-Brackets
        translate([0,130,10]) rotate([90,180,0])  explode([10,0,0]) lbracket();
        translate([0,170,10]) rotate([270,180,0])  explode([10,0,0]) lbracket();

        //Vertical L-Brackets
        translate([10,20,20])              rotate([0,270,270]) explode([10,0,0]) lbracket();    
        translate([10,$frame_depth-20,20]) rotate([0,270,90])  explode([10,0,0]) lbracket();
    }
}   

//! 1. Slide two L-brackets onto the top slot of the 20x20 extrusion.
//! 2. Slide the two holders for the ball bearings onto the lef-thand slot
//!    of the 20x20 extrusion.
module DIYLB_base_right_assembly() {
    pose([45, 0, -40],[250, 150, 0])
    assembly("DIYLB_base_right") {

        //Extrusions
        translate([350,($frame_depth-300)/2,10]) rotate([-90,0,0]) extrusion(E2020, 300, center=false);
       
        //Ball bearings
        translate([340,20,0])              mirror([1,0,0])                 explode([20,0,0]) DIYLB_lower_bearing_assembly();
        translate([340,$frame_depth-20,0]) mirror([1,0,0]) mirror([0,1,0]) explode([20,0,0]) DIYLB_lower_bearing_assembly();
         
        //Vertical L-Brackets
        translate([350,20,20])              rotate([0,270,270]) explode([10,0,0]) lbracket();    
        translate([350,$frame_depth-20,20]) rotate([0,270,90])  explode([10,0,0]) lbracket();
    }
}   

//! 1. Attach all parts of the base frame
//! 2. Tighten the screws of the bearing holders, connecting 20x20 extrusions
module DIYLB_base_assembly() {
    pose([60, 0, 0],[240, 150, 0])
    assembly("DIYLB_Base") {

        //Left stud
        explode([-25,0,0])
        DIYLB_base_left_assembly();
        
        //Center
        explode([0,-25,0])
        DIYLB_base_center_assembly();
        explode([0,25,0])
        translate([360,$frame_depth,0])  rotate([0,0,180])
           DIYLB_base_center_assembly();
       
        //Right stud
        explode([25,0,0])
        DIYLB_base_right_assembly();
    }   
}

if ($preview) {
    //$explode=1;

    //Base assembly
    DIYLB_base_assembly();

}