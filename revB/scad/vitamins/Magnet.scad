//###############################################################################
//# DIY Laser Bed - Magnet                                                      #
//###############################################################################
//#    Copyright 2023 Dirk Heisswolf                                            #
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

module magnet() {
    description = str("Neodym Magnet (D=20,H=4.5)");
    vitamin(str("magnet(): ", description));
    
    color("Silver"){ cylinder(h=4.5,d=19.8); }    
}

//Demo coin
magnet();
