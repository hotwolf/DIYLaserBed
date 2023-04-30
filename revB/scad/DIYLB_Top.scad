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

//$explode = 1;
//$vpr = [15, 0, 0];
//$vpt = [200,180,0];

module extrusion_endmount(h=10) {

    gap = 0.1;

    linear_extrude(h) {
 
       //Inner mounts
       for(a=[0,90,180]) {
          rotate([0,0,a])      
          difference() {
              union() {
                 translate([-3+gap,5,0]) square([6-2*gap,6]);
                 translate([-5.5+gap,4.5+gap,0]) square([11-2*gap,3.5-2*gap]);
              }             
             union() {
                translate([-1.5-gap,0,0]) rotate([0,0,315]) square(20);
                translate([1.5+gap,0,0]) rotate([0,0,135]) square(20);
             }        
          }
       }
       //Outer mounts
       difference() {
          translate([-1,-1,0]) square([22,22],center=true);
          translate([0,0,0]) square(20+2*gap,center=true);
       }
    }   
}
//extrusion_endmount();

module DIYLB_top_shape() {
    aoffs = 1 + ($bb_diameter/2);  //Axis offset

    difference() {
       union() { 
          translate([-10,10,80]) extrusion_endmount(15);
          hull() {
            translate([-22,-2,90]) cube([24,24,16]);
            translate([aoffs,20+aoffs,90]) poly_cylinder(h=16,r=12/2);
          }
       }
       union() {
          translate([aoffs,20+aoffs,90]) poly_cylinder(h=15,r=8.8/2);
          translate([-10,10,70]) poly_cylinder(h=40,r=screw_radius(M6_cap_screw));
          translate([-10,10,96]) poly_cylinder(h=20,r=screw_boss_diameter(M6_cap_screw)/2);
          translate([-20,20,70]) cube([20,10,20]);
    
          //...in case the rail is a little too long
          gap=-0.2;       
          translate([-3,6.3,84]) cube([8.2,7.4,10]);
          translate([-10,10,84]) rotate([0,0,270])
          linear_extrude(10)
          difference() {
              union() {
                 translate([-3+gap,5,0]) square([6-2*gap,6]);
                 translate([-5.5+gap,4.5+gap,0]) square([11-2*gap,3.5-2*gap]);
              }             
             union() {
                translate([-1.5-gap,0,0]) rotate([0,0,315]) square(20);
                translate([1.5+gap,0,0]) rotate([0,0,135]) square(20);
             }        
          }
       }
    }    
}

module DIYLB_top_A_stl() {
     stl("DIYLB_top_A");   
     color(pp1_colour) 
     DIYLB_top_shape();
}
//DIYLB_top_A_stl();

module DIYLB_top_B_stl() {
     stl("DIYLB_top_B");   
     color(pp1_colour) 
     mirror([0,1,0]) DIYLB_top_shape();
}
//DIYLB_top_B_stl();

//! 1. Cut a M6 thread into the top of the vertical 20x20 extrusions 
//! 2. Attach the top holders
//! 3. Secure the top holders with M6 screws
module DIYLB_top_assembly() {
    pose([15,0,0], [200,180,0])
    assembly("DIYLB_top") {
      translate([0,0,0]) DIYLB_top_A_stl();
      translate([-10,10,96]) screw_and_washer(M6_cap_screw, 20);
        
      translate([0,$frame_depth,0]) DIYLB_top_B_stl();
      translate([-10,$frame_depth-10,96]) screw_and_washer(M6_cap_screw, 20);        
    } 
}

if ($preview) {
    
    aoffs = 1 + ($bb_diameter/2);  //Axis offset

    //Top beam assembly
    DIYLB_top_assembly();
    
    //Demo threaded rods   
    translate([aoffs,20+aoffs,52+$cent_thickness]) studding(8, 100);
    translate([aoffs,$frame_depth-20-aoffs,52+$cent_thickness]) studding(8, 100);
    
    //Demo extrusions   
    translate([-10,10,20]) extrusion(E2020, 70, center=false);
    translate([0,10,55])   rotate([0,90,0]) explode(30) rail(MGN7, 70);

    translate([-10,$frame_depth-10,20])                extrusion(E2020, 70, center=false);
    translate([0,$frame_depth-10,55]) rotate([0,90,0]) explode(30) rail(MGN7, 70);   
}