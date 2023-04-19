//###############################################################################
//# DIY Laser Bed - L-Bracket                                                   #
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
//#   Model of a L-bracket for 20x20 aluminium extrusions.                      #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 13, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <../DIYLB_Config.scad>

//$explode=1;

module lbracket() {//! Draw a L-bracket for a 20x20 aluminium extrusion, including screws
    description = str("L-Bracket (20x20)");
    vitamin(str("lbracket(): ", description));

    //L-Bracket
    color(grey(70)) {

        translate([7,0,-3])
        cube([24,6,4], true);

        translate([10,0,-3])
        cube([14,9,2], true);

        translate([15,0,])
        //cylinder(1,d=4, true);
        screw(M3_grub_screw, 6);

        translate([-3,0,7])
        cube([4,6,24], true);

        translate([-3,0,7])
        cube([2,9,22], true);

        translate([0,0,15])
        rotate([0,90,0])
        //cylinder(1,d=4, true);
        screw(M3_grub_screw, 6);
    }
}

if ($preview) {

    //Demo L-bracket
    lbracket();

    //Demo extrusions
    translate([0,0,-10])   rotate([0,90,0]) extrusion(E2020, 15, center=false);
    translate([-10,0,-20]) rotate([0,0,0])  extrusion(E2020, 40, center=false);
}
