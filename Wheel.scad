//###############################################################################
//# DIY Laser Bed - Wheel                                                       #
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
//#   Model of slider wheels (Openbuilds style).                                #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   February 18, 2020                                                         #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################

//        n        b    w    d      0 
//        a        o    i    i      w
//        m        r    d    a      i
//        e        e    t    m      d
//                      h    .      .
TypeA = ["Type A", 4.9, 10.2, 24,   6];
TypeD = ["Type D", 4.9,  8.8, 15.4, 5];


module wheel(w_type=["Type A", 4.9, 10.2, 24,   6]) {

    bore       = w_type[1];
    width      = w_type[2];
    diameter   = w_type[3];
    trackwidth = w_type[4];
    
                color("grey")
                translate([0,0,0])
                rotate([0,0,0])
                rotate_extrude(angle=360)
                polygon([[bore/2,width/2],
                         [(diameter+trackwidth-width)/2,width/2],
                         [diameter/2,(width-trackwidth)/2],
                         [diameter/2,-(width-trackwidth)/2],
                         [(diameter+trackwidth-width)/2,-width/2],
                         [bore/2,-width/2]]);
 

    
}

//Demo coin
wheel(TypeA);
