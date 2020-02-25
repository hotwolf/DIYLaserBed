//###############################################################################
//# DIY Laser Bed - Main Assembly                                               #
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
//#   Assembly of the DIY Laser Bed.                                            #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 13, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

//! This is a DIY laser bed for K40 cutters and clones. 

include <DIYLB_Config.scad>
use     <DIYLB_Base.scad>
use     <DIYLB_Crank.scad>
use     <DIYLB_Rail.scad>
use     <DIYLB_Bed.scad>

//Animation
//=========
//$elevation = 30 + ($t * 40);
//$rotation  =       $t * 360*20;
////$elevation = 70;
////$rotation  = 20;
//$vpr = [70, 0, $t * 360];
//$vpt = [150,150,0];
//$vpd = 1000;

$explode=1;
$vpr = [70, 0, 0];
$vpt = [150,150,0];



//Crank to Base
//==============
//! 1. Attach the crank holder to the base of the frame  
//! 2. Tighten the screws of the L-brackets
module DIYLB_CrankBase_assembly() {
    pose([60, 0, 5], [0,240,0])
    assembly("Crank Holder") {
    
    //Base
    DIYLB_Base_assembly();    

    //Base
    translate([0,130,0]) explode([-25,0,0]) DIYLB_Crank_assembly();    

    }
}

//Columns to Base
//===============
//! 1. Attach the for columns to the base of the frame  
//! 2. Tighten the screws of the L-brackets
module DIYLB_ColumnBase_assembly() {
    pose([70, 0, 0], [150,150,0])
    assembly("Columns") {
    
    //Base
    DIYLB_CrankBase_assembly();    

    //Columns
    translate([20,32,0])   mirror([0,0,0])                  explode(20) DIYLB_Rail_assembly();
    translate([340,32,0])  mirror([1,0,0])                  explode(20) DIYLB_Rail_assembly();
    translate([340,268,0]) mirror([1,0,0])  mirror([0,1,0]) explode(20) DIYLB_Rail_assembly();
    translate([20,268,0])  mirror([0,1,0])                  explode(20) DIYLB_Rail_assembly();

    }
}

//Bed to Columns
//==============
//! 1. Thread the assembled bed into the rails and rods of the Z-axis.
module DIYLB_ColumnBed_assembly() {
    pose([70, 0, 0], [150,150,0])
    assembly("Bed") {

        //Base and columns
        DIYLB_ColumnBase_assembly();
        
        //Bed    
        explode(100) DIYLB_Bed_assembly();
    }
}

//Top to Columns
//==============
//! 1. Attach the top extrusions to the rest of the frame.
module DIYLB_ColumnTop_assembly() {
    pose([70, 0, 0], [150,150,0])
    assembly("Top") {

    //Base
    DIYLB_ColumnBed_assembly();


    }
}

module main_assembly() {
    DIYLB_ColumnTop_assembly();
}


////Base framework
////==============
//use <DIYLB_Base.scad>
//DIYLB_Base();
//
////Lower Bearings
////==============
//use <DIYLB_LBearing.scad>
//translate([20,32,0])   mirror([0,0,0])                 DIYLB_LBearing(rotation=$rotation);
//translate([340,32,0])  mirror([1,0,0])                 DIYLB_LBearing(rotation=$rotation);
//translate([340,268,0]) mirror([1,0,0]) mirror([0,1,0]) DIYLB_LBearing(rotation=$rotation);
//translate([20,268,0])  mirror([0,1,0])                 DIYLB_LBearing(rotation=$rotation);
//p2=[32,72];
////translate([p2.x,p2.y,20]) cylinder(40,d=10);
//p3=[328,72];
////translate([p3.x,p3.y,20]) cylinder(40,d=10);
//p4=[328,228];
////translate([p4.x,p4.y,20]) cylinder(40,d=10);
//p5=[32,228];
////translate([p5.x,p5.y,20]) cylinder(40,d=10);
//
////Upper Bearings
////==============
//use <DIYLB_UBearing.scad>
//translate([20,32,0])   mirror([0,0,0])                 DIYLB_UBearing(rotation=$rotation);
//translate([340,32,0])  mirror([1,0,0])                 DIYLB_UBearing(rotation=$rotation);
//translate([340,268,0]) mirror([1,0,0]) mirror([0,1,0]) DIYLB_UBearing(rotation=$rotation);
//translate([20,268,0])  mirror([0,1,0])                 DIYLB_UBearing(rotation=$rotation);
//
////Carriages
////=========
//use <DIYLB_Carriage.scad>
//translate([20,32,0])   mirror([0,0,0])                 DIYLB_Carriage(elevation=$elevation);
//translate([340,32,0])  mirror([1,0,0])                 DIYLB_Carriage(elevation=$elevation);
//translate([340,268,0]) mirror([1,0,0]) mirror([0,1,0]) DIYLB_Carriage(elevation=$elevation);
//translate([20,268,0])  mirror([0,1,0])                 DIYLB_Carriage(elevation=$elevation);
//
////Columns
////=======
//use <DIYLB_Rail.scad>
//translate([20,32,0])   mirror([0,0,0])                  DIYLB_Rail();
//translate([340,32,0])  mirror([1,0,0])                  DIYLB_Rail();
//translate([340,268,0]) mirror([1,0,0])  mirror([0,1,0]) DIYLB_Rail();
//translate([20,268,0])  mirror([0,1,0])  DIYLB_Rail();
//
////Crank
////=====
//use <DIYLB_Crank.scad>
//translate([0,130,0]) DIYLB_Crank(rotation=$rotation);
//p0=[-58,150];
////translate([p0.x,p0.y,20]) cylinder(60,d=10);
//
////Moving Table
////============
//use <DIYLB_Table.scad>
//DIYLB_Table(elevation=$elevation);
//
////Top Beams
////=========
//use <DIYLB_Top.scad>
//DIYLB_Top();
//
////Timing belt
////===========
//use <T-Nut.scad>
//translate([10,140,20]) rotate([0,0,270]) tnut(10);
//translate([10,140,20]) pulley(GT2x20_plain_idler);
//translate([10,160,20]) rotate([0,0,90])  tnut(10);
//translate([10,160,20]) pulley(GT2x20_plain_idler);
////p1=[10,76];
//p1=[10,140.5];
////translate([p1.x,p1.y,20]) cylinder(20,d=10);
////p6=[10,224];
//p6=[10,159.5];
////translate([p6.x,p6.y,20]) cylinder(20,d=10);
//
//belt_path = [[p6.x, p6.y, -pulley_pr(GT2x20_plain_idler)],
//             [p5.x, p5.y,  pulley_pr(GT2x20ob_pulley)],
//             [p4.x, p4.y,  pulley_pr(GT2x20ob_pulley)],
//             [p3.x, p3.y,  pulley_pr(GT2x20ob_pulley)],            
//             [p2.x, p2.y,  pulley_pr(GT2x20ob_pulley)],
//             [p1.x, p1.y, -pulley_pr(GT2x20_plain_idler)],
//             [p0.x, p0.y,  pulley_pr(GT2x20ob_pulley)]];
//
//belt = GT2x6;
//translate([0,0,24]) belt(belt, belt_path);
//        
//echo(Belt_length=belt_length(belt_path));

if($preview)
    main_assembly();