//###############################################################################
//# DIY Laser Bed - Configuration                                               #
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
//#   Global configurations for the DIY Laser Bed.                              #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 14, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//#   May 13, 2020                                                              #
//#      - Added toothed idler                                                  #
//#                                                                             #
//###############################################################################
include <../../lib/NopSCADlib/lib.scad>
//include <../../lib/NopSCADlib/core.scad>
include <../../lib/NopSCADlib/vitamins/extrusions.scad>
include <../../lib/NopSCADlib/vitamins/screws.scad>
include <../../lib/NopSCADlib/vitamins/belts.scad>
include <../../lib/NopSCADlib/vitamins/pulleys.scad>
include <../../lib/NopSCADlib/vitamins/ball_bearings.scad>
include <../../lib/NopSCADlib/vitamins/rod.scad>
include <../../lib/NopSCADlib/vitamins/rails.scad>

//Ball bearings
//=============
//               n     b  d   h   c                             
//               a     o  i   e   o                             
//               m     r  a   i   l                             
//               e     e  m   g   o                             
//                        .   h   r                          
//                            t                             
//$bb_type   = ["608", 8, 22, 7, "OrangeRed", 1.4, 2.0]; //Standard 608 bearings
$bb_type     = BB608;                                    //Standard 608 bearings
$bb_height   = $bb_type[3];                              //Ball bearing height
$bb_diameter = $bb_type[2];                              //Ball bearing diameter

//Pulleys
//=======
//
//                                   n       t   o      b       w     h   h    b  f     f    s  s     s              s
//                                   a       e   d      e       i     u   u    o  l     l    c  c     c              c
//                                   m       e          l       d     b   b    r  a     a    r  r     r              r
//                                   e       t          t       t              e  n     n    e  e     e              e
//                                           h                  h     d   l       g     g    w  w     w              w
//                                                                                e     e                            s
//                                                                                           l  z     
//                                                                                d     t             
$i_type  = ["GT2x20_plain_idler",   "GT2",    0, 12.0,  GT2x6,  6.5,  18, 0,   5, 18.0, 1.0, 0, 0,    false,         0];
$ti_type = ["GT2x20_toothed_idler", "GT2",   20, 12.22, GT2x6,  6.5,  18, 0,   5, 18.0, 1.0, 0, 0,    false,         0];
$p_type  = ["GT2x20_pulley",        "GT2OB", 20, 12.22, GT2x6,  7.5,  16, 5.5, 8, 16.0, 1.0, 6, 3.25, M3_grub_screw, 2]; //Standarf GT2 T20 pulley
$p_hubl  = $p_type[7];                                                                                            //Length of the hub
$p_width = $p_type[4]; 

//Dimensions
//==========
$frame_depth = 295;

//Cent coin
//=========
//$cent_thickness = 1.67;
$cent_thickness = 1.9;
$cent_diameter  = 16.4;

//Magnet
//=========
$magnet_thickness = 4.5;
$magnet_diameter  = 19.8;

//Animation
//=========
//$t=0.5;
highest_pos = 70;
lowest_pos  = 27;
$elevation = lowest_pos + (highest_pos-lowest_pos) * 2 * abs($t-0.5);
$rotation  = 180 * (highest_pos-lowest_pos) * 2 * abs($t-0.5);
//$elevation = 30;
//$rotation  = 20;
$vpr = [70, 0, $t * 360];
$vpt = [150,150,30];
$vpd = 1000;


