//###############################################################################
//# DIY Laser Bed - Narrow T8 Nut                                               #
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
//#   A model of a narrow T8 nut.                                               #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 14, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <../DIYLB_Config.scad>

//$explode=1;

module t8nut ()  {
    description = str("T8-Nut (narrow)");
    vitamin(str("t8nut(): ", description));

    explode(-20)
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

if ($preview) {
    
    //Demo T8-nut
    t8nut();
}

