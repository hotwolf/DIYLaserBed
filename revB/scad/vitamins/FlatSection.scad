//###############################################################################
//# DIY Laser Bed - Euro-Cent                                                   #
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
//#   A model of an Euro-Cent coin.                                             #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 17, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
include <../DIYLB_Config.scad>

module flatSection(length=100,center=true) {
    description = str("Flat section 15mmx2mm, ", length, "mm");
    vitamin(str("flatSection(", length, "): ", description));
    
    color("Silver") cube([length,2,15],center=center);    
}

//Demo
//flatSection();
