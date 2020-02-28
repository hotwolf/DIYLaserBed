//###############################################################################
//# DIY Laser Bed - Moving Bed                                                  #
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
//#   The frame of the moving bed.                                              #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 19, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use     <DIYLB_Carriage.scad>
use     <./vitamins/L-Bracket.scad>
use     <./vitamins/T-Nut.scad>

//$explode = 1;
//$vpr = [15, 0,0];
//$vpt = [200,180,0];


//! 1. Attach carriage holders to the outer 20x20 extrusions.
//! 2. Assemble remainding extrusions with L-profiles. 
module DIYLB_Bed_assembly() {
    pose([15,0,0],[200,180,0])
    assembly("DIYLB_Bed") {

        translate([0,0,$elevation]) {
    
            //Extrusions
            translate([20,10,10])  rotate([0,90,0])  explode([0,-30,0]) extrusion(E2020, 320);
            translate([20,290,10]) rotate([0,90,0])  explode([0,30,0])  extrusion(E2020, 320);
            
            translate([48,20,10])   rotate([-90,0,0]) extrusion(E2020, 260);
            translate([312,20,10])  rotate([-90,0,0]) extrusion(E2020, 260);
            translate([120,20,10])  rotate([-90,0,0]) extrusion(E2020, 260);
            translate([240,20,10])  rotate([-90,0,0]) extrusion(E2020, 260);
            
            //L-Brackets
            translate([58,280,10])  rotate([90,180,90]) explode([-30,0,0]) lbracket();   
            translate([130,280,10]) rotate([90,180,90]) explode([-30,0,0]) lbracket();   
            translate([250,280,10]) rotate([90,180,90]) explode([-30,0,0]) lbracket();   
     
            translate([110,280,10]) rotate([90,0,270]) explode([-30,0,0])  lbracket();   
            translate([230,280,10]) rotate([90,0,270]) explode([-30,0,0])  lbracket();   
            translate([302,280,10]) rotate([90,0,270]) explode([-30,0,0])  lbracket();   
     
            translate([58,20,10])  rotate([90,0,90]) explode([-30,0,0])    lbracket();   
            translate([130,20,10]) rotate([90,0,90]) explode([-30,0,0])    lbracket();   
            translate([250,20,10]) rotate([90,0,90]) explode([-30,0,0])    lbracket();   
     
            translate([110,20,10]) rotate([270,0,90]) explode([-30,0,0])   lbracket();   
            translate([230,20,10]) rotate([270,0,90]) explode([-30,0,0])   lbracket();   
            translate([302,20,10]) rotate([270,0,90]) explode([-30,0,0])   lbracket();        
         }
         
         translate([20,32,0])   mirror([0,0,0])                 explode([-20,0,0]) DIYLB_Carriage_assembly();
         translate([340,32,0])  mirror([1,0,0])                 explode([-20,0,0]) DIYLB_Carriage_assembly();
         translate([340,268,0]) mirror([1,0,0]) mirror([0,1,0]) explode([-20,0,0]) DIYLB_Carriage_assembly();
         translate([20,268,0])  mirror([0,1,0])                 explode([-20,0,0]) DIYLB_Carriage_assembly();
     }     
}

if ($preview) {

    //Table assembly
    DIYLB_Bed_assembly();
}