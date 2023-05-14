//###############################################################################
//# DIY Laser Bed - Assembly Helper                                             #
//###############################################################################
//#    Copyright 2018 - 2023 Dirk Heisswolf                                     #
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
//#   Holds up the beams at an equal height to ajust the belt                   #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   May 13, 2022                                                              #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>

//$explode = 1;
//$vpr = [70, 0, 25];
//$vpt = [0,0,50];


module miniMagnet() {
    description = str("Neodym Magnet (5mmx5mmx2mm)");
    vitamin(str("miniMagnet(): ", description));
    
    *color("Silver"){ cube([2,5,5]); }    
    color("Silver"){ cylinder(h=1,d=4); }    
}

module DIYLB_assemblyHelper_stl() {
    stl("DIYLB_assemblyHelper");   

    color(pp1_colour)
    difference() {
        union() {
           translate([-8,0,-4]) cube([10,10,58]);
        }    
        union() {
           translate([-20,-10,-19.8]) cube([20,40,20]);
           translate([-20,-10,49.8])  cube([20,40,20]);
           translate([-12,-10,2])  rotate([0,105,0]) cube([10,40,10]);
           translate([-12,-10,48]) rotate([0,-15,0]) cube([10,40,10]);
           hull() {
              translate([-30,10,4]) cube([40,40,42]);
              translate([-30,4,10]) cube([40,40,30]);
          }
          //Magnet inserts
         translate([-3,0.2,10]) rotate([270,0,0]) cylinder(h=1.2,d=4.2,$fn=12);
         translate([-3,0.2,25]) rotate([270,0,0]) cylinder(h=1.2,d=4.2,$fn=12);
         translate([-3,0.2,40]) rotate([270,0,0]) cylinder(h=1.2,d=4.2,$fn=12);
       }
    }    
}
DIYLB_assemblyHelper_stl();

//! 1. Insert the magnets during print.
module DIYLB_assemblyHelper_assembly () {
    pose([70, 0, 25],[0, 0, 50])
    assembly("DIYLB_assemblyHelper") {

        //Assembly helper
        DIYLB_assemblyHelper_stl();

        //Magnets
        explode([0,-10,0]) translate([-3,0.2,10]) rotate([270,0,0]) miniMagnet();
        explode([0,-10,0]) translate([-3,0.2,25]) rotate([270,0,0]) miniMagnet();
        explode([0,-10,0]) translate([-3,0.2,40]) rotate([270,0,0]) miniMagnet();
    }
}

if ($preview) {
    //$explode = 1;

    //Demo assembly
    DIYLB_assemblyHelper_assembly();

    //Demo extrusions
    translate([-10,-30,-10])  rotate([-90,0,0]) extrusion(E2020, 80, center=false);
    translate([-10,-30,60])  rotate([-90,0,00]) extrusion(E2020, 80, center=false);
}