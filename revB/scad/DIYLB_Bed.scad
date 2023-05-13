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


module DIYLB_beam_holder_stl() {
    stl("DIYLB_beam_holder");
    color(pp1_colour)
    
    translate([0,0,$elevation])
    difference() {
       union() {
          //Side mount profiles     
          translate([0,-5,10]) rotate([270,0,0])
          for (a=[0,90,180])
             rotate([0,0,a]) 
             translate([-10.1,0,0])
             linear_extrude(10) 
             polygon([[0,3],[1,2],[1,-2],[0,-3]]);                
          //Corners
          hull() {
             translate([-12.1,-5,20.1]) cube([2,10,1]);
             translate([-11.1,-5,20.1]) cube([1,10,2]);
          }
          hull() {
             translate([10.1,-5,20.1]) cube([2,10,1]);
             translate([10.1,-5,20.1]) cube([1,10,2]);
          }
          //Sides
          translate([-12.1,-5,7]) cube([2,10,14]);
          translate([-11.6,-5,7]) rotate([270,0,0]) cylinder(h=10,d=1);
          hull() {
             translate([10.1,-5,7])  cube([2,10,14]);
             translate([10.1,-3,0])  cube([2,6,1]);
          }
          translate([-11,-5,20.1])  cube([22,10,2]);

          
          //Beam holder
          //translate([aoffs,aoffs+20,0]) poly_cylinder(h=20,r=12);
          hull() {
             translate([10.1,-3,-7]) cube([2,6,17]);
             translate([10.1,-3,-7]) cube([14,6,7]);
          }         
      }
      union() {
         //Beam holder
         translate([12.1,-1,-5]) cube([40,2,20]);
      }
   }   
}

if ($preview) {

   //Beam holder
    DIYLB_beam_holder_stl();

   //Demo extrusions
   translate([0,30,$elevation+10]) rotate([90,0,0]) extrusion(E2020, 60, center=false);
    
}