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
//! ![inside](doc/DIYLB.gif?raw=true)

include <DIYLB_Config.scad>
use     <DIYLB_Base.scad>
use     <DIYLB_Crank.scad>
use     <DIYLB_Rail.scad>
use     <DIYLB_Bed.scad>
use     <DIYLB_Top.scad>
use     <DIYLB_Carriage.scad>
use     <./vitamins/FlatSection.scad>

//$explode=1;
//$vpr = [30,0,0];
//$vpt = [150, 150, 0];

//Crank to Base
//==============
//! 1. Attach the crank holder to the base of the frame  
//! 2. Tighten the screws of the L-brackets
module DIYLB_crank_to_base_assembly() {
    pose([60, 0, 5], [0,240,0])
    assembly("DIYLB_crank_to_base") {
    
    //Base
    DIYLB_base_assembly();    

    //Base
    translate([0,130,0]) explode([-25,0,0]) DIYLB_crank_assembly();    

    }
}

//Columns to Base
//===============
//! 1. Attach the for columns to the base of the frame  
//! 2. Tighten the screws of the L-brackets
module DIYLB_columns_to_base_assembly() {
    pose([70, 0, 0], [150,150,0])
    assembly("DIYLB_columns_to_base") {
    
    //Base
    DIYLB_crank_to_base_assembly();    

    //Columns
    translate([20,0,0])                mirror([0,0,0]) explode(20) DIYLB_rail_assembly();
    translate([340,0,0])               mirror([1,0,0]) explode(20) DIYLB_rail_assembly();
    translate([340,$frame_depth-20,0]) mirror([1,0,0]) explode(20) DIYLB_rail_assembly();
    translate([20,$frame_depth,0])     mirror([0,1,0]) explode(20) DIYLB_rail_assembly();

    }
}

//Bed to Columns
//==============
//! 1. Thread the assembled carriage holders into the rails and rods of the Z-axis.
module DIYLB_bed_to_columns_assembly() {
    pose([70, 0, 0], [150,150,0])
    assembly("DIYLB_bed_to_columns") {

        //Base and columns
        DIYLB_columns_to_base_assembly();
        
        //Bed    
        explode(100) translate([20,0,0]) DIYLB_carriage_AB_assembly();
        explode(100) translate([20,0,0]) DIYLB_carriage_CD_assembly();
    }
}

//Beams to Bed
//============
//! 1. Attach the beam holders to the horizontal 20x20 extrusions of the bed.
//! 2. Slide the beams into the beam holders
module DIYLB_beams_to_bed_assembly() {
    pose([70, 0, 0], [150,150,0])
    assembly("DIYLB_beams_to_bed") {

       aoffs = 1 + ($bb_diameter/2);  //Axis offset

       //Beam holders
       translate([10,70,0])  DIYLB_beam_holder_stl();
       translate([10,120,0]) DIYLB_beam_holder_stl();
       translate([10,170,0]) DIYLB_beam_holder_stl();
       translate([10,220,0]) DIYLB_beam_holder_stl();
       translate([350,70,0])  rotate([0,0,180]) DIYLB_beam_holder_stl();
       translate([350,120,0]) rotate([0,0,180]) DIYLB_beam_holder_stl();
       translate([350,170,0]) rotate([0,0,180]) DIYLB_beam_holder_stl();
       translate([350,220,0]) rotate([0,0,180]) DIYLB_beam_holder_stl();
    
       //Beams    
       translate([180,aoffs+20,$elevation+2.5]) flatSection(272,center=true);
       translate([180,70,$elevation+2.5])       flatSection(316,center=true);
       translate([180,120,$elevation+2.5])      flatSection(316,center=true);
       translate([180,170,$elevation+2.5])      flatSection(316,center=true);
       translate([180,220,$elevation+2.5])      flatSection(316,center=true);
  
       //Base and bed
       DIYLB_bed_to_columns_assembly();
    }
}

//Top to Columns
//==============
//! 1. Attach the top extrusions to the rest of the frame.
module DIYLB_top_to_columns_assembly() {
    pose([10, 0, 0], [150,150,0])
    assembly("DIYLB_top_to_columns") {

        //Base
        DIYLB_beams_to_bed_assembly();
    
        //Top
        translate([20,0,0]) DIYLB_top_assembly();
        translate([340,$frame_depth,0]) rotate([0,0,180]) DIYLB_top_assembly();
    }
}




//Timing Belt
//===========
//! 1. Insert the timing belt
//! 2. Level the bed by turning the thraded rods, before tightening the pulleys 
module DIYLB_belt_assembly() {
    pose([99,0,75], [200, 100, 28]);

    aoffs = 1 + ($bb_diameter/2);  //Axis offset

    assembly("DIYLB_belt") {

        //Base
        DIYLB_top_to_columns_assembly();
        //DIYLB_Base_assembly();
    
        //Timing belt
        p0=[-58,150];   //Crank
        p1=[-15,140]; //Front idler
        p2=[20+aoffs,20+aoffs];     //Front left pulley
        p3=[340-aoffs,20+aoffs];    //Front right pulley
        p4=[340-aoffs,$frame_depth-20-aoffs];   //Rear right pulley
        p5=[20+aoffs,$frame_depth-20-aoffs];    //Rear left pulley
        p6=[-15,160]; //Rear idler
    
        belt_path = [[p6.x, p6.y, -pulley_pr(GT2x20_plain_idler)],
                    [p5.x, p5.y,  pulley_pr(GT2x20ob_pulley)],
                    [p4.x, p4.y,  pulley_pr(GT2x20ob_pulley)],
                    [p3.x, p3.y,  pulley_pr(GT2x20ob_pulley)],            
                    [p2.x, p2.y,  pulley_pr(GT2x20ob_pulley)],
                    [p1.x, p1.y, -pulley_pr(GT2x20_plain_idler)],
                    [p0.x, p0.y,  pulley_pr(GT2x20ob_pulley)]];
    
        belt = GT2x6;
        translate([0,0,24]) belt(belt, belt_path);
            
        echo(Belt_length=belt_length(belt, belt_path));

    }
}

//! Finished!
module main_assembly() {
    pose([30, 0, 0], [150,150,0])
    assembly("main") {

        DIYLB_belt_assembly();
    }
}

if($preview) {
    
   main_assembly();
}