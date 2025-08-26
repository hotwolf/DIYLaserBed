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
//#   June 11, 2020                                                             #
//#      - Fixed design flaw:                                                   #
//#        T-Nuts had not been placed correctly, reaching into the extrusion.   #
//#                                                                             #
//#   August 26, 2025                                                           #
//#      - Fixed number of MGN7C carriages in BOM                               #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <./vitamins/T-Nut.scad>
use <./vitamins/T8Nut.scad>
use <./vitamins/FlatSection.scad>

//$explode = 1;
//$vpr = [95, 0, 160];
//$vpt = [0,0,50];

module DIYLB_carriage_shape(beam_holder=true) {    
    aoffs = 1 + ($bb_diameter/2);  //Axis offset

    difference() {
       union() {    
          //End mount profile
          translate([-10,29,10]) rotate([270,0,0])    
          for(a=[0,90,180,270])
          rotate([0,0,a]) {   
             hull() {
                linear_extrude(1) {
                   gap=0;
                   difference() {
                      translate([-5.5+gap,4.5+gap,0]) square([11-2*gap,3.5-2*gap]);
                      union() {
                         translate([-1.5-gap,0,0]) rotate([0,0,315]) square(20);
                         translate([1.5+gap,0,0]) rotate([0,0,135]) square(20);
                      }
                   }
                }
                translate([0,0,1])        
                linear_extrude(1) {
                   gap=1;      
                   difference() {
                      translate([-5.5+gap,4.5+gap,0]) square([11-2*gap,3.5-2*gap]);
                      union() {
                         translate([-1.5-gap,0,0]) rotate([0,0,315]) square(20);
                         translate([1.5+gap,0,0]) rotate([0,0,135]) square(20);
                      }
                   }        
                }
             }
             hull() {
               translate([-3+0,6,0]) cube([6-2*0,4,1]);
               translate([-3+1,6,1]) cube([6-2*1,3,1]);
             }
          }
          //End mount
          translate([-20,22,0]) cube([30,8,20]);
          //Side mount profile
          translate([0,28,10]) rotate([90,0,180]) linear_extrude(30)
          polygon([[0,3],[1,2],[1,-2],[0,-3]]);                
          //Side mount
          hull() {
             translate([0,22,0]) cube([6,36,20]);
             translate([6,22,0]) cube([12,24,20]); 
          }
          //Carriage mount
          translate([2,0,0]) cube([16,24,20]);
          hull() {
              translate([2,1,-3]) cube([6.5,18,5]);
              translate([2,0,0]) cube([8,20,2]);              
          }
          //Beam holder
          if (beam_holder) {
              translate([aoffs,aoffs+20,0]) poly_cylinder(h=20,r=12);
              hull() {
               translate([20,aoffs+17,-7]) cube([3,6,17]);
               translate([20,aoffs+17,-7]) cube([14,6,7]);
             }
          }         
       }
       union() {
          //Endmount screw
          translate([-10,40,10]) rotate([90,0,0]) poly_cylinder(h=20,r=screw_clearance_radius(M6_pan_screw));
          translate([-10,28,10]) rotate([90,0,0]) poly_cylinder(h=10,r=screw_boss_diameter(M6_pan_screw)/2);
          //T-nut screw
          translate([-10,50,10]) rotate([0,90,0]) cylinder(30,d=4.5);
          translate([6,50,10]) rotate([0,90,0]) cylinder(20,d=10);
          //T8-Nut
          translate([aoffs,aoffs+20,-1]) poly_cylinder(h=22,r=4.5);
          translate([aoffs,aoffs+20,-2]) poly_cylinder(h=21,r=5.2);
          intersection() {
             translate([aoffs,aoffs+20,-10.5]) poly_cylinder(h=20,r=11);
             translate([aoffs,aoffs+20,-0.5]) cube([12,40,20],center=true);        
          }
          translate([aoffs,aoffs+20,-14]) poly_cylinder(h=20,r=10);
          translate([aoffs,aoffs+12,19]) nut_trap(M3_cap_screw,M3_nut,depth=5,h=50,horizontal=true);
          translate([aoffs,aoffs+28,19]) nut_trap(M3_cap_screw,M3_nut, depth=5, h=50, horizontal=true);
          translate([aoffs,aoffs+12,-4]) poly_cylinder(h=10,r=screw_head_radius(M3_pan_screw)+0.2);
          translate([aoffs,aoffs+28,-4]) poly_cylinder(h=10,r=screw_head_radius(M3_pan_screw)+0.2);
          //Carriage
          translate([0,10,8.5]) rotate([0,90,0]) {
             carriage_hole_positions(MGN7C_carriage) {                 
                translate([0,0,-3]) cylinder(15,d=2.4);
                translate([0,0,5.5]) cylinder(5,d=6);
             }
             translate([0.1,0.2,0])   not_on_bom() carriage(MGN7C_carriage);
             translate([-0.1,0.2,0])  not_on_bom() carriage(MGN7C_carriage);
             translate([0.1,-0.2,0])  not_on_bom() carriage(MGN7C_carriage);
             translate([-0.1,-0.2,0]) not_on_bom() carriage(MGN7C_carriage);
             translate([-16,-8,0]) cube([30,16,6]);
          }
          //Beam holder
          translate([24,aoffs+19,-5]) cube([40,2,20]);
      }
   }
}

module DIYLB_carriage_A_stl() {
    stl("DIYLB_carriage_A");
    color(pp1_colour) 
    DIYLB_carriage_shape();
}

module DIYLB_carriage_B_stl() {
    stl("DIYLB_carriage_B");
    color(pp1_colour) 
    mirror([0,1,0]) DIYLB_carriage_shape(false);
}

module DIYLB_carriage_C_stl() {
    stl("DIYLB_carriage_C");
    color(pp1_colour) 
    mirror([0,0,0]) DIYLB_carriage_shape(false);
}

module DIYLB_carriage_D_stl() {
    stl("DIYLB_carriage_D");
    color(pp1_colour) 
    mirror([0,1,0]) DIYLB_carriage_shape();
}

module DIYLB_carriage_vitamins() {
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
    //Carriage
    translate([0,10,8.5]) rotate([0,90,0]) {
        explode(-10) carriage(MGN7C_carriage);

        carriage_hole_positions(MGN7C_carriage)                 
            translate([0,0,5.5]) explode(20) screw_and_washer(M2_cap_screw, 10);
    }
     
    //T-Nuts
    translate([0,50,10])
    rotate([270,0,270])
    tnut(6);

    //T8-Nut
    translate([aoffs,aoffs+20,4])    
    rotate([0,0,0])
    t8nut();

    //M6 screw    
    translate([-10,28,10])
    rotate([90,0,0])
    screw_and_washer(M6_pan_screw, 20);

    //M3 screws
    translate([aoffs,aoffs+28,6])
    rotate([180,0,0])
    screw(M3_pan_screw, 12);

    translate([aoffs,aoffs+28,14])
    rotate([0,0,0])
    explode(20) nut(M3_nut);

    translate([aoffs,aoffs+12,6])
    rotate([180,0,0])
    screw(M3_pan_screw, 12);

    translate([aoffs,aoffs+12,14])
    rotate([0,0,0])
    explode(20) nut(M3_nut);
}
 
//! 1. Attatch T8-nut to the carriage holder, using M3 screws,
//! 2. Attatch the rail carriage to the carriage holder using M2 screws.
//! 3. Put a T-nuts into the mounting hole.
module DIYLB_carriage_A_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_A") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
        translate([0,0,$elevation]) {    
            DIYLB_carriage_A_stl();
            DIYLB_carriage_vitamins();
        }
    }
}

//! 1. Attatch T8-nut to the carriage holder, using M3 screws,
//! 2. Attatch the rail carriage to the carriage holder using M2 screws.
//! 3. Put a T-nuts into the mounting hole.
module DIYLB_carriage_B_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_B") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
        translate([0,0,$elevation]) {    
            DIYLB_carriage_B_stl();
            mirror([0,1,0]) DIYLB_carriage_vitamins();
        }
    }
}

//! 1. Attatch T8-nut to the carriage holder, using M3 screws,
//! 2. Attatch the rail carriage to the carriage holder using M2 screws.
//! 3. Put a T-nuts into the mounting hole.
module DIYLB_carriage_C_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_C") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
        translate([0,0,$elevation]) {    
           translate([-20,0,0]) rotate([0,0,180]) DIYLB_carriage_C_stl();
           translate([-20,0,0]) rotate([0,0,180]) DIYLB_carriage_vitamins();
        }
    }
}

//! 1. Attatch T8-nut to the carriage holder, using M3 screws,
//! 2. Attatch the rail carriage to the carriage holder using M2 screws.
//! 3. Put a T-nuts into the mounting hole.
module DIYLB_carriage_D_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_D") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
        translate([0,0,$elevation]) {    
            translate([-20,0,0]) rotate([0,0,180]) DIYLB_carriage_D_stl();
            translate([-20,0,0]) rotate([0,0,180]) mirror([0,1,0]) DIYLB_carriage_vitamins();
        }
    }
}

//! 1. Cut a M6 thread into both ends of the extrusion,
//! 2. Attatch attxh the carriage holders
module DIYLB_carriage_AB_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_AB") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
        //Extrusion
        translate([-10,$frame_depth-30,$elevation+10]) rotate([90,00,0]) extrusion(E2020,$frame_depth-60 , center=false);

        //Carriage A
        translate([0,0,0]) DIYLB_carriage_A_assembly();

        //Carriage B
        translate([0,$frame_depth,0]) DIYLB_carriage_B_assembly();
    }
}


//! 1. Cut a M6 thread into both ends of the extrusion,
//! 2. Attatch attxh the carriage holders
module DIYLB_carriage_CD_assembly() {
    pose([95, 0, 160],[0, 0, 50])
    assembly("DIYLB_carriage_AB") {

        aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
        //Extrusion
        translate([330,$frame_depth-30,$elevation+10]) rotate([90,00,0]) extrusion(E2020,$frame_depth-60 , center=false);

        //Carriage C
        translate([340,$frame_depth,0]) DIYLB_carriage_C_assembly();

        //Carriage D
        translate([340,0,0]) DIYLB_carriage_D_assembly();
    }
}

if ($preview||true) {

    //Axis offset
    aoffs = 1 + ($bb_diameter/2);  //Axis offset
 
    difference() {
        union() {
    
        //Demo Carriage AB
        translate([0,0,0]) DIYLB_carriage_AB_assembly();
    
        //Demo Carriage CD
        translate([0,0,0]) DIYLB_carriage_CD_assembly();
    
        //Demo extrusions
        translate([-10,10,20]) rotate([0,0,0]) extrusion(E2020, 70, center=false);
        translate([-10,$frame_depth-10,20]) rotate([0,0,0]) extrusion(E2020, 70, center=false);
    
        //Demo rail
        translate([0,10,50])  rotate([0,90,0]) rail(MGN7, 60);
        translate([0,$frame_depth-10,50]) rotate([0,90,0]) rail(MGN7, 60);
            
        //Demo beam  
        *translate([74,aoffs+20,$elevation+2.5])  rotate([0,0,0]) flatSection(100);
            
        }
        union() {
            //Cut
            //box(-200,-200,-200,200,24,200);
         }
    }       
}
