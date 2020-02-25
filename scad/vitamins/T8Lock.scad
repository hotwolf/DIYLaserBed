//###############################################################################
//# DIY Laser Bed - Lock Ring for a T8 Rod                                      #
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
//#   A lock ring for a threaded T8 rod.                                        #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 17, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <../DIYLB_Config.scad>

//$explode = 1;

//Dimensions
$t8lock_width = 6;

module t8lock ()  {//! Draw a lock ring for an 8mm rod
    description = str("Locl ring (8mm)");
    vitamin(str("t8lock(): ", description));

    
   color(grey70)
   difference() {
       cylinder($t8lock_width,d=12);
       translate([0,0,-1]) cylinder($t8lock_width+2,d=8);
   }
   //rotate([0,0,$t20rot_w*$t])
   translate([7,0,$t8lock_width/2]) rotate([0,90,0]) screw(M3_grub_screw, 4);
}

if ($preview) {

    //Demo Lock
    t8lock();
}



