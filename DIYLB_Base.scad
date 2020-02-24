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
use <./L-Bracket.scad>
use <./T-Nut.scad>

module DIYLB_Base() {

    //Extrusions
    translate([10,0,10])   rotate([-90,0,0]) extrusion(E2020, 300);
    translate([350,0,10])  rotate([-90,0,0]) extrusion(E2020, 300);
    translate([20,27,10])  rotate([0,90,0])  extrusion(E2020, 320);
    translate([20,270,10]) rotate([0,90,0])  extrusion(E2020, 320);

    //L-Brackets
    translate([20,17,10])   rotate([90,0,0])    lbracket();   
    translate([20,260,10])  rotate([90,0,0])    lbracket();   
    translate([20,37,10])   rotate([-90,0,0])   lbracket();   
    translate([20,280,10])  rotate([-90,0,0])   lbracket();   
    translate([340,17,10])  rotate([90,180,0])  lbracket();   
    translate([340,260,10]) rotate([90,180,0])  lbracket();   
    translate([340,37,10])  rotate([-90,180,0]) lbracket();   
    translate([340,280,10]) rotate([-90,180,0]) lbracket();   
    
    //T-Nuts
    translate([160,27,0])   rotate([180,0,0]) tnut();
    translate([280,27,0])   rotate([180,0,0]) tnut();
    translate([160,270,0])   rotate([180,0,0]) tnut();
    translate([280,270,0])   rotate([180,0,0]) tnut();
}

//Base assembly
DIYLB_Base();
