//###############################################################################
//# DIY Laser Bed - Crank Holder                                                #
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
//#   A holder for the manual crank.                                            #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 14, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//#   June 11, 2020                                                             #
//#      - Fixed design flaws:                                                  #
//#        Updated the inner profile of the beaeing holder.                     #
//#        Replaced the shaft by a M8 hex screw.                                #
//#        Added a printed crank to fit on top of the hex screw's head.         #
//#                                                                             #
//#   June 12, 2020                                                             #
//#      - Redesigned crank wheel                                               #
//#                                                                             #
//###############################################################################
include <DIYLB_Config.scad>
use <./vitamins/T-Nut.scad>
use <./vitamins/L-Bracket.scad>
//use <./vitamins/Crank.scad>

//$explode = 1;
//$vpr = [80, 0, 65];
//$vpt = [-30,0,100];

module DIYLB_crank_stl() {
    stl("DIYLB_crank");

    aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
    color(pp1_colour)
    difference() {   
        union() {
            //Screw head fitting
            translate([0,0,11]) cylinder(screw_head_height(M8_hex_screw), r=(screw_head_radius(M8_hex_screw)+2));

            //Wheel
            minkowski() {
                difference() {
                    //Disk
                    translate([0,0,6.5]) cylinder(6,d=66);
                    //Handles  
                    for (angle=[0:36:360]) rotate([0,0,angle]) translate([0,38,0]) cylinder(20,d=20);
                }
                sphere(r=2);
            }

        }    
        union() {
              //Screw head fitting
              translate([0,0,11]) screw(M8_hex_screw,50);
              translate([0,0,13]) screw(M8_hex_screw,50);
          }
    }
    
    //Markings
    color("white") 
    union() {
        for (angle=[0:36:360])  rotate([0,0,angle]) translate([0,25,14.5]) cube([1,4,2], center= true);
        for (angle=[18:36:378]) rotate([0,0,angle]) translate([0,26,14.5]) cube([1,6,2], center= true);
        labels = ["0.0","0.2","0.4","0.6","0.8","1.0","1.2","1.4","1.6","1.8"];
        for (idx=[0:1:9]) rotate([0,0,18+idx*36]) translate([0,22,13.5]) rotate([0,0,270]) linear_extrude(2) text(labels[idx], size=5.5, valign="center");
        
    }
}

module DIYLB_crank_bearing_stl() {
    stl("DIYLB_crank_bearing");

    aoffs = 1 + ($bb_diameter/2);  //Axis offset
        
    color(pp1_colour)
    difference() {
        union() {
            difference() {
                union() {
                    translate([-80,0,0])                 cube([30,50,14], true);
                    translate([($bb_diameter/2)-78,0,-1.5]) cube([(($bb_diameter/2)+5),($bb_diameter+10),$bb_height+4], true);
                    translate([aoffs-70,0,-7])           cylinder($bb_height+4,d=($bb_diameter)+10);
                }
                translate([-80,0,0]) cube([20,40,16], true);
            }

            translate([-90,-10,-7]) rotate([0,0,0])   linear_extrude(14) polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            translate([-90,10,-7])  rotate([0,0,0])   linear_extrude(14) polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            translate([-80,-20,-7]) rotate([0,0,90])  linear_extrude(14) polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            translate([-80,20,-7])  rotate([0,0,270]) linear_extrude(14) polygon([[0,3],[1,2],[1,-2],[0,-3]]);

        }    
        union() {
            translate([aoffs-70,0,-($bb_height/2)])   poly_cylinder(h=20,r=$bb_diameter/2);
            translate([aoffs-70,0,-10])               poly_cylinder(h=20,r=5);
            translate([-80,-15,0]) rotate([90,0,0])   cylinder(($bb_diameter/2)+10,d=4.5);
            translate([-80,-22,0]) rotate([90,0,0])   cylinder(($bb_diameter/2)+10,d=10);
            translate([-80,15,0])  rotate([90,0,180]) cylinder(($bb_diameter/2)+10,d=4.5);
            translate([-80,22,0])  rotate([90,0,180]) cylinder(($bb_diameter/2)+10,d=10);
            translate([-70,-10,-7]) rotate([0,0,0]) linear_extrude(14) polygon([[0,3],[1,2],[1,-2],[0,-3]]);
            translate([-70,10,-7])  rotate([0,0,0]) linear_extrude(14) polygon([[0,3],[1,2],[1,-2],[0,-3]]);            
        }
    }
}

//! 1. Connect the two 20x40 extrusions with L-brackets.
//! 2. Assemble the axis as illustrated.
//! 3. Slide the printed holders over the vertical 20x40 extrusion
//!    (and loosely insert the timing belt).
//! 4. Move the two printed holders as far apart as possible and tighten the screws.
module DIYLB_crank_assembly () {
    pose([80, 0, 65], [-30,0,100])
    assembly("DIYLB_crank") {
   
        //Extrusions
        translate([0,20,10]) rotate([0,270,0]) extrusion(E2040, 70, center=false);
        translate([-80,20,0]) rotate([0,0,0])  extrusion(E2040, 60, center=false);
        
        //L-Brackets
        //translate([0,0,10])    rotate([90,180,0]) lbracket();
        //translate([0,40,10])   rotate([270,180,0]) lbracket();
        translate([-70,10,20]) rotate([90,270,90]) explode([10,0,10]) lbracket();
        translate([-70,30,20]) rotate([90,270,90]) explode([10,0,10]) lbracket();
           
        aoffs = ($bb_diameter/2) -69;  //Axis offset
        
        //Ball bearing
        translate([aoffs,20,39]) explode(45) ball_bearing($bb_type);
        translate([aoffs,20,54]) explode(85) ball_bearing($bb_type);
    
        //Pulley
        translate([aoffs,20,25]) rotate([180,0,$rotation]) explode(-40) pulley_assembly($p_type); 
    
        //Shaft
        //translate([aoffs,20,45]) explode(100) rod(8, 50);
        translate([aoffs,20,71]) rotate([0,0,$rotation]) explode(160) screw(M8_hex_screw, 50);
        translate([aoffs,20,58]) rotate([0,0,$rotation]) explode(90) nut(M8_nut);
        
    
        //t8lock
        //translate([aoffs,20,58]) rotate([0,0,$rotation+30]) explode(145) t8lock(); 
    
        //Crank
        //translate([aoffs,20,64]) rotate([0,0,$rotation]) explode(150) crank();
        translate([aoffs,20,60]) rotate([0,0,$rotation]) explode(100) DIYLB_crank_stl();
        
    
        //T-nuts
        translate([-80,40,39]) rotate([90,90,180]) explode([-60,0,20])  tnut(2,M4_dome_screw);
        translate([-80,0,39])  rotate([90,90,0])   explode([-60,0,20])  tnut(2,M4_dome_screw);
        translate([-80,40,54]) rotate([90,90,180]) explode([-70,0,20]) tnut(2,M4_dome_screw);
        translate([-80,0,54])  rotate([90,90,0])   explode([-70,0,20]) tnut(2,M4_dome_screw);
    
        //Ball bearing brackets
        translate([0,20,39]) rotate([180,0,0]) explode(-60) DIYLB_crank_bearing_stl();
        translate([0,20,54]) rotate([0,0,0])   explode(70)  DIYLB_crank_bearing_stl();
    }
}

if ($preview) {

    difference() {
        union() {

            //Demo assembly
            DIYLB_crank_assembly();

            //Demo extrusions
            translate([10,-20,10]) rotate([-90,0,0]) extrusion(E2020, 80, center=false);

        }   
        union() {
            
                //Cut
                //box(-200,-200,40,200,200,200);
        }
    }
}
        


