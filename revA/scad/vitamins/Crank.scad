//###############################################################################
//# DIY Laser Bed - Crank                                                       #
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
//#   A crank with an 8mm-shaft.                                                #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 17, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <../DIYLB_Config.scad>

//$explode=1;

module crank ()  {
    description = str("Crank for 8mm shaft");
    vitamin(str("crank(): ", description));

       explode(20) {

        color(grey70) {
            difference() {
                cylinder(6,d=12);
                translate([0,0,-1]) cylinder(8,d=8);
            }
            //rotate([0,0,$t20rot_w*$t])
            translate([7,0,3]) rotate([0,90,0]) screw(M3_grub_screw, 4);
        }
        
        color(grey30) {
            translate([0,0,6])   cylinder(8,d=60);
            translate([0,25,14]) cylinder(20,d=8);
        }
    }
}

if ($preview) {

    //Demo Lock
    crank();
}



