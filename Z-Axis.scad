//###############################################################################
//# DIY Laser Bed - Z-Axis                                                      #
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
//#   The Z-axis assembly, including printed parts.                             #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 14, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
$NopSCADlib = "../../Tools/NopSCADlib";
include <../../Tools/NopSCADlib/core.scad>
include <../../Tools/NopSCADlib/vitamins/extrusions.scad>
include <../../Tools/NopSCADlib/vitamins/screws.scad>
include <../../Tools/NopSCADlib/vitamins/nuts.scad>
include <../../Tools/NopSCADlib/vitamins/ball_bearings.scad>
include <../../Tools/NopSCADlib/vitamins/rod.scad>
include <../../Tools/NopSCADlib/vitamins/belts.scad>
include <../../Tools/NopSCADlib/vitamins/pulleys.scad>
use <./T-nut.scad>
use <./L-bracket.scad>

module znut() {

    //Z-nut
    color(pp1_colour) {

        difference() {

            union() {
                
                translate([0,-6,0])
                cube([38,12,20], true);
                //cube([20,12,20], true);
                
                translate([19,0,0])
                rotate([-90,0,90])
                linear_extrude(38)
                polygon([[0,3],[1,2],[1,-2],[0,-3]]);
                 
            }
            
            union() {

                translate([0,-6,-11])
                cylinder(22,d=10);
 
                translate([0,-6,-11])
                cylinder(6,d=22);

                translate([8,-6,-11])
                cylinder(22,d=3.5);

                translate([-8,-6,-11])
                cylinder(22,d=3.5);

                translate([-8,-6,1])
                rotate([0,0,30])
                cylinder(10,d=6.4, $fn=6);

                translate([8,-6,1])
                rotate([0,0,30])
                cylinder(10,d=6.4, $fn=6);
                
                translate([-13,3,0])
                rotate([90,0,0])
                cylinder(16,d=4.5);

                translate([-13,-9,0])
                rotate([90,0,0])
                cylinder(4,d=10);

                translate([13,3,0])
                rotate([90,0,0])
                cylinder(16,d=4.5);

                translate([13,-9,0])
                rotate([90,0,0])
                cylinder(4,d=10);
        
            }
        }
    }
}


module znut_assembly() {

    znut();

    translate([-13,0,0])
    rotate([90,0,0])
    tnut(9);

    translate([13,0,0])
    rotate([90,180,0])
    tnut(9);

    color(brass)
    difference() {
        union() {
            translate([0,-6,-8])
            intersection() {
                cylinder(3.5,d=22);
                cube([24,12,8], true);
            }
             translate([0,-6,-10])
             cylinder(15,d=10);
        }
       
        union() {
            
            translate([-8,-6,-8.5])
            cylinder(4.5,d=3.5);
            
            translate([8,-6,-8.5])
            cylinder(4.5,d=3.5);

            translate([0,-6,-11])
            cylinder(17,d=8);     
        }
    }
     
    translate([-8,-6,-8])
    rotate([180,0,0])
    screw(M3_pan_screw, 15);

    translate([-8,-6,2])
    rotate([0,0,30])
    nut(M3_nut);

    translate([8,-6,-8])
    rotate([180,0,0])
    screw(M3_pan_screw, 15);

    translate([8,-6,2])
    rotate([0,0,30])
    nut(M3_nut);

}

module lbbbracket (bb_type=BB608, p_type=GT2x20ob_pulley) {
    
    //Shortcuts
    bbdia   = bb_diameter(bb_type);                                         //Ball bearing diameter
    phoffs  = (bb_diameter(bb_type)/2)+1;                                   //Pulley horizontal offset
    pvoffs  = (pulley_width(p_type)/2)+pulley_flange_thickness(p_type)+20;  //Pulley vertical offset
    bbvoffs = 20-(bb_width(bb_type)/2)-pulley_hub_length(p_type);           //Bottom bearing verical offset 
    cvoffs  = bbvoffs-(bb_width(bb_type)/2)-1.67;                           //Cent vertical offset
    rvoffs  = bbvoffs-(bb_width(bb_type)/2)+50;                             //Rod vertical offset
    tbvoffs = rvoffs+50-(bb_width(bb_type)/2);                              //Top bearing verical offset
    lvoffs  = tbvoffs-(bb_width(bb_type)/2);
    
    
    cylinder(20,d=22);
    
}

module zaxis_assembly (bb_type=BB608, p_type=GT2x20ob_pulley, rotation=0, height=50) {
    
    //Shortcuts
    bbdia   = bb_diameter(bb_type);                                         //Ball bearing diameter
    phoffs  = (bb_diameter(bb_type)/2)+1;                                   //Pulley horizontal offset
    pvoffs  = (pulley_width(p_type)/2)+pulley_flange_thickness(p_type)+20;  //Pulley vertical offset
    bbvoffs = 20-(bb_width(bb_type)/2)-pulley_hub_length(p_type);           //Bottom bearing verical offset 
    cvoffs  = bbvoffs-(bb_width(bb_type)/2)-1.67;                           //Cent vertical offset
    rvoffs  = bbvoffs-(bb_width(bb_type)/2)+50;                             //Rod vertical offset
    tbvoffs = rvoffs+50-(bb_width(bb_type)/2);                              //Top bearing verical offset
    lvoffs  = tbvoffs-(bb_width(bb_type)/2);

    //Lower ball bearing bracket
    lbbbracket(bb_type, p_type);
    
    //Top ball bearing
    translate([phoffs,phoffs,tbvoffs]) ball_bearing(bb_type);
    
    //Top T-nuts
    translate([0,phoffs+(bbdia/2)+7,100]) rotate([90,180,90]) tnut((bbdia/2)+1);
    translate([0,phoffs-(bbdia/2)-7,100]) rotate([90,180,90]) tnut((bbdia/2)+1);
       
    //Lock
    translate([phoffs,phoffs,lvoffs]) rotate([0,0,rotation]) lock();
     
    //Threaded rod
    translate([phoffs,phoffs,rvoffs]) studding(8, 100);
 
    //Pulley
    translate([phoffs,phoffs,pvoffs]) rotate([0,0,rotation]) pulley_assembly(p_type);

    //Bottom ball bearing
    translate([phoffs,phoffs,bbvoffs]) ball_bearing(bb_type);
 
    //Cent
    translate([phoffs,phoffs,cvoffs]) color(brass){ cylinder(1.67,d=16.25); }    

    //Bottom T-nuts
    translate([bbdia+8,0,10]) rotate([90,180,180])  tnut((bbdia/2)+1);
    translate([0,bbdia+8,10]) rotate([90,0,90])     tnut((bbdia/2)+1);

    //Column
    translate([-10,phoffs,20]) extrusion(E2020, 70);
    translate([-10,phoffs-10,20]) rotate([0,-90,90])  lbracket();
    translate([-10,phoffs+10,20]) rotate([0,-90,-90]) lbracket();
    translate([-10,phoffs-10,90]) rotate([0,90,-90])  lbracket();
    translate([-10,phoffs+10,90]) rotate([0,90,90])   lbracket();

    //T8-nut
    translate([phoffs,phoffs,height]) t8nut();
}

module lock (p_type=GT2x20ob_pulley)  {
   translate([0,0,-6]) color(grey70) cylinder(6,d=12); 
   translate([-1,0,-3]) rotate([0,90,0]) screw(M3_grub_screw, 6);
}


module t8nut ()  {
    color(brass)
    difference() {
        union() {
            translate([0,0,2])
            intersection() {
                cylinder(3.5,d=22);
                cube([12,24,8], true);
            }
             translate([0,0,0])
             cylinder(15,d=10);
        }
       
        union() {
            
            translate([0,-8,1.5])
            cylinder(4.5,d=3.5);
            
            translate([0,8,1.5])
            cylinder(4.5,d=3.5);

            translate([0,0,-1])
            cylinder(17,d=8);     
        }
    }
}






//Demo BBB-bracket
zaxis_assembly(rotation=$t*720);


//Demo extrusions
translate([-10,-20,10]) rotate([-90,0,0]) extrusion(E2020, 70);
translate([0,-10,10]) rotate([0,90,0]) extrusion(E2020, 50);
translate([0,0,10]) rotate([-90,0,0]) lbracket();
translate([-10,-20,100]) rotate([-90,0,0]) extrusion(E2020, 70);

//translate([28,-20,70]) rotate([-90,0,0]) extrusion(E2020, 70);
//translate([28,-20,40]) rotate([-90,0,0]) extrusion(E2020, 70);




