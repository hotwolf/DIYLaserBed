//###############################################################################
//# DIY Laser Bed - Top Beams                                                   #
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
//#   The two top beams of the framework.                                       #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 19, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use     <DIYLB_UBearing.scad>

//$explode = 1;
//$vpr = [15, 0, 0];
//$vpt = [200,180,0];

//! 1. Attach the four upper ball bearing holder to the upper 20x20 extrusions 
//     of the frame.
module DIYLB_Top_assembly() {
    pose([15,0,0], [200,180,0])
    assembly("DIYLB_Top") {

        //Extrusions
        translate([10,0,100])   rotate([-90,0,0]) extrusion(E2020, 300);
        translate([350,0,100])  rotate([-90,0,0]) extrusion(E2020, 300);
        
        //Upper ball bearing holders
        translate([20,32,0])   mirror([0,0,0])                 explode([20,0,0]) DIYLB_UBearing_assembly();
        translate([340,32,0])  mirror([1,0,0])                 explode([20,0,0]) DIYLB_UBearing_assembly();
        translate([340,268,0]) mirror([1,0,0]) mirror([0,1,0]) explode([20,0,0]) DIYLB_UBearing_assembly();
        translate([20,268,0])  mirror([0,1,0])                 explode([20,0,0]) DIYLB_UBearing_assembly();
    } 
}

if ($preview) {
    
    //Top beam assembly
    DIYLB_Top_assembly();
}